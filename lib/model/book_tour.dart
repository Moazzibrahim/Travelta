class TourBooking {
  int? tourId;
  int? adultsCount;
  int? currencyId;
  int? tohotelid;
  int? singleRoomCount;
  int? doubleRoomCount;
  int? tripleRoomCount;
  int? quadRoomCount;
  double? totalPrice;

  TourBooking({
    this.tourId,
    this.adultsCount,
    this.currencyId,
    this.tohotelid,
    this.singleRoomCount = 0,
    this.doubleRoomCount = 0,
    this.tripleRoomCount = 0,
    this.quadRoomCount = 0,
    this.totalPrice = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'tour_id': tourId,
      'adultsCount': adultsCount,
      'currency_id': currencyId,
      'tohotelid': tohotelid,
      'single_room_count': singleRoomCount,
      'double_room_count': doubleRoomCount,
      'triple_room_count': tripleRoomCount,
      'quad_room_count': quadRoomCount,
      'total_price': totalPrice,
    };
  }

  factory TourBooking.fromJson(Map<String, dynamic> json) {
    return TourBooking(
      tourId: json['tour_id'],
      adultsCount: json['adultsCount'],
      currencyId: json['currency_id'],
      tohotelid: json['tohotelid'],
      singleRoomCount: json['single_room_count'] ?? 0,
      doubleRoomCount: json['double_room_count'] ?? 0,
      tripleRoomCount: json['triple_room_count'] ?? 0,
      quadRoomCount: json['quad_room_count'] ?? 0,
      totalPrice: json['total_price'] ?? 0.0,
    );
  }

  void updateRoomCount(String roomType, int count) {
    switch (roomType) {
      case 'single':
        singleRoomCount = count;
        break;
      case 'double':
        doubleRoomCount = count;
        break;
      case 'triple':
        tripleRoomCount = count;
        break;
      case 'quadruple':
        quadRoomCount = count;
        break;
    }
  }
}
