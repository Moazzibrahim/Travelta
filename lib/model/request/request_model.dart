class TravelData {
  final TravelSection current;
  final TravelSection history;

  TravelData({
    required this.current,
    required this.history,
  });

  factory TravelData.fromJson(Map<String, dynamic> json) {
    return TravelData(
      current: TravelSection.fromJson(json['current']),
      history: TravelSection.fromJson(json['history']),
    );
  }
}

class TravelSection {
  final List<Hotel> hotels;
  final List<Bus> buses;
  final List<Flight> flights;
  final List<Visa> visas;
  final List<Tour> tours;

  TravelSection({
    required this.hotels,
    required this.buses,
    required this.flights,
    required this.visas,
    required this.tours,
  });

  factory TravelSection.fromJson(Map<String, dynamic> json) {
    return TravelSection(
      hotels: (json['hotels'] as List).map((e) => Hotel.fromJson(e)).toList(),
      buses: (json['buses'] as List).map((e) => Bus.fromJson(e)).toList(),
      flights:
          (json['flights'] as List).map((e) => Flight.fromJson(e)).toList(),
      visas: (json['visas'] as List).map((e) => Visa.fromJson(e)).toList(),
      tours: (json['tours'] as List).map((e) => Tour.fromJson(e)).toList(),
    );
  }
}

class Flight {
  final int id;
  final String toName;
  final String toPhone;
  final String agent;
  final String service;
  final int revenue;
  final String priority;
  final String stages;
  final String currency;
  final String flightType;
  final String flightDirection;
  final String departure;
  final String? arrival;
  final String fromTo;
  final String adultsNo;
  final String childrenNo;
  final String flightClass;
  final String airline;
  final String ticketNo;

  Flight({
    required this.id,
    required this.toName,
    required this.toPhone,
    required this.agent,
    required this.service,
    required this.revenue,
    required this.priority,
    required this.stages,
    required this.currency,
    required this.flightType,
    required this.flightDirection,
    required this.departure,
    this.arrival,
    required this.fromTo,
    required this.adultsNo,
    required this.childrenNo,
    required this.flightClass,
    required this.airline,
    required this.ticketNo,
  });
  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] ?? 0,
      toName: json['to_name'] ?? '',
      toPhone: json['to_phone'] ?? '',
      agent: json['agent'] ?? '',
      service: json['service'] ?? '',
      revenue: json['revenue'] ?? 0,
      priority: json['priority'] ?? '',
      stages: json['stages'] ?? '',
      currency: json['currecy'] ?? '',
      flightType: json['flight_type'] ?? '',
      flightDirection: json['flight_direction'] ?? '',
      departure: json['depature'] ?? '',
      arrival: json['arrival'] ?? '',
      fromTo: json['from_to'] ?? '',
      adultsNo: json['adults_no'] ?? '',
      childrenNo: json['children_no'] ?? '',
      flightClass: json['flight_class'] ?? '',
      airline: json['airline'] ?? '',
      ticketNo: json['ticket_no'] ?? '',
    );
  }
}

class Hotel {
  final int id;
  final String toName;
  final String toPhone;
  final String agent;
  final String service;
  final int revenue;
  final String priority;
  final String stages;
  final String currency;
  final String notes;
  final String hotelName;
  final String checkIn;
  final String checkOut;
  final int noNights;
  final String roomType;
  final int noAdults;
  final int noChildren;

  Hotel({
    required this.id,
    required this.toName,
    required this.toPhone,
    required this.agent,
    required this.service,
    required this.revenue,
    required this.priority,
    required this.stages,
    required this.currency,
    required this.notes,
    required this.hotelName,
    required this.checkIn,
    required this.checkOut,
    required this.noNights,
    required this.roomType,
    required this.noAdults,
    required this.noChildren,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      toName: json['to_name'],
      toPhone: json['to_phone'],
      agent: json['agent'],
      service: json['service'],
      revenue: json['revenue'],
      priority: json['priority'],
      stages: json['stages'],
      currency: json['currecy'],
      notes: json['notes'] ?? '',
      hotelName: json['hotel_name'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      noNights: int.parse(json['no_nights']),
      roomType: json['room_type'],
      noAdults: json['no_adults'],
      noChildren: json['no_children'],
    );
  }
}

class Bus {
  final int id;
  final String toName;
  final String toPhone;
  final String agent;
  final String service;
  final int revenue;
  final String priority;
  final String stages;
  final String currency;
  final String notes;
  final String from;
  final String to;
  final String departure;
  final String arrival;
  final int noAdults;
  final int noChildren;
  final String busName;
  final String busNo;
  final String driverPhone;

  Bus({
    required this.id,
    required this.toName,
    required this.toPhone,
    required this.agent,
    required this.service,
    required this.revenue,
    required this.priority,
    required this.stages,
    required this.currency,
    required this.notes,
    required this.from,
    required this.to,
    required this.departure,
    required this.arrival,
    required this.noAdults,
    required this.noChildren,
    required this.busName,
    required this.busNo,
    required this.driverPhone,
  });

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'],
      toName: json['to_name'],
      toPhone: json['to_phone'],
      agent: json['agent'],
      service: json['service'],
      revenue: json['revenue'],
      priority: json['priority'],
      stages: json['stages'],
      currency: json['currecy'],
      notes: json['notes'] ?? '',
      from: json['from'],
      to: json['to'],
      departure: json['depature'],
      arrival: json['arrival'],
      noAdults: json['no_adults'],
      noChildren: json['no_children'],
      busName: json['bus_name'],
      busNo: json['bus_no'],
      driverPhone: json['driver_phone'],
    );
  }
}

