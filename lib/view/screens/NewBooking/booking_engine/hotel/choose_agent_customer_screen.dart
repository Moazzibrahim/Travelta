import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:provider/provider.dart';

class ChooseAgentCustomerScreen extends StatefulWidget {
  const ChooseAgentCustomerScreen({super.key});

  @override
  State<ChooseAgentCustomerScreen> createState() =>
      _ChooseAgentCustomerScreenState();
}

class _ChooseAgentCustomerScreenState extends State<ChooseAgentCustomerScreen> {
  int? selectedAgentIndex;
  int? selectedCustomerIndex;

  @override
  void initState() {
    super.initState();
    final bookingProvider =
        Provider.of<BookingEngineController>(context, listen: false);
    bookingProvider.fetchAgents(context);
    bookingProvider.fetchCustomers(context);
  }

  void _onAgentSelected(int index) {
    setState(() {
      if (selectedAgentIndex == index) {
        selectedAgentIndex = null; // Deselect agent
      } else {
        selectedAgentIndex = index;
        selectedCustomerIndex = null; // Deselect customer when an agent is selected
      }
    });
  }

  void _onCustomerSelected(int index) {
    setState(() {
      if (selectedCustomerIndex == index) {
        selectedCustomerIndex = null; // Deselect customer
      } else {
        selectedCustomerIndex = index;
        selectedAgentIndex = null; // Deselect agent when a customer is selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
              color: mainColor,
            ),
            backgroundColor: Colors.white,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Agent'),
                Tab(text: 'Customer'),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    Consumer<BookingEngineController>(
                      builder: (context, bookingProvider, _) {
                        if (!bookingProvider.isAgentsLoaded) {
                          return Center(
                            child: CircularProgressIndicator(color: mainColor),
                          );
                        }
                        return ListView.builder(
                          itemCount: bookingProvider.agents.length,
                          itemBuilder: (context, index) {
                            final agent = bookingProvider.agents[index];
                            return ListTile(
                              title: Text(agent.name),
                              subtitle: Text(agent.email),
                              trailing: Checkbox(
                                value: selectedAgentIndex == index,
                                onChanged: (selectedCustomerIndex == null)
                                    ? (value) => _onAgentSelected(index)
                                    : null, // Disable if customer is selected
                                activeColor: mainColor,
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Consumer<BookingEngineController>(
                      builder: (context, bookingProvider, _) {
                        if (!bookingProvider.isCustomersLoaded) {
                          return Center(
                            child: CircularProgressIndicator(color: mainColor),
                          );
                        }
                        return ListView.builder(
                          itemCount: bookingProvider.customers.length,
                          itemBuilder: (context, index) {
                            final customer = bookingProvider.customers[index];
                            return ListTile(
                              title: Text(customer.name),
                              subtitle: Text(customer.email),
                              trailing: Checkbox(
                                value: selectedCustomerIndex == index,
                                onChanged: (selectedAgentIndex == null)
                                    ? (value) => _onCustomerSelected(index)
                                    : null, // Disable if agent is selected
                                activeColor: mainColor,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (selectedAgentIndex != null ||
                          selectedCustomerIndex != null)
                      ? () {
                          final bookingProvider =
                              Provider.of<BookingEngineController>(context,listen: false);
                          if (selectedAgentIndex != null) {
                            bookingProvider.bookRoom.toAgentId =
                                bookingProvider.agents[selectedAgentIndex!].id;
                          } else if (selectedCustomerIndex != null) {
                            bookingProvider.bookRoom.toCustomerId =
                                bookingProvider
                                    .customers[selectedCustomerIndex!].id;
                          }
                          bookingProvider.postBookRoom(context);
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (selectedAgentIndex != null ||
                            selectedCustomerIndex != null)
                        ? mainColor
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Reserve',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
