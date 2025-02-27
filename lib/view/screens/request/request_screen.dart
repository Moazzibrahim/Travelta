import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/request/request_provider.dart';
import 'package:flutter_travelta/model/request/request_model.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  RequestScreenState createState() => RequestScreenState();
}

class RequestScreenState extends State<RequestScreen> {
  int selectedIndex = 0;
  int selectedTabIndex = 0;
  bool showMore = false;
  int expandedIndex = -1;
  Map<int, bool> expandedItems = {};
  Map<int, Map<int, String>> selectedStages = {};
  Map<int, Map<int, String>> selectedPriorities = {};

  final List<Map<String, dynamic>> options = [
    {'icon': Icons.hotel, 'label': 'Hotels'},
    {'icon': Icons.directions_bus, 'label': 'Buses'},
    {'icon': Icons.monetization_on, 'label': 'Visa'},
    {'icon': Icons.flight, 'label': 'Flight'},
    {'icon': Icons.tour, 'label': 'Tour'},
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final travelProvider =
          Provider.of<TravelProvider>(context, listen: false);
      travelProvider.fetchTravelData(context);
      travelProvider.fetchDealData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Request list'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  options.length,
                  (index) => _buildOption(index),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildToggleRow(),
            const SizedBox(height: 16),
            _buildDetailsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Consumer<TravelProvider>(
      builder: (context, travelProvider, child) {
        if (travelProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (travelProvider.errorMessage.isNotEmpty) {
          return Center(child: Text(travelProvider.errorMessage));
        }

        if (travelProvider.travelData == null) {
          return const Center(child: Text("No data available"));
        }

        TravelSection selectedSection = selectedTabIndex == 0
            ? travelProvider.travelData!.current
            : travelProvider.travelData!.history;

        List<dynamic> selectedList;
        if (selectedIndex == 0) {
          selectedList = selectedSection.hotels;
        } else if (selectedIndex == 1) {
          selectedList = selectedSection.buses;
        } else if (selectedIndex == 2) {
          selectedList = selectedSection.visas;
        } else if (selectedIndex == 3) {
          selectedList = selectedSection.flights;
        } else if (selectedIndex == 4) {
          selectedList = selectedSection.tours;
        } else {
          return const Center(child: Text("No data available for this option"));
        }

        return selectedList.isEmpty
            ? const Center(child: Text("No data found"))
            : Expanded(
                child: ListView.builder(
                  itemCount: selectedList.length,
                  itemBuilder: (context, index) {
                    final item = selectedList[index];
                    bool isExpanded = expandedItems[index] ?? false;

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: mainColor,
                          width: 1,
                        ),
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedIndex == 0
                                  ? (item as Hotel).hotelName
                                  : selectedIndex == 1
                                      ? (item as Bus).busName
                                      : selectedIndex == 2
                                          ? (item as Visa).countryName
                                          : selectedIndex == 3
                                              ? (item as Flight).flightDirection
                                              : (item as Tour).tourName,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            ),
                            const SizedBox(height: 8),
                            if (selectedIndex == 0) ...[
                              buildKeyValue(
                                  "Check-in", (item as Hotel).checkIn),
                              buildKeyValue("Check-out", item.checkOut),
                              buildKeyValue("Room Type", item.roomType),
                              buildKeyValue(
                                  "Room No", item.noNights.toString()),
                              buildKeyValue("Adults", item.noAdults.toString()),
                              buildKeyValue(
                                  "Children", item.noChildren.toString()),
                            ] else if (selectedIndex == 1) ...[
                              buildKeyValue("Route",
                                  "${(item as Bus).from} → ${item.to}"),
                              buildKeyValue(
                                  "Bus No", "${(item).busName}  ${item.busNo}"),
                              buildKeyValue("Driver phone", item.driverPhone),
                              buildKeyValue("Adults", item.noAdults.toString()),
                              buildKeyValue(
                                  "Children", item.noChildren.toString()),
                            ] else if (selectedIndex == 2) ...[
                              buildKeyValue('travelDate', item.travelDate),
                              buildKeyValue('appointment', item.appointment),
                              buildKeyValue('Adults', item.noAdults.toString()),
                              buildKeyValue(
                                  'Children', item.noChildren.toString()),
                            ] else if (selectedIndex == 3) ...[
                              buildKeyValue(
                                  "Flight No", (item as Flight).adultsNo),
                              buildKeyValue('airline', item.airline),
                              buildKeyValue("Class", item.flightClass),
                              buildKeyValue("Departure", item.departure),
                              buildKeyValue("Adults", item.adultsNo.toString()),
                              buildKeyValue(
                                  "Children", item.childrenNo.toString()),
                            ] else if (selectedIndex == 4) ...[
                              buildKeyValue("Tour Type", item.tourType),
                              buildKeyValue(
                                  "Hotels",
                                  item.tourHotels
                                      .map((h) => h.hotelName)
                                      .join(', ')),
                              buildKeyValue(
                                  "Buses",
                                  item.tourBuses
                                      .map((b) => b.transportation)
                                      .join(', ')),
                            ],
                            if (isExpanded && selectedTabIndex == 0) ...[
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButtonFormField<String>(
                                      value: selectedPriorities[selectedIndex]
                                              ?[index] ??
                                          item.priority,
                                      decoration: InputDecoration(
                                        labelText: "Select Priority",
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColor, width: 2),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColor, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColor, width: 2),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                      ),
                                      items: travelProvider.dealData!.priority
                                          .map((priority) {
                                        return DropdownMenuItem(
                                          value: priority,
                                          child: Text(priority,
                                              style: const TextStyle(
                                                  fontSize: 14)),
                                        );
                                      }).toList(),
                                      onChanged: (value) async {
                                        setState(() {
                                          selectedPriorities[selectedIndex] ??=
                                              {};
                                          selectedPriorities[selectedIndex]![
                                              index] = value!;
                                        });

                                        await Provider.of<TravelProvider>(
                                                context,
                                                listen: false)
                                            .postPriority(context,
                                                item.id.toString(), value!);
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    DropdownButtonFormField<String>(
                                      value: selectedStages[selectedIndex]
                                              ?[index] ??
                                          item.stages,
                                      decoration: InputDecoration(
                                        labelText: "Select Stage",
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColor, width: 2),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColor, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: mainColor, width: 2),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 10),
                                      ),
                                      items: travelProvider.dealData!.stages
                                          .map((stage) {
                                        int selectedStageIndex = travelProvider
                                            .dealData!.stages
                                            .indexOf(
                                                selectedStages[selectedIndex]
                                                        ?[index] ??
                                                    item.stages);
                                        int stageIndex = travelProvider
                                            .dealData!.stages
                                            .indexOf(stage);

                                        return DropdownMenuItem(
                                          value: stage,
                                          enabled:
                                              stageIndex >= selectedStageIndex,
                                          child: Text(
                                            stage,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: stageIndex <
                                                      selectedStageIndex
                                                  ? Colors.grey
                                                  : Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedStages[selectedIndex] ??= {};
                                          selectedStages[selectedIndex]![
                                              index] = value!;
                                        });

                                        _showBottomSheet(
                                          context,
                                          value!,
                                          travelProvider.dealData!.adminsAgent,
                                          item.id,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            buildKeyValue(
                                "Price", "${item.revenue} ${item.currency}"),
                            if (selectedTabIndex == 0)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      expandedItems[index] = !isExpanded;
                                    });
                                  },
                                  child: Text(
                                    isExpanded ? "Show Less" : "Show More",
                                    style: TextStyle(
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }

  void _showBottomSheet(BuildContext context, String selectedValue,
      List<AdminAgent> adminAgents, int requestId) {
    TextEditingController resultController = TextEditingController();
    TextEditingController reasonController = TextEditingController();
    TextEditingController codeController = TextEditingController();

    String? selectedAction;
    String? selectedMessageType;
    DateTime? followUpDate;
    AdminAgent? selectedAdminAgent;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedValue == 'Won') ...[
                    const Text(
                      "Code for booking",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: codeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter code",
                      ),
                    ),
                  ] else if (selectedValue == 'Lost') ...[
                    const Text(
                      "Reason for Loss",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: reasonController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter reason",
                      ),
                    ),
                  ] else ...[
                    const Text(
                      "Select Action",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedAction,
                      hint: const Text("Choose an action"),
                      items: ["call", "message", "assign_request"]
                          .map((action) => DropdownMenuItem(
                                value: action,
                                child: Text(action),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedAction = value;
                          if (selectedAction != "message") {
                            selectedMessageType = null;
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    if (selectedAction == "message") ...[
                      const SizedBox(height: 16),
                      const Text(
                        "message Type",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedMessageType,
                        hint: const Text("Choose message type"),
                        items: ["SMS", "WhatsApp"]
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedMessageType = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                    if (selectedAction == "assign_request") ...[
                      const SizedBox(height: 16),
                      const Text(
                        "Select Admin Agent",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<AdminAgent>(
                        value: selectedAdminAgent,
                        hint: const Text("Choose an admin agent"),
                        items: adminAgents
                            .map((agent) => DropdownMenuItem(
                                  value: agent,
                                  child: Text(agent.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAdminAgent = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    const Text(
                      "Follow-up Date",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            followUpDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          followUpDate != null
                              ? DateFormat('yyyy-MM-dd').format(followUpDate!)
                              : "Select a date",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Result",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: resultController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter result",
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final travelProvider =
                            Provider.of<TravelProvider>(context, listen: false);
                        await travelProvider.postStages(
                            context,
                            requestId.toString(),
                            selectedValue,
                            selectedAction,
                            followUpDate,
                            resultController.toString(),
                            selectedMessageType,
                            selectedAdminAgent?.id ?? 0,
                            codeController.toString(),
                            reasonController.toString());
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$key: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton('Current', 0),
        const SizedBox(width: 8),
        _buildToggleButton('History', 1),
      ],
    );
  }

  Widget _buildToggleButton(String label, int index) {
    bool isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? mainColor : Colors.white,
          border: Border.all(color: mainColor),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              options[index]['icon'],
              color: isSelected ? mainColor : Colors.black54,
              size: isSelected ? 30 : 26,
            ),
            const SizedBox(height: 6),
            Text(
              options[index]['label'],
              style: TextStyle(
                color: isSelected ? mainColor : Colors.black54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
