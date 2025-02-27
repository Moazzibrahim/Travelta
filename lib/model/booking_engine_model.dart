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
