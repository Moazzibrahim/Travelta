import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:provider/provider.dart';

class LastBookTourScreen extends StatefulWidget {
  final Map<String, dynamic> tour;
  final int adultsCount;

  const LastBookTourScreen(
      {super.key, required this.tour, required this.adultsCount});

  @override
  LastBookTourScreenState createState() => LastBookTourScreenState();
}

class LastBookTourScreenState extends State<LastBookTourScreen> {
  String? selectedAgent;
  String? selectedCustomer;
  int? selectedAgentId;
  int? selectedCustomerId;
  TextEditingController agentSearchController = TextEditingController();
  TextEditingController customerSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bookingProvider =
        Provider.of<BookingEngineController>(context, listen: false);
    bookingProvider.fetchCustomers(context);
    bookingProvider.fetchAgents(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Select Agent & Customer',
          bottom: TabBar(
            tabs: [
              Tab(text: "Agents"),
              Tab(text: "Customers"),
            ],
          ),
        ),
        body: Consumer<BookingEngineController>(
          builder: (context, bookingProvider, child) {
            return Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildSelectionList(
                        title: "Search Agents",
                        controller: agentSearchController,
                        items: bookingProvider.isAgentsLoaded
                            ? bookingProvider.agents
                            : [],
                        selectedItem: selectedAgent,
                        onSelect: (int agentId) =>
                            setState(() => selectedAgentId = agentId),
                      ),
                      _buildSelectionList(
                        title: "Search Customers",
                        controller: customerSearchController,
                        items: bookingProvider.isCustomersLoaded
                            ? bookingProvider.customers
                            : [],
                        selectedItem: selectedCustomer,
                        onSelect: (int customerId) =>
                            setState(() => selectedCustomerId = customerId),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final bookingProvider =
                          Provider.of<BookingEngineController>(context,
                              listen: false);

                      await bookingProvider.booktour(
                        context,
                        agentsId: selectedAgentId.toString(),
                        customerId: selectedCustomerId.toString(),
                        noOfPeople: widget.adultsCount,
                        tourId: widget.tour['id'],
                        currencyId: widget.tour['tour_pricing_items'][0]
                            ['currency']['id'],
                        toHotelId: widget.tour['tour_hotels'][0]['id'],
                        totalPrice: bookingProvider.tourBooking.totalPrice,
                        singleRoomCount:
                            bookingProvider.tourBooking.singleRoomCount,
                        doubleRoomCount:
                            bookingProvider.tourBooking.doubleRoomCount,
                        tripleRoomCount:
                            bookingProvider.tourBooking.tripleRoomCount,
                        quadRoomCount:
                            bookingProvider.tourBooking.quadRoomCount,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Confirm booking"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSelectionList({
    required String title,
    required TextEditingController controller,
    required List<dynamic> items,
    required String? selectedItem,
    required Function(int) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            controller: controller,
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              labelText: title,
              prefixIcon: Icon(Icons.search, color: mainColor),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        controller.clear();
                        setState(() {});
                      },
                    )
                  : null,
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: items.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    String name = items[index].name;
                    String phone = items[index].phone;
                    int id = items[index].id; // Ensure ID is an int
                    bool matchesSearch = name
                            .toLowerCase()
                            .contains(controller.text.toLowerCase()) ||
                        phone.contains(controller.text);

                    if (!matchesSearch) return const SizedBox.shrink();

                    bool isSelected = id == selectedAgentId ||
                        id == selectedCustomerId; // Check selection by ID

                    return GestureDetector(
                      onTap: () => onSelect(id), // Pass int ID
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? mainColor.withOpacity(0.15)
                              : Colors.white,
                          border: Border.all(
                              color:
                                  isSelected ? mainColor : Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: mainColor.withOpacity(0.2),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: mainColor.withOpacity(0.1),
                              child: Text(
                                name[0].toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: mainColor),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isSelected ? mainColor : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    phone,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(Icons.check_circle, color: mainColor),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    "No results found",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
        ),
      ],
    );
  }
}
