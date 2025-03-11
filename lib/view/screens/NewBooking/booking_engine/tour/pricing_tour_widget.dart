import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/model/book_tour.dart';
import 'package:provider/provider.dart';

class TourPricingScreen extends StatefulWidget {
  final Map<String, dynamic> tour;
  final int adultsCount;

  const TourPricingScreen({
    super.key,
    required this.tour,
    required this.adultsCount,
  });

  @override
  TourPricingScreenState createState() => TourPricingScreenState();
}

class TourPricingScreenState extends State<TourPricingScreen> {
  Map<int, int> itemCounts = {};
  double totalPrice = 0.0;
  double appliedDiscount = 0.0;
  late TourBooking tourBooking;

  @override
  void initState() {
    super.initState();
    _applyDiscountIfEligible();

    tourBooking = TourBooking(
      adultsCount: widget.adultsCount,
      totalPrice: totalPrice,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingEngineController>(context, listen: false)
          .updateTotalPrice(totalPrice);
    });
  }

  void _updateTotalPrice(double priceChange) {
    setState(() {
      totalPrice += priceChange;
      tourBooking.totalPrice = totalPrice;
      Provider.of<BookingEngineController>(context, listen: false)
          .updateTotalPrice(totalPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: _buildPricingSection())),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Total: \$${tourBooking.totalPrice!.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
                if (appliedDiscount > 0)
                  Text(
                    "Discount Applied: -\$${appliedDiscount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraItemRow(Map<String, dynamic> extra) {
    int id = extra['id'];
    double price = extra['price'].toDouble();
    itemCounts.putIfAbsent(id, () => 0);

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${extra['name']} - ${extra['price']} ${extra['currency']['name']}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.red),
                  onPressed: () {
                    if (itemCounts[id]! > 0) {
                      setState(() {
                        itemCounts[id] = itemCounts[id]! - 1;
                      });
                      _updateTotalPrice(-price);
                    }
                  },
                ),
                Text(
                  "${itemCounts[id]}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: mainColor),
                  onPressed: () {
                    setState(() {
                      itemCounts[id] = itemCounts[id]! + 1;
                    });
                    _updateTotalPrice(price);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingItemRow(Map<String, dynamic> item) {
    int id = item['id'];
    double priceAfterTax = item['price_after_tax']?.toDouble() ?? 0.0;
    String roomType = item['type'].toString().toLowerCase();

    itemCounts[id] ??= 0;

    return Consumer<BookingEngineController>(
      builder: (context, bookingController, child) {
        return Card(
          color: Colors.white,
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "${item['type']} - ${item['price_after_tax']} ${item['currency']?['name'] ?? ''}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.red),
                      onPressed: () {
                        if (itemCounts[id]! > 0) {
                          setState(() {
                            itemCounts[id] = itemCounts[id]! - 1;
                          });
                          _updateTotalPrice(-priceAfterTax);
                          bookingController.updateRoomCount(
                              roomType, itemCounts[id]!);
                        }
                      },
                    ),
                    Text(
                      "${itemCounts[id]}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: mainColor),
                      onPressed: () {
                        setState(() {
                          itemCounts[id] = itemCounts[id]! + 1;
                        });
                        _updateTotalPrice(priceAfterTax);
                        bookingController.updateRoomCount(
                            roomType, itemCounts[id]!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPricingSection() {
    List<dynamic> pricingItems = widget.tour['tour_pricing_items'] ?? [];
    List<dynamic> extras = widget.tour['tour_extras'] ?? [];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          for (var item in pricingItems)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildPricingItemRow(item),
            ),
          const SizedBox(height: 20),
          const Text(
            "Extras",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          for (var extra in extras) _buildExtraItemRow(extra),
        ],
      ),
    );
  }

  void _applyDiscountIfEligible() {
    List<dynamic> discounts = widget.tour['tour_discounts'] ?? [];

    for (var discount in discounts) {
      int from = discount['from'];
      int to = discount['to'];
      double discountAmount = discount['discount']?.toDouble() ?? 0.0;

      if (widget.adultsCount >= from && widget.adultsCount <= to) {
        setState(() {
          appliedDiscount = discountAmount;
        });
        break;
      }
    }
  }
}
