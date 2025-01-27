import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_travelta/constants/colors.dart';
import 'package:flutter_travelta/controllers/supplier_controller.dart';
import 'package:flutter_travelta/view/widgets/appbar_widget.dart';
import 'package:flutter_travelta/view/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

class AddSupplierScreen extends StatefulWidget {
  const AddSupplierScreen({super.key});

  @override
  State<AddSupplierScreen> createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  String selectedService = '';
  int? selectedIds;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController agentController = TextEditingController();
  final TextEditingController adminNameController = TextEditingController();
  final TextEditingController adminPhoneController = TextEditingController();
  final TextEditingController adminEmailController = TextEditingController();
  final List<TextEditingController> emailControllers = [];
  final List<TextEditingController> phoneControllers = [];

  void addDynamicField(List<TextEditingController> controllers) {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void removeDynamicField(List<TextEditingController> controllers, int index) {
    setState(() {
      controllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    agentController.dispose();
    adminNameController.dispose();
    adminPhoneController.dispose();
    adminEmailController.dispose();
    for (var controller in emailControllers) {
      controller.dispose();
    }
    for (var controller in phoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Supplier'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField("Agent", "Enter agent name", agentController),
                const SizedBox(height: 16),
                buildTextField(
                    "Admin Name", "Enter admin name", adminNameController),
                const SizedBox(height: 16),
                buildTextField(
                    "Admin Phone", "Enter admin phone", adminPhoneController),
                const SizedBox(height: 16),
                buildTextField(
                    "Admin Email", "Enter admin email", adminEmailController),
                const SizedBox(height: 16),
                Consumer<SupplierController>(
                  builder: (context, supplierController, _) {
                    final services = supplierController.services;

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Service',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: services.map((service) {
                        return DropdownMenuItem<String>(
                          value: service.name,
                          child: Text(service.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedService = value!;
                          // selectedIds.add(services.firstWhere((service) => service.name == value).id);
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                buildDynamicFields("Emails", emailControllers),
                const SizedBox(height: 24),
                buildDynamicFields("Phones", phoneControllers),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: (){

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Add Supplier",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, String hint, TextEditingController controller) {
    return TextFormField(
      cursorColor: mainColor,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mainColor),
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        return null;
      },
    );
  }

  Widget buildDynamicFields(
      String label, List<TextEditingController> controllers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        ...List.generate(controllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: buildTextField(
                    "$label ${index + 1}",
                    "Enter $label",
                    controllers[index],
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => removeDynamicField(controllers, index),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          );
        }),
        TextButton.icon(
          onPressed: () => addDynamicField(controllers),
          icon: Icon(Icons.add, color: mainColor),
          label: Text(
            "Add",
            style: TextStyle(color: mainColor),
          ),
        ),
      ],
    );
  }
}
