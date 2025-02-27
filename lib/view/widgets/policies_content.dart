import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/result_model.dart';

class PoliciesContent extends StatefulWidget {
  const PoliciesContent(
      {super.key, required this.policies, required this.paymentMethods});
  final List<HotelPolicies> policies;
  final List<HotelAcceptedCards> paymentMethods;

  @override
  State<PoliciesContent> createState() => _PoliciesContentState();
}

class _PoliciesContentState extends State<PoliciesContent> {
  late List<HotelPolicies> policies;

  @override
  void initState() {
    super.initState();
    policies = List.from(widget.policies);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Hotel Policies Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Hotel Policies',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: mainColor),
            ),
          ),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: policies.map((policy) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_parking,
                      size: 20, color: mainColor), // Static icon
                  const SizedBox(width: 5),
                  Text(
                    policy.description,
                    style: TextStyle(fontSize: 14, color: mainColor),
                  ),
                ],
              );
            }).toList(),
          ),

          /// Payment Methods Section
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Payment Methods',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: mainColor),
            ),
          ),
          Column(
              children: List.generate(
            widget.paymentMethods.length,
            (index) {
              return _buildPaymentOption(
                  Icons.credit_card, widget.paymentMethods[index].cardName);
            },
          )),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: mainColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: mainColor),
            ),
          ),
        ],
      ),
    );
  }
}
