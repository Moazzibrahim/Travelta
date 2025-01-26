class TravelData {
  final List<City> cities;
  final List<Country> countries;
  final List<Service> services;
  final List<Currency> currencies;
  final List<String> adultTitles;
  final List<FinancialAccounting> financialAccounting;
  final List<Tax> taxes;
  final List<Customer> customers; // Added customers
  final List<Supplier> suppliers; // Added suppliers

  TravelData({
    required this.cities,
    required this.countries,
    required this.services,
    required this.currencies,
    required this.adultTitles,
    required this.financialAccounting,
    required this.taxes,
    required this.customers,
    required this.suppliers,
  });

  factory TravelData.fromJson(Map<String, dynamic> json) {
    return TravelData(
      cities: (json['cities'] as List).map((e) => City.fromJson(e)).toList(),
      countries:
          (json['contries'] as List).map((e) => Country.fromJson(e)).toList(),
      services:
          (json['services'] as List).map((e) => Service.fromJson(e)).toList(),
      currencies: (json['currencies'] as List)
          .map((e) => Currency.fromJson(e))
          .toList(),
      adultTitles: List<String>.from(json['adult_title']),
      financialAccounting: (json['financial_accounting'] as List)
          .map((e) => FinancialAccounting.fromJson(e))
          .toList(),
      taxes: (json['taxes'] as List).map((e) => Tax.fromJson(e)).toList(),
      customers: (json['customers'] as List)
          .map((e) => Customer.fromJson(e))
          .toList(), // Parse customers
      suppliers: (json['suppliers'] as List)
          .map((e) => Supplier.fromJson(e))
          .toList(), // Parse suppliers
    );
  }
}

class Customer {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String createdAt;
  final String updatedAt;
  final String emergencyPhone;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
    required this.emergencyPhone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      gender: json['gender'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      emergencyPhone: json['emergency_phone'],
    );
  }
}

class Supplier {
  final int id;
  final String? agent;
  final String name;

  Supplier({
    required this.id,
    required this.agent,
    required this.name,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      agent: json['agent'],
      name: json['name'],
    );
  }
}

class Country {
  final int id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Tax {
  final int id;
  final String name;
  final int countryId;
  final int agentId;
  final int? affiliateId;
  final String type;
  final double amount;

  Tax({
    required this.id,
    required this.name,
    required this.countryId,
    required this.agentId,
    this.affiliateId,
    required this.type,
    required this.amount,
  });

  factory Tax.fromJson(Map<String, dynamic> json) {
    return Tax(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
      agentId: json['agent_id'],
      affiliateId: json['affilate_id'],
      type: json['type'],
      amount: json['amount'].toDouble(),
    );
  }
}

class Service {
  final int id;
  final String serviceName;
  final String? description;
  final List<Supplier> suppliers;

  Service({
    required this.id,
    required this.serviceName,
    this.description,
    required this.suppliers,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      serviceName: json['service_name'],
      description: json['description'],
      suppliers:
          (json['suppliers'] as List).map((e) => Supplier.fromJson(e)).toList(),
    );
  }
}

class Currency {
  final int id;
  final String name;

  Currency({
    required this.id,
    required this.name,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
    );
  }
}

class FinancialAccounting {
  final int id;
  final String name;
  final String details;
  final double balance;
  final int currencyId;
  final int? affiliateId;
  final int agentId;
  final int status;
  final String logo;
  final String createdAt;
  final String updatedAt;
  final String logoLink;

  FinancialAccounting({
    required this.id,
    required this.name,
    required this.details,
    required this.balance,
    required this.currencyId,
    this.affiliateId,
    required this.agentId,
    required this.status,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
    required this.logoLink,
  });

  factory FinancialAccounting.fromJson(Map<String, dynamic> json) {
    return FinancialAccounting(
      id: json['id'],
      name: json['name'],
      details: json['details'],
      balance: json['balance'].toDouble(),
      currencyId: json['currency_id'],
      affiliateId: json['affilate_id'],
      agentId: json['agent_id'],
      status: json['status'],
      logo: json['logo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      logoLink: json['logo_link'],
    );
  }
}

class City {
  final int id;
  final String name;
  final int countryId;

  City({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      countryId: json['country_id'],
    );
  }
}
