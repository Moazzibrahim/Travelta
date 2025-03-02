class ResultModel {
  final String hotelName;
  final int hotelStar;
  final int hotelId;
  final String countryName;
  final String hotelLogo;
  final List<String> images;
  final String cityName;
  final List<AvailableRooms> availableRooms;
  final List<HotelFacilities> hotelFacilities;
  final List<HotelFeatures> hotelFeatures;
  final List<HotelPolicies> hotelPolicies;
  final List<HotelAcceptedCards> hotelAcceptedCards;

  ResultModel(
      {required this.hotelLogo,
      required this.hotelStar,
      required this.images,
      required this.hotelName,
      required this.hotelId,
      required this.countryName,
      required this.cityName,
      required this.availableRooms,
      required this.hotelFacilities,
      required this.hotelFeatures,
      required this.hotelPolicies,
      required this.hotelAcceptedCards});

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      hotelName: json['hotel_name'],
      hotelStar: json['hotel_stars'],
      hotelLogo: json['hotel_logo'],
      images: List<String>.from(json['images']),
      hotelId: json['hotel_id'],
      countryName: json['country'],
      cityName: json['city'],
      hotelFacilities: List<HotelFacilities>.from(json['hotel_facilities']
          .map((facility) => HotelFacilities.fromJson(facility))),
      availableRooms: List<AvailableRooms>.from(
          json['available_rooms'].map((room) => AvailableRooms.fromJson(room))),
      hotelFeatures: List<HotelFeatures>.from(json['hotel_features']
          .map((feature) => HotelFeatures.fromJson(feature))),
      hotelPolicies: List<HotelPolicies>.from(json['hotel_policies']
          .map((policy) => HotelPolicies.fromJson(policy))),
      hotelAcceptedCards: List<HotelAcceptedCards>.from(
          json['hotel_accepted_cards']
              .map((card) => HotelAcceptedCards.fromJson(card))),
    );
  }
}

class HotelFacilities {
  final int id;
  final String name;

  HotelFacilities({required this.id, required this.name});

  factory HotelFacilities.fromJson(Map<String, dynamic> json) {
    return HotelFacilities(
      id: json['id'],
      name: json['name'],
    );
  }
}

class HotelFeatures {
  final int id;
  final String name;
  final String description;

  HotelFeatures(
      {required this.id, required this.name, required this.description});

  factory HotelFeatures.fromJson(Map<String, dynamic> json) {
    return HotelFeatures(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class HotelPolicies {
  final int id;
  final String title;
  final String description;

  HotelPolicies(
      {required this.id, required this.title, required this.description});

  factory HotelPolicies.fromJson(Map<String, dynamic> json) {
    return HotelPolicies(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

class HotelAcceptedCards {
  final int id;
  final String cardName;

  HotelAcceptedCards({required this.id, required this.cardName});

  factory HotelAcceptedCards.fromJson(Map<String, dynamic> json) {
    return HotelAcceptedCards(
      id: json['id'],
      cardName: json['card_name'],
    );
  }
}

class ResultsList {
  final List<dynamic> results;

  ResultsList({required this.results});

  factory ResultsList.fromJson(Map<String, dynamic> json) {
    return ResultsList(
      results: json['hotels'],
    );
  }
}

class AvailableRooms {
  final int id;
  final int availableQuantity;
  final String roomType;
  final Room room;
  final List<Pricing> pricings;

  AvailableRooms(
      {required this.id,
      required this.availableQuantity,
      required this.room,
      required this.roomType,
      required this.pricings
      });

  factory AvailableRooms.fromJson(Map<String, dynamic> json) {
    return AvailableRooms(
        id: json['room_id'],
        availableQuantity: json['available_quantity'],
        room: Room.fromJson(json['room_details']),
        roomType: json['room_type'],
        pricings: List<Pricing>.from(
            json['pricing'].map((pricing) => Pricing.fromJson(pricing)))
        );
  }
}

class AvailableRoomsList {
  final List<dynamic> availableRooms;

  AvailableRoomsList({required this.availableRooms});

  factory AvailableRoomsList.fromJson(Map<String, dynamic> json) {
    return AvailableRoomsList(
      availableRooms: json['available_rooms'],
    );
  }
}

class Room {
  final int? cityId;
  final int? countryId;
  final int? agentId;
  final int? affiliateId;
  final String description;
  final String priceType;
  final double price;
  final List<Gallery> gallery;
  final List<RoomFeatures> roomFeatures;

  Room(
      {required this.cityId,
      required this.countryId,
      required this.agentId,
      required this.affiliateId,
      required this.description,
      required this.priceType,
      required this.price,
      required this.gallery,
      required this.roomFeatures});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      cityId: json['city_id'],
      countryId: json['country_id'],
      agentId: json['agent_id'],
      affiliateId: json['affilate_id'],
      description: json['description'],
      priceType: json['price_type'],
      price: json['price'] == null ? 0.0 : json['price'].toDouble(),
      gallery: List<Gallery>.from(
          json['gallery'].map((gallery) => Gallery.fromJson(gallery))),
      roomFeatures: List<RoomFeatures>.from(
          json['amenity'].map((room) => RoomFeatures.fromJson(room))),
    );
  }
}


class Pricing {
  final int id;
  final int currencyId;
  final double price;
  final String currencyName;

  Pricing({required this.id, required this.currencyId, required this.price, required this.currencyName});

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      id: json['id'],
      currencyId: json['currency_id'],
      price: json['price'].toDouble(),
      currencyName: json['currency']['name'],
    );
  }
}
class Gallery {
  final String thumbUrl;
  final int id;
  final int roomId;
  final int status;

  Gallery(
      {required this.thumbUrl,
      required this.id,
      required this.roomId,
      required this.status});

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
      thumbUrl: json['thumbnail_link'],
      id: json['id'],
      roomId: json['room_id'],
      status: json['status']);
}

class RoomFeatures {
  final int id;
  final String name;

  RoomFeatures({required this.id, required this.name});

  factory RoomFeatures.fromJson(Map<String, dynamic> json) =>
      RoomFeatures(id: json['id'], name: json['name']);
}
