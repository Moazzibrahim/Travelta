import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/model/booking_list/booking_list_details.dart';

class PaymentsContainer extends StatelessWidget {
  const PaymentsContainer({super.key, required this.bookingListDetails});
  final BookingListDetails bookingListDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payments',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: mainColor),
        ),
        const SizedBox(height: 16),
        ...List.generate(
          bookingListDetails.payments.length,
          (index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 8,
              ),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.3,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Payments Details',
                        style: TextStyle(fontSize: 20, color: mainColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount:',
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                      Text(
                        bookingListDetails.payments[index].amount.toString(),
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date:',
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                      Text(
                        bookingListDetails.payments[index].date,
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Code:',
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                      Text(
                        bookingListDetails.payments[index].code,
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Method:',
                        style: TextStyle(color: mainColor, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            bookingListDetails.payments[index].financial.name,
                            style: TextStyle(color: mainColor, fontSize: 16),
                          ),
                          bookingListDetails
                                      .payments[index].financial.logoLink ==
                                  null
                              ? const SizedBox()
                              : Image.network(
                                  bookingListDetails
                                      .payments[index].financial.logoLink!,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                  color: mainColor,
                                ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
