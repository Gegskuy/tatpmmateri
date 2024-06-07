 class Products {
  LowestResellPrice? lowestResellPrice;
  List<String>? imageLinks;
  String? sId;
  String? shoeName;
  String? brand;
  String? silhoutte;
  String? styleID;
  String? make;
  String? colorway;
  int? retailPrice;
  String? thumbnail;
  String? releaseDate;
  String? description;
  String? urlKey;
  ResellLinks? resellLinks;
  int? goatProductId;

  Products(
      {this.lowestResellPrice,
        this.imageLinks,
        this.sId,
        this.shoeName,
        this.brand,
        this.silhoutte,
        this.styleID,
        this.make,
        this.colorway,
        this.retailPrice,
        this.thumbnail,
        this.releaseDate,
        this.description,
        this.urlKey,
        this.resellLinks,
        this.goatProductId});

  Products.fromJson(Map<String, dynamic> json) {
    lowestResellPrice = json['lowestResellPrice'] != null
        ? new LowestResellPrice.fromJson(json['lowestResellPrice'])
        : null;
    if (json['imageLinks'] != null) {
      imageLinks = <String>[];
      json['imageLinks'].forEach((v) {
        imageLinks!.add(v.toString());
      });
    }
    sId = json['_id'] as String?;
    shoeName = json['shoeName'] as String?;
    brand = json['brand'] as String?;
    silhoutte = json['silhoutte'] as String?;
    styleID = json['styleID'] as String?;
    make = json['make'] as String?;
    colorway = json['colorway'] as String?;
    retailPrice = json['retailPrice'] as int?;
    thumbnail = json['thumbnail'] as String?;
    releaseDate = json['releaseDate'] as String?;
    description = json['description'] as String?;
    urlKey = json['urlKey'] as String?;
    resellLinks = json['resellLinks'] != null
        ? new ResellLinks.fromJson(json['resellLinks'])
        : null;
    goatProductId = json['goatProductId'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lowestResellPrice != null) {
      data['lowestResellPrice'] = this.lowestResellPrice!.toJson();
    }
    if (this.imageLinks != null) {
      data['imageLinks'] = this.imageLinks!.map((v) => v.toString()).toList();
    }
    data['_id'] = this.sId;
    data['shoeName'] = this.shoeName;
    data['brand'] = this.brand;
    data['silhoutte'] = this.silhoutte;
    data['styleID'] = this.styleID;
    data['make'] = this.make;
    data['colorway'] = this.colorway;
    data['retailPrice'] = this.retailPrice;
    data['thumbnail'] = this.thumbnail;
    data['releaseDate'] = this.releaseDate;
    data['description'] = this.description;
    data['urlKey'] = this.urlKey;
    if (this.resellLinks != null) {
      data['resellLinks'] = this.resellLinks!.toJson();
    }
    data['goatProductId'] = this.goatProductId;
    return data;
  }
}

class LowestResellPrice {
  int? stockX;
  int? flightClub;
  int? goat;

  LowestResellPrice({this.stockX, this.flightClub, this.goat});

  LowestResellPrice.fromJson(Map<String, dynamic> json) {
    stockX = json['stockX'] as int?;
    flightClub = json['flightClub'] as int?;
    goat = json['goat'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockX'] = this.stockX;
    data['flightClub'] = this.flightClub;
    data['goat'] = this.goat;
    return data;
  }
}

class ResellLinks {
  String? stockX;
  String? flightClub;
  String? goat;

  ResellLinks({this.stockX, this.flightClub, this.goat});

  ResellLinks.fromJson(Map<String, dynamic> json) {
    stockX = json['stockX'] as String?;
    flightClub = json['flightClub'] as String?;
    goat = json['goat'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stockX'] = this.stockX;
    data['flightClub'] = this.flightClub;
    data['goat'] = this.goat;
    return data;
  }
}