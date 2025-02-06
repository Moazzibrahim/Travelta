import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final int cartId;
  final double total;

  const CartScreen({required this.cartId, required this.total, super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  String selectedPayment = 'Full Payment';
  DateTime? selectedDate;
  String selectedMethod = '';
  int? selectedMethodId;
  double remainingBalance = 0;
  List<Widget> additionalCards = [];
  List<TextEditingController> amountControllers = [];
  TextEditingController firstPartialAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountControllers.add(TextEditingController());
    firstPartialAmountController.addListener(_calculateRemainingBalance);
  }

  @override
  void dispose() {
    for (var controller in amountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, color: mainColor, size: 30),
                          const SizedBox(width: 12),
                          const Text(
                            'Cart Summary',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 1.2, height: 24),
                      _buildCartDetailRow('Cart ID:', '${widget.cartId}'),
                      const SizedBox(height: 12),
                      _buildCartDetailRow(
                          'Total:', '\$${widget.total.toStringAsFixed(2)}',
                          isTotal: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildPaymentOptions(),
              if (selectedPayment == 'Partial Payment' ||
                  selectedPayment == 'Later Payment') ...[
                const SizedBox(height: 10),
                _buildRemainingBalance(),
              ],
              if (selectedPayment == 'Partial Payment') ...[
                const SizedBox(height: 20),
                TextField(
                  controller: firstPartialAmountController,
                  decoration: InputDecoration(
                    labelText: 'Enter First Payment Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.money),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
              if (selectedPayment != 'Full Payment') ...[
                const SizedBox(height: 20),
                Column(
                  children: List.generate(amountControllers.length, (index) {
                    return Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _createNewAmountInput(index),
                            const SizedBox(height: 10),
                            _buildDatePicker(),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      TextEditingController newController =
                          TextEditingController();
                      newController.addListener(_calculateRemainingBalance);
                      amountControllers.add(newController);
                    });
                  },
                  child: const Text('Add Another Card'),
                ),
              ],
              const SizedBox(height: 20),
              _buildPaymentMethodSection(context), // Section with radio buttons
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);
    final financialAccounts =
        dataListProvider.travelData?.financialAccounting ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Select Payment Method:'),
        const SizedBox(height: 16),
        Column(
          children: [
            ...financialAccounts
                .map((account) => _buildRadioButton(account.name, account.id)),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioButton(String title, int? id) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: selectedMethod,
          onChanged: (value) {
            setState(() {
              selectedMethod = value!;
              selectedMethodId = id;
              log(selectedMethodId.toString());
            });
          },
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _createNewAmountInput(int index) {
    amountControllers[index].addListener(_calculateRemainingBalance);

    return TextField(
      controller: amountControllers[index],
      decoration: InputDecoration(
        labelText: 'Enter Payment Amount',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.money),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildCartDetailRow(String label, String value,
      {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? mainColor : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPaymentTile('Full Payment'),
        _buildPaymentTile('Partial Payment'),
        _buildPaymentTile('Later Payment'),
      ],
    );
  }

  Widget _buildPaymentTile(String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedPayment = title;
          });
        },
        child: Card(
          elevation: selectedPayment == title ? 8 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: selectedPayment == title ? mainColor : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  title == 'Full Payment'
                      ? Icons.payment
                      : title == 'Partial Payment'
                          ? Icons.account_balance_wallet
                          : Icons.schedule,
                  size: 30,
                  color:
                      selectedPayment == title ? Colors.white : Colors.black54,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: selectedPayment == title
                        ? Colors.white
                        : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: mainColor),
            const SizedBox(width: 12),
            Text(
              selectedDate == null
                  ? 'Select Payment Date'
                  : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateRemainingBalance() {
    double amountPaid = 0.0;

    if (selectedPayment == 'Partial Payment') {
      amountPaid += double.tryParse(firstPartialAmountController.text) ?? 0.0;
    }

    for (var controller in amountControllers) {
      amountPaid += double.tryParse(controller.text) ?? 0.0;
    }

    setState(() {
      remainingBalance = widget.total - amountPaid;
    });
  }

  Widget _buildRemainingBalance() {
    _calculateRemainingBalance();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        'Remaining Balance: \$${remainingBalance.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