class Visa {
  final int id;
  final String toName;
  final String toPhone;
  final String agent;
  final String service;
  final int revenue;
  final String priority;
  final String stages;
  final String currency;
  final String notes;
  final int noAdults;
  final int noChildren;
  final String countryName;
  final String travelDate;
  final String appointment;
  final String visaNotes;

  Visa({
    required this.id,
    required this.toName,
    required this.toPhone,
    required this.agent,
    required this.service,
    required this.revenue,
    required this.priority,
    required this.stages,
    required this.currency,
    required this.notes,
    required this.noAdults,
    required this.noChildren,
    required this.countryName,
    required this.travelDate,
    required this.appointment,
    required this.visaNotes,
  });

  factory Visa.fromJson(Map<String, dynamic> json) {
    return Visa(
      id: json['id'],
      toName: json['to_name'],
      toPhone: json['to_phone'],
      agent: json['agent'],
      service: json['service'],
      revenue: json['revenue'],
      priority: json['priority'],
      stages: json['stages'],
      currency: json['currecy'],
      notes: json['notes'] ?? '',
      noAdults: json['no_adults'],
      noChildren: json['no_children'],
      countryName: json['country_name'],
      travelDate: json['travel_date'],
      appointment: json['appointment'],
      visaNotes: json['visa_notes'],
    );
  }
}

class Tour {
  final int id;
  final String toName;
  final String toPhone;
  final String agent;
  final String service;
  final int revenue;
  final String priority;
  final String stages;
  final String currency;
  final String notes;
  final String tourName;
  final String tourType;
  final List<HotelTour> tourHotels;
  final List<BusTour> tourBuses;
  final int noAdults;
  final int noChildren;

  Tour({
    required this.id,
    required this.toName,
    required this.toPhone,
    required this.agent,
    required this.service,
    required this.revenue,
    required this.priority,
    required this.stages,
    required this.currency,
    required this.notes,
    required this.tourName,
    required this.tourType,
    required this.tourHotels,
    required this.tourBuses,
    required this.noAdults,
    required this.noChildren,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'] ?? 0,
      toName: json['to_name'] ?? '',
      toPhone: json['to_phone'] ?? '',
      agent: json['agent'] ?? '',
      service: json['service'] ?? '',
      revenue: json['revenue'] ?? 0,
      priority: json['priority'] ?? '',
      stages: json['stages'] ?? '',
      currency: json['currecy'] ?? '',
      notes: json['notes'] ?? '',
      tourName: json['tour_name'] ?? '',
      tourType: json['tour_type'] ?? '',
      tourHotels: (json['tour_hotels'] as List?)
              ?.map((e) => HotelTour.fromJson(e))
              .toList() ??
          [],
      tourBuses: (json['tour_buses'] as List?)
              ?.map((e) => BusTour.fromJson(e))
              .toList() ??
          [],
      noAdults: json['no_adults'] ?? 0,
      noChildren: json['no_children'] ?? 0,
    );
  }
}

class HotelTour {
  final String destination;
  final String hotelName;
  final String roomType;
  final String checkIn;
  final String checkOut;
  final String nights;

  HotelTour({
    required this.destination,
    required this.hotelName,
    required this.roomType,
    required this.checkIn,
    required this.checkOut,
    required this.nights,
  });

  factory HotelTour.fromJson(Map<String, dynamic> json) {
    return HotelTour(
      destination: json['destination'] ?? '',
      hotelName: json['hotel_name'] ?? '',
      roomType: json['room_type'] ?? '',
      checkIn: json['check_in'] ?? '',
      checkOut: json['check_out'] ?? '',
      nights: json['nights'] ?? '',
    );
  }
}

class BusTour {
  final String transportation;
  final int seats;

  BusTour({
    required this.transportation,
    required this.seats,
  });

  factory BusTour.fromJson(Map<String, dynamic> json) {
    return BusTour(
      transportation: json['transportation'] ?? '',
      seats: json['seats'] ?? 0,
    );
  }
}

class AdminAgent {
  final int id;
  final int agentId;
  final String name;

  AdminAgent({
    required this.id,
    required this.agentId,
    required this.name,
  });

  factory AdminAgent.fromJson(Map<String, dynamic> json) {
    return AdminAgent(
      id: json['id'],
      agentId: json['agent_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agent_id': agentId,
      'name': name,
    };
  }
}

class DealModel {
  final List<AdminAgent> adminsAgent;
  final List<String> priority;
  final List<String> stages;

  DealModel({
    required this.adminsAgent,
    required this.priority,
    required this.stages,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    return DealModel(
      adminsAgent: (json['admins_agent'] as List)
          .map((e) => AdminAgent.fromJson(e))
          .toList(),
      priority: List<String>.from(json['priority']),
      stages: List<String>.from(json['stages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'admins_agent': adminsAgent.map((e) => e.toJson()).toList(),
      'priority': priority,
      'stages': stages,
    };
  }
}
