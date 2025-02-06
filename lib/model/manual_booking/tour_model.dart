class TourModel {
  String? tourName;
  String? tourType;
  int? adultsNumber;
  int? childrenNumber;
  List<Map<String, dynamic>> adultsDetails;
  List<Map<String, dynamic>> childrenDetails;
  String? adultsPrice;
  String? childrenPrice;
  List<Map<String, dynamic>> tourBuses; // New field
  List<Map<String, dynamic>> tourHotels; // New field

  TourModel({
    this.tourName,
    this.tourType,
    this.adultsNumber,
    this.childrenNumber,
    this.adultsDetails = const [],
    this.childrenDetails = const [],
    this.adultsPrice,
    this.childrenPrice,
    this.tourBuses = const [], // Default value
    this.tourHotels = const [], // Default value
  });

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
      'tourBuses': tourBuses, // Serialize new field
      'tourHotels': tourHotels, // Serialize new field
    };
  }

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
      tourBuses: List<Map<String, dynamic>>.from(
          json['tourBuses']), // Deserialize new field
      tourHotels: List<Map<String, dynamic>>.from(
          json['tourHotels']), // Deserialize new field
    );
  }
}
