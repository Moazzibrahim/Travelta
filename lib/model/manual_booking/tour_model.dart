class TourModel {
  String? tourName;
  String? tourType;
  int? adultsNumber;
  int? childrenNumber;
  List<Map<String, dynamic>> adultsDetails;
  List<Map<String, dynamic>> childrenDetails;
  String? adultsPrice;
  String? childrenPrice;
  List<TourBus> tourBuses;
  List<TourHotel> tourHotels;

  TourModel({
    this.tourName,
    this.tourType,
    this.adultsNumber,
    this.childrenNumber,
    this.adultsDetails = const [],
    this.childrenDetails = const [],
    this.adultsPrice,
    this.childrenPrice,
    this.tourBuses = const [],
    this.tourHotels = const [],
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      tourName: json['tourName'],
      tourType: json['tourType'],
      adultsNumber: json['adultsNumber'],
      childrenNumber: json['childrenNumber'],
      adultsDetails: List<Map<String, dynamic>>.from(json['adultsDetails']),
      childrenDetails: List<Map<String, dynamic>>.from(json['childrenDetails']),
      adultsPrice: json['adultsPrice'],
      childrenPrice: json['childrenPrice'],
      tourBuses: (json['tourBuses'] as List)
          .map((bus) => TourBus.fromJson(bus))
          .toList(),
      tourHotels: (json['tourHotels'] as List)
          .map((hotel) => TourHotel.fromJson(hotel))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tourName': tourName,
      'tourType': tourType,
      'adultsNumber': adultsNumber,
      'childrenNumber': childrenNumber,
      'adultsDetails': adultsDetails,
      'childrenDetails': childrenDetails,
      'adultsPrice': adultsPrice,
      'childrenPrice': childrenPrice,
      'tourBuses': tourBuses.map((bus) => bus.toJson()).toList(),
      'tourHotels': tourHotels.map((hotel) => hotel.toJson()).toList(),
    };
  }
}

class TourBus {
  String? transportation;
  int? seats;

  TourBus({this.transportation, this.seats});

  factory TourBus.fromJson(Map<String, dynamic> json) {
    return TourBus(
      transportation: json['transportation'],
      seats: json['seats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transportation': transportation,
      'seats': seats,
    };
  }
}

class TourHotel {
  String? destination;
  String? hotelName;
  String? roomType;
  String? checkIn;
  String? checkOut;
  int? nights;

  TourHotel({
    this.destination,
    this.hotelName,
    this.roomType,
    this.checkIn,
    this.checkOut,
    this.nights,
  });

  factory TourHotel.fromJson(Map<String, dynamic> json) {
    return TourHotel(
      destination: json['destination'],
      hotelName: json['hotel_name'],
      roomType: json['room_type'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      nights: json['nights'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'hotel_name': hotelName,
      'room_type': roomType,
      'check_in': checkIn,
      'check_out': checkOut,
      'nights': nights,
    };
  }
}
