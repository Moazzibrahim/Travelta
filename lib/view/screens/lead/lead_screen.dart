import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/leads/leads_provider.dart';
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
  @override
  void initState() {
    super.initState();
    // Fetch leads when the widget is initialized
    final leadsProvider = Provider.of<LeadsProvider>(context, listen: false);
    leadsProvider.fetchLeads(context);
  }

  @override
  Widget build(BuildContext context) {
    final leadsProvider = Provider.of<LeadsProvider>(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Leads'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      return buildLeadCard(lead);
                    },
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
          buildRow('Role:', lead.role),
          buildRow('Gender:', lead.gender),
          buildRow('Created At:', lead.createdAt),
          buildRowWithBadge(
            'Emergency Phone:',
            lead.emergencyPhone ?? 'N/A',
          ),
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
