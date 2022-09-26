import 'dart:convert';

class EbayProductModel {
  String href;
  int total;
  String next;
  int limit;
  int offset;
  List<ItemSummary> itemSummaries;

  EbayProductModel(
    this.href,
    this.total,
    this.next,
    this.limit,
    this.offset,
    this.itemSummaries,
  );

  Map<String, dynamic> toMap() {
    return {
      'href': href,
      'total': total,
      'next': next,
      'limit': limit,
      'offset': offset,
      'itemSummaries': itemSummaries.map((x) => x.toMap()).toList(),
    };
  }

  factory EbayProductModel.fromMap(Map<String, dynamic> map) {
    return EbayProductModel(
      map['href'] ?? '',
      map['total']?.toInt() ?? 0,
      map['next'] ?? '',
      map['limit']?.toInt() ?? 0,
      map['offset']?.toInt() ?? 0,
      List<ItemSummary>.from(map['itemSummaries']?.map((x) => ItemSummary.fromMap(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory EbayProductModel.fromJson(String source) => EbayProductModel.fromMap(json.decode(source));
}

class ItemSummary {
  String itemId;
  String title;
  List<String>? leafCategoryIds;
  List<Category>? categories;
  Image image;
  Price price;
  String itemHref;
  Seller seller;
  String condition;
  String conditionId;
  List<Image>? thumbnailImages;
  List<ShippingOption>? shippingOptions;
  List<String>? buyingOptions;
  String epid;
  String itemWebUrl;
  ItemLocation itemLocation;
  List<Image>? additionalImages;
  bool adultOnly;
  String legacyItemId;
  bool availableCoupons;
  String itemCreationDate;
  bool topRatedBuyingExperience;
  bool priorityListing;
  String listingMarketplaceId;
  ItemSummary(
    this.itemId,
    this.title,
    this.leafCategoryIds,
    this.categories,
    this.image,
    this.price,
    this.itemHref,
    this.seller,
    this.condition,
    this.conditionId,
    this.thumbnailImages,
    this.shippingOptions,
    this.buyingOptions,
    this.epid,
    this.itemWebUrl,
    this.itemLocation,
    this.additionalImages,
    this.adultOnly,
    this.legacyItemId,
    this.availableCoupons,
    this.itemCreationDate,
    this.topRatedBuyingExperience,
    this.priorityListing,
    this.listingMarketplaceId,
  );

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'title': title,
      'leafCategoryIds': leafCategoryIds,
      'categories': categories!.map((x) => x.toMap()).toList(),
      'image': image.toMap(),
      'price': price.toMap(),
      'itemHref': itemHref,
      'seller': seller.toMap(),
      'condition': condition,
      'conditionId': conditionId,
      'thumbnailImages': thumbnailImages!.map((x) => x.toMap()).toList(),
      'shippingOptions': shippingOptions!.map((x) => x.toMap()).toList(),
      'buyingOptions': buyingOptions,
      'epid': epid,
      'itemWebUrl': itemWebUrl,
      'itemLocation': itemLocation.toMap(),
      'additionalImages': additionalImages!.map((x) => x.toMap()).toList(),
      'adultOnly': adultOnly,
      'legacyItemId': legacyItemId,
      'availableCoupons': availableCoupons,
      'itemCreationDate': itemCreationDate,
      'topRatedBuyingExperience': topRatedBuyingExperience,
      'priorityListing': priorityListing,
      'listingMarketplaceId': listingMarketplaceId,
    };
  }

  factory ItemSummary.fromMap(Map<String, dynamic> map) {
    return ItemSummary(
      map['itemId'] ?? '',
      map['title'] ?? '',
      List<String>.from(map['leafCategoryIds'] ?? []),
      List<Category>.from(map['categories']?.map((x) => Category.fromMap(x)) ?? []),
      Image.fromMap(map['image'] ?? {}),
      Price.fromMap(map['price'] ?? {}),
      map['itemHref'] ?? '',
      Seller.fromMap(map['seller'] ?? {}),
      map['condition'] ?? '',
      map['conditionId'] ?? '',
      List<Image>.from(map['thumbnailImages']?.map((x) => Image.fromMap(x)) ?? []),
      List<ShippingOption>.from(map['shippingOptions']?.map((x) => ShippingOption.fromMap(x)) ?? []),
      List<String>.from(map['buyingOptions'] ?? []),
      map['epid'] ?? '',
      map['itemWebUrl'] ?? '',
      ItemLocation.fromMap(map['itemLocation'] ?? {}),
      List<Image>.from(map['additionalImages']?.map((x) => Image.fromMap(x)) ?? []),
      map['adultOnly'] ?? false,
      map['legacyItemId'] ?? '',
      map['availableCoupons'] ?? false,
      map['itemCreationDate'],
      map['topRatedBuyingExperience'] ?? false,
      map['priorityListing'] ?? false,
      map['listingMarketplaceId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSummary.fromJson(String source) => ItemSummary.fromMap(json.decode(source));
}

class Image {
  String imageUrl;
  Image(
    this.imageUrl,
  );

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));
}

class Category {
  String categoryId;
  String categoryName;
  Category(
    this.categoryId,
    this.categoryName,
  );

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      map['categoryId'] ?? '',
      map['categoryName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source));
}

class ItemLocation {
  String postalCode;
  String country;
  ItemLocation(
    this.postalCode,
    this.country,
  );

  Map<String, dynamic> toMap() {
    return {
      'postalCode': postalCode,
      'country': country,
    };
  }

  factory ItemLocation.fromMap(Map<String, dynamic> map) {
    return ItemLocation(
      map['postalCode'] ?? '',
      map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemLocation.fromJson(String source) => ItemLocation.fromMap(json.decode(source));
}

class Price {
  String value;
  String currency;
  Price(
    this.value,
    this.currency,
  );

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'currency': currency,
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      map['value'] ?? '',
      map['currency'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source));
}

class Seller {
  String username;
  String feedbackPercentage;
  int feedbackScore;
  Seller(
    this.username,
    this.feedbackPercentage,
    this.feedbackScore,
  );

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'feedbackPercentage': feedbackPercentage,
      'feedbackScore': feedbackScore,
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      map['username'] ?? '',
      map['feedbackPercentage'] ?? '',
      map['feedbackScore']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Seller.fromJson(String source) => Seller.fromMap(json.decode(source));
}

class ShippingOption {
  String shippingCostType;
  Price shippingCost;
  ShippingOption(
    this.shippingCostType,
    this.shippingCost,
  );

  Map<String, dynamic> toMap() {
    return {
      'shippingCostType': shippingCostType,
      'shippingCost': shippingCost.toMap(),
    };
  }

  factory ShippingOption.fromMap(Map<String, dynamic> map) {
    return ShippingOption(
      map['shippingCostType'] ?? '',
      Price.fromMap(map['shippingCost'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShippingOption.fromJson(String source) => ShippingOption.fromMap(json.decode(source));
}
