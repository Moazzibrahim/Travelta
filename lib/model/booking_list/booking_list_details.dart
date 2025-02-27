class BookingListDetails {
  final Traveler traveler;
  final List<Payment> payments;
  final Actions actions;
  final AgentData agentData;

  BookingListDetails({
    required this.traveler,
    required this.payments,
    required this.actions,
    required this.agentData,
  });

  factory BookingListDetails.fromJson(Map<String, dynamic> json) {
    return BookingListDetails(
      traveler: Traveler.fromJson(json['traveler']),
      payments: (json['payments'] as List).map((e) => Payment.fromJson(e)).toList(),
      actions: Actions.fromJson(json['actions']),
      agentData: AgentData.fromJson(json['agent_data']),
    );
  }
}

class Traveler {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String position;

  Traveler({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.position,
  });

  factory Traveler.fromJson(Map<String, dynamic> json) {
    return Traveler(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      position: json['position'],
    );
  }
}

class Payment {
  final int id;
  final int manuelBookingId;
  final int? financialId;
  final int amount;
  final String date;
  final String code;
  final int? supplierId;
  final int? agentId;
  final int? affilateId;
  final Financial financial;

  Payment({
    required this.id,
    required this.manuelBookingId,
    required this.financialId,
    required this.amount,
    required this.date,
    required this.code,
    this.supplierId,
    this.agentId,
    this.affilateId,
    required this.financial,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
  return Payment(
    id: json['id'],
    manuelBookingId: json['manuel_booking_id'],
    financialId: json['financial_id'] ?? 0,
    amount: json['amount'],
    date: json['date'],
    code: json['code'],
    supplierId: json['supplier_id'],
    agentId: json['agent_id'],
    affilateId: json['affilate_id'],
    financial: json['financial'] != null
        ? Financial.fromJson(json['financial'])
        : Financial(id: 0, name: 'Unknown', logoLink: null), // Provide default values
  );
}

}

class Financial {
  final int id;
  final String name;
  final String? logoLink;

  Financial({
    required this.id,
    required this.name,
    this.logoLink,
  });

  factory Financial.fromJson(Map<String, dynamic> json) {
    return Financial(
      id: json['id'],
      name: json['name'],
      logoLink: json['logo_link'],
    );
  }
}

class Actions {
  final List<Confirmed> confirmed;
  final List<Vouchered> vouchered;
  final List<Canceled> canceled;

  Actions({
    required this.confirmed,
    required this.vouchered,
    required this.canceled,
  });

  factory Actions.fromJson(Map<String, dynamic> json) {
    return Actions(
      confirmed: (json['confirmed'] as List).map((e) => Confirmed.fromJson(e)).toList(),
      vouchered: (json['vouchered'] as List).map((e) => Vouchered.fromJson(e)).toList(),
      canceled: (json['canceled'] as List).map((e) => Canceled.fromJson(e)).toList(),
    );
  }
}

class Confirmed {
  final int id;
  final int manuelBookingId;
  final int confirmed;
  final List<Deposit> deposits;

  Confirmed({
    required this.id,
    required this.manuelBookingId,
    required this.confirmed,
    required this.deposits,
  });

  factory Confirmed.fromJson(Map<String, dynamic> json) {
    return Confirmed(
      id: json['id'],
      manuelBookingId: json['manuel_booking_id'],
      confirmed: json['comfirmed'],
      deposits: (json['deposits'] as List).map((e) => Deposit.fromJson(e)).toList(),
    );
  }
}

class Deposit {
  final String deposit;
  final String date;

  Deposit({required this.deposit, required this.date});

  factory Deposit.fromJson(Map<String, dynamic> json) {
    return Deposit(
      deposit: json['deposit'],
      date: json['date'],
    );
  }
}

class Vouchered {
  final int id;
  final int manuelBookingId;
  final int totallyPaid;
  final String confirmationNum;
  final String name;
  final String phone;
  final String email;

  Vouchered({
    required this.id,
    required this.manuelBookingId,
    required this.totallyPaid,
    required this.confirmationNum,
    required this.name,
    required this.phone,
    required this.email,
  });

  factory Vouchered.fromJson(Map<String, dynamic> json) {
    return Vouchered(
      id: json['id'],
      manuelBookingId: json['manuel_booking_id'],
      totallyPaid: json['totally_paid'],
      confirmationNum: json['confirmation_num'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}

class Canceled {
  final int id;
  final int manuelBookingId;
  final String cancelationReason;

  Canceled({
    required this.id,
    required this.manuelBookingId,
    required this.cancelationReason,
  });

  factory Canceled.fromJson(Map<String, dynamic> json) {
    return Canceled(
      id: json['id'],
      manuelBookingId: json['manuel_booking_id'],
      cancelationReason: json['cancelation_reason'],
    );
  }
}

class AgentData {
  final String name;
  final String email;
  final String phone;

  AgentData({required this.name, required this.email, required this.phone});

  factory AgentData.fromJson(Map<String, dynamic> json) {
    return AgentData(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}