import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/model/manual_booking/flight_model.dart';
import 'package:flutter_travelta/view/widgets/datepicker_widget.dart';
import 'package:flutter_travelta/view/widgets/dropdown_widget.dart';
import 'package:flutter_travelta/view/widgets/textfield_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FlightWidget extends StatefulWidget {
  const FlightWidget({super.key});

  @override
  State<FlightWidget> createState() => _FlightWidgetState();
}

class _FlightWidgetState extends State<FlightWidget> {
  int adultsNumber = 0;
  int childrenNumber = 0;
  final List<Map<String, dynamic>> adultsDetails = [];
  final List<Map<String, dynamic>> childrenDetails = [];
  FlightDetails flightDetails = FlightDetails();

  List<String> fromLocations = [];
  List<String> toLocations = [];

  @override
  Widget build(BuildContext context) {
    final dataListProvider = Provider.of<DataListProvider>(context);
    final FlightDetails = dataListProvider.busDetails;

    return SingleChildScrollView(
      child: Column(
        children: [
          CustomDropdownField(
            label: 'Select flight class:',
            items: const [
              DropdownMenuItem(
                  value: 'Economy Class', child: Text('Economy Class')),
              DropdownMenuItem(
                  value: 'First Class', child: Text('First Class')),
              DropdownMenuItem(
                  value: 'Business Class', child: Text('Business Class')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  flightDetails.flightClass = value;
                  dataListProvider.saveflight(flightDetails);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          CustomDropdownField(
            label: 'Select flight type:',
            items: const [
              DropdownMenuItem(value: 'domestic', child: Text('Domestic')),
              DropdownMenuItem(
                  value: 'international', child: Text('International')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  flightDetails.flightType = value;
                  dataListProvider.saveflight(flightDetails);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          CustomDropdownField(
            label: 'Select flight direction:',
            items: const [
              DropdownMenuItem(value: 'one_way', child: Text('One Way')),
              DropdownMenuItem(value: 'multi_city', child: Text('Return')),
              DropdownMenuItem(value: 'round_trip', child: Text('Round')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  flightDetails.flightDirection = value;
                  dataListProvider.saveflight(flightDetails);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          if (flightDetails.flightDirection == 'one_way' ||
              flightDetails.flightDirection == 'multi_city') ...[
            CustomTextField(
              label: 'From',
              onChanged: (value) {
                setState(() {
                  flightDetails.fromLocation = value;
                  dataListProvider.saveflight(flightDetails);
                });
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'To',
              onChanged: (value) {
                setState(() {
                  flightDetails.toLocation = value;
                  dataListProvider.saveflight(flightDetails);
                });
              },
            ),
          ],
          if (flightDetails.flightDirection == 'round_trip') ...[
            for (int i = 0; i < fromLocations.length; i++) ...[
              CustomTextField(
                label: 'From ${i + 1}',
                onChanged: (value) {
                  setState(() {
                    fromLocations[i] = value;
                    dataListProvider.saveflight(flightDetails);
                  });
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'To ${i + 1}',
                onChanged: (value) {
                  setState(() {
                    toLocations[i] = value;
                    dataListProvider.saveflight(flightDetails);
                  });
                },
              ),
              const SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: () {
                setState(() {
                  fromLocations.add('');
                  toLocations.add('');
                  dataListProvider.saveflight(flightDetails);
                });
              },
              child: const Text('Add another location'),
            ),
          ],
          const SizedBox(height: 16),
          CustomDatePickerTextField(
            showTimePickerOption: true,
            label: 'departure Date & Time',
            icon: Icons.calendar_today,
            dateFormat: DateFormat('yyyy/MM/dd HH:mm'),
            onDateSelected: (date) {
              setState(() {
                flightDetails.checkInDate = date;
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          const SizedBox(height: 10),
          CustomDatePickerTextField(
              showTimePickerOption: true,
              label: 'Arrival Date & Time',
              icon: Icons.calendar_today,
              dateFormat: DateFormat('yyyy/MM/dd HH:mm'),
              onDateSelected: (dateTimeString) {
                DateTime parsedDate =
                    DateFormat('dd/MM/yyyy HH:mm').parse(dateTimeString);
                setState(() {
                  flightDetails.arrivalDate = parsedDate;
                  dataListProvider.saveflight(flightDetails);
                });
              }),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Adults Number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                int inputNumber = int.tryParse(value) ?? 0;
                adultsNumber = inputNumber.clamp(1, 9);
                flightDetails.adultsNumber = adultsNumber;
                if (adultsNumber > adultsDetails.length) {
                  adultsDetails.addAll(List<Map<String, dynamic>>.generate(
                    adultsNumber - adultsDetails.length,
                    (_) =>
                        {"gender": null, "firstName": null, "lastName": null},
                  ));
                } else {
                  adultsDetails.removeRange(adultsNumber, adultsDetails.length);
                }
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          if (adultsNumber > 0)
            AdultDetailsList(
              count: adultsNumber,
              details: adultsDetails,
              onDetailChanged: (index, key, value) {
                setState(() {
                  adultsDetails[index][key] = value;
                  flightDetails.adultsDetails = List.from(adultsDetails);
                  dataListProvider.saveflight(flightDetails);
                });
              },
            ),
          CustomTextField(
            label: 'Adults Price',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                flightDetails.adultsPrice = int.tryParse(value);
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          CustomTextField(
            label: 'Children Number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                int inputNumber = int.tryParse(value) ?? 0;
                childrenNumber = inputNumber.clamp(1, 9);
                flightDetails.childrenNumber = childrenNumber;
                if (childrenNumber > childrenDetails.length) {
                  childrenDetails.addAll(List<Map<String, dynamic>>.generate(
                    childrenNumber - childrenDetails.length,
                    (_) => {"age": null},
                  ));
                } else {
                  childrenDetails.removeRange(
                      childrenNumber, childrenDetails.length);
                }
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          if (childrenNumber > 0)
            ChildDetailsList(
              count: childrenNumber,
              details: childrenDetails,
              onDetailChanged: (index, field, value) {
                setState(() {
                  childrenDetails[index][field] = value;
                  flightDetails.childrenDetails = List.from(childrenDetails);
                  dataListProvider.saveflight(flightDetails);
                });
              },
            ),
          CustomTextField(
            label: 'Children Price',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                flightDetails.childrenPrice = int.tryParse(value);
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Infant Number',
            isNumeric: true,
            onChanged: (value) {
              setState(() {
                flightDetails.infantNumber = int.tryParse(value);
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Airline',
            onChanged: (value) {
              setState(() {
                flightDetails.airline = value;
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Ticket Number',
            onChanged: (value) {
              setState(() {
                flightDetails.ticketNumber = value;
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'Ref BNR',
            onChanged: (value) {
              setState(() {
                flightDetails.refBNR = value;
                dataListProvider.saveflight(flightDetails);
              });
            },
          ),
        ],
      ),
    );
  }
}
