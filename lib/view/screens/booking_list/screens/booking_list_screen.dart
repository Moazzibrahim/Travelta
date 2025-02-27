import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_list_controller.dart';
import 'package:flutter_travelta/view/screens/booking_list/widgets/booking_list_view.dart';
import 'package:provider/provider.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: mainColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: mainColor,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Current'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: Consumer<BookingListController>(
        builder: (context, bookingListProvider, _) {
          if(!bookingListProvider.isLoaded){
            return Center(
              child: CircularProgressIndicator(color: mainColor,),
            );
          }else{
            return TabBarView(
              controller: _tabController,
              children: [
                BookingListView(upcomingBookingList: bookingListProvider.upcomingBookingList,),
                BookingListView(currentBookingList: bookingListProvider.currentBookingList,),
                BookingListView(pastBookingList: bookingListProvider.pastBookingList,),
              ],
            );
          }
        },
      ),
    );
  }
}