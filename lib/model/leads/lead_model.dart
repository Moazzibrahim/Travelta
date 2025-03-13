class LeadModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String createdAt;
  final String? emergencyPhone;
  final String agentSalesName;
  final String agentSalesDep;
  final String serviceName;
  final String country;
  final String city;
  final String stages;
  final String priority;
  final String wpNum;


  LeadModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.createdAt,
    this.emergencyPhone,
    required this.agentSalesName,
    required this.agentSalesDep,
    required this.serviceName,
    required this.country,
    required this.city,
    required this.stages,
    required this.priority,
    required this.wpNum
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      createdAt: json['created_at'],
      emergencyPhone: json['emergency_phone'],
      agentSalesName: json['agent_sales']['name'],
      agentSalesDep: json['agent_sales']['department']['name'],
      serviceName: json['service']['service_name'],
      country: json['country']['name'],
      city: json['city']['name'],
      stages: json['stages'] ?? 'N/A',
      priority: json['priority'] ?? 'N/A',
      wpNum: json['watts'] ?? 'N/A',
    );
  }
}

class LeadsResponse {
  final List<LeadModel> leads;

  LeadsResponse({required this.leads});

  factory LeadsResponse.fromJson(Map<String, dynamic> json) {
    return LeadsResponse(
      leads: List<LeadModel>.from(
        json['leads'].map((lead) => LeadModel.fromJson(lead)),
      ),
    );
  }
}
