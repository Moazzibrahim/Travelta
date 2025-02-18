import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_list_controller.dart';
import 'package:provider/provider.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  void initState() {
    Provider.of<BookingListController>(context,listen: false).fetchBookingList(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking List'),
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back,color: mainColor,)),
      ),
      body: Consumer<BookingListController>(
        builder: (context, bookingListProvider, _) {
          if(!bookingListProvider.isLoaded){
            return Center(
              child: CircularProgressIndicator(color: mainColor,),
            );
          }else{
            return const Center(
              child: Text('Ahla booking list'),
            );
          }
        },
      ),
    );
  }
}