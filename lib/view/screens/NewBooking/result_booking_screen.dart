import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/model/result_model.dart';
import 'package:flutter_travelta/view/screens/NewBooking/hotel_details_screen.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/view/widgets/booking_result_container.dart';
import 'package:provider/provider.dart';

class ResultBookingScreen extends StatelessWidget {
  const ResultBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Result Booking'),
      body: Consumer<BookingEngineController>(
        builder: (context, bookingProvider, _) {
          if (!bookingProvider.isLoaded) {
            return Center(
              child: CircularProgressIndicator(color: mainColor),
            );
          } else {
            final List<ResultModel> results = bookingProvider.results;
            if(results.isEmpty){
              return const Center(
                child: Text('No results found'),
              );  
            }else{
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return BookingResultContainer(
                      thumbnail: result.hotelLogo,
                      hotelName: result.hotelName,
                      rating: result.hotelStar,
                      price: result.availableRooms[0].pricings[0].price,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => HotelDetailsScreen(
                                  availableRooms: result.availableRooms,
                                  // hotelImage: result.hotelLogo,
                                  // images: result.images,
                                  // hotelFacilities: result.hotelFacilities,
                                  // hotelFeatures: result.hotelFeatures,
                                  // room: result.availableRooms[0],
                                  // policies: result.hotelPolicies,
                                  // paymentMethods: result.hotelAcceptedCards,
                                )));
                      },
                    );
                  },
                ));
            }
          }
        },
      ),
    );
  }
}
