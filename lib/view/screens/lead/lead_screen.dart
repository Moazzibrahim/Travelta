import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/leads/leads_provider.dart';
import 'package:flutter_travelta/view/screens/lead/add_lead_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/model/leads/lead_model.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  LeadScreenState createState() => LeadScreenState();
}

class LeadScreenState extends State<LeadScreen> {
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<LeadsProvider>(context, listen: false).fetchLeads(context);
    });
  }

  String formatDate(String dateTime) {
    try {
      final DateTime parsedDate = DateTime.parse(dateTime);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final leadsProvider = Provider.of<LeadsProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Leads',
        action: IconButton(onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddLeadScreen(),
            )
          );
        }, icon: Icon(Icons.add, color: mainColor,),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: mainColor,
              decoration: InputDecoration(
                labelText: 'Search by name or phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: mainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: mainColor),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: leadsProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : leadsProvider.errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(leadsProvider.errorMessage!),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  // Retry fetching leads
                                  setState(() {
                                    leadsProvider.fetchLeads(context);
                                  });
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: leadsProvider.leads.length,
                          itemBuilder: (context, index) {
                            final lead = leadsProvider.leads[index];
                            if (lead.name.toLowerCase().contains(searchQuery) ||
                                lead.phone
                                    .toLowerCase()
                                    .contains(searchQuery)) {
                              return buildLeadCard(lead);
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeadCard(LeadModel lead) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: secondColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildRow('Name:', lead.name),
          buildRow('Email:', lead.email),
          buildRow('Phone Number:', lead.phone),
          buildRow('Whatsapp Number:', lead.wpNum),
          buildRow('Role:', 'Lead'),
          buildRow('Gender:', lead.gender),
          buildRow('Created At:', formatDate(lead.createdAt)),
          buildRowWithBadge(
            'Emergency Phone:',
            lead.emergencyPhone ?? 'N/A',
          ),
          buildRow("country:", lead.country),
          buildRow('city', lead.city),
          buildRow('stage', lead.stages),
          buildRow('Priority', lead.priority),
          buildRow('Service', lead.serviceName),
          buildRow(
              'Agent sales', '${lead.agentSalesName} | ${lead.agentSalesDep}'),
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRowWithBadge(String label, String value) {
    final isEmergencyAvailable = value != 'N/A';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isEmergencyAvailable ? Colors.green[100] : Colors.red[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: isEmergencyAvailable ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
