class BookRoom {
  int? roomId;
  int? adults;
  int? children;
  String? checkOut;
  String? checkIn;
  int? quantity;
  int? fromSupplierId;
  int? countryId;
  int? cityId;
  int? hotelId;
  int? toAgentId;
  int? toCustomerId;
  String? roomType;
  int? noOfNights;
  int? currencyId;
  double? amount;
  String? code;
  int? bookId;
  String? clientName;
  String? clientEmail;
  String? clientPhone;
  String? wpNumber;

  BookRoom({
      this.roomId,
      this.adults,
      this.children,
      this.checkOut,
      this.checkIn,
      this.quantity,
      this.fromSupplierId,
      this.countryId,
      this.cityId,
      this.hotelId,
      this.toAgentId,
      this.toCustomerId,
      this.roomType,
      this.noOfNights,
      this.currencyId,
      this.amount,
      this.code,
      this.bookId,
      this.clientName,
      this.clientEmail,
      this.clientPhone,
      this.wpNumber
  });


  factory BookRoom.fromJson(Map<String, dynamic> json) {
    return BookRoom(
      roomId: json['room_id'],
      adults: json['no_of_adults'],
      children: json['no_of_children'],
      checkOut: json['check_out'],
      checkIn: json['check_in'],
      quantity: json['quantity'],
      fromSupplierId: json['from_supplier_id'],
      countryId: json['country_id'],
      cityId: json['city_id'],
      hotelId: json['hotel_id'],
      toAgentId: json['to_agent_id'],
      toCustomerId: json['to_customer_id'],
      roomType: json['room_type'],
      noOfNights: json['no_of_nights'],
      currencyId: json['currency_id'],
      amount: json['amount']?.toDouble(),
      code: json['code'],
      bookId: json['id'],
      clientName: json['to_client']['name'],
      clientEmail: json['to_client']['email'],
      clientPhone: json['to_client']['phone'],
      wpNumber: json['to_client']['watts'],
    );
  }
}
