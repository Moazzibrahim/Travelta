class VisaBookingData {
  String? country;
  String? dateOfTravel;
  String? returnDate;
  int? adultsNumber;
  int? childrenNumber;
  List<Map<String, dynamic>> adultsDetails;
  List<Map<String, dynamic>> childrenDetails;
  String? note;

  VisaBookingData({
    this.country,
    this.dateOfTravel,
    this.returnDate,
    this.adultsNumber,
    this.childrenNumber,
    List<Map<String, dynamic>>? adultsDetails,
    List<Map<String, dynamic>>? childrenDetails,
    this.note,
  })  : adultsDetails = adultsDetails ?? [],
        childrenDetails = childrenDetails ?? [];

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'dateOfTravel': dateOfTravel,
      'returnDate': returnDate,
      'adultsNumber': adultsNumber,
      'childrenNumber': childrenNumber,
      'adultsDetails': adultsDetails,
      'childrenDetails': childrenDetails,
      'note': note,
    };
  }
}
