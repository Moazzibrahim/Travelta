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
      this.amount
  });

  Map<String, dynamic> toJson() => {
        'room_id': roomId,
        'no_of_adults': adults,
        'no_of_children': children,
        'check_out': checkOut,
        'check_in': checkIn,
        'quantity': quantity,
        'from_supplier_id': fromSupplierId,
        'country_id': countryId,
        'city_id': cityId,
        'hotel_id': hotelId,
        'to_agent_id': toAgentId,
        'to_customer_id': toCustomerId,
        'room_type': roomType,
        'no_of_nights': noOfNights,
        'currency_id': currencyId,
        'amount': amount
      };
}
