class HotelBooking {
  final String name;
  final int id;

  HotelBooking({required this.name, required this.id});

  factory HotelBooking.fromJson(Map<String, dynamic> json) {
    return HotelBooking(
      name: json['name'],
      id: json['id'],
    );
  }
}

class HotelsBookingList {
  final List<dynamic> hotels;

  HotelsBookingList({required this.hotels});

  factory HotelsBookingList.fromJson(Map<String, dynamic> json) {
    return HotelsBookingList(
      hotels: json['hotels'],
    );
  }
}

class CountriesBooking {
  final String name;
  final int id;

  CountriesBooking({required this.name, required this.id});

  factory CountriesBooking.fromJson(Map<String, dynamic> json) {
    return CountriesBooking(
      name: json['name'],
      id: json['id'],
    );
  }
}

class CountriesBookingList {
  final List<dynamic> countries;

  CountriesBookingList({required this.countries});

  factory CountriesBookingList.fromJson(Map<String, dynamic> json) {
    return CountriesBookingList(
      countries: json['countries'],
    );
  }
}

class CitiesBooking {
  final String name;
  final int id;

  CitiesBooking({required this.name, required this.id});

  factory CitiesBooking.fromJson(Map<String, dynamic> json) {
    return CitiesBooking(
      name: json['name'],
      id: json['id'],
    );
  }
}

class CitiesBookingList {
  final List<dynamic> cities;

  CitiesBookingList({required this.cities});

  factory CitiesBookingList.fromJson(Map<String, dynamic> json) {
    return CitiesBookingList(
      cities: json['cities'],
    );
  }
}

class TourType {
  final int id;
  final String name;

  TourType({required this.id, required this.name});

  factory TourType.fromJson(Map<String, dynamic> json) {
    return TourType(
      id: json['id'],
      name: json['name'],
    );
  }
}

class TourTypeList {
  final List<TourType> tourTypes;

  TourTypeList({required this.tourTypes});

  factory TourTypeList.fromJson(Map<String, dynamic> json) {
    return TourTypeList(
      tourTypes: (json['tourtype'] as List)
          .map((item) => TourType.fromJson(item))
          .toList(),
    );
  }
}

class Nationaility {
  final String name;
  final int id;

  Nationaility({required this.name, required this.id});

  factory Nationaility.fromJson(Map<String, dynamic> json) {
    return Nationaility(
      name: json['name'],
      id: json['id'],
    );
  }
}

class NationailityList {
  final List<dynamic> nationailities;

  NationailityList({required this.nationailities});  

  factory NationailityList.fromJson(Map<String, dynamic> json) {
    return NationailityList(
      nationailities: json['nationality']
    );
  }
}