class LeadModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String createdAt;
  final String updatedAt;
  final String? emergencyPhone;
  final String role;

  LeadModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    this.emergencyPhone,
    required this.role,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      emergencyPhone: json['emergency_phone'],
      role: json['role'],
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