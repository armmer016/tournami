// To parse this JSON data, do
//
//     final CardPlace = CardPlaceFromJson(jsonString);

import 'dart:convert';

import 'dart:typed_data';

CardPlace cardPlaceFromJson(String str) => CardPlace.fromJson(json.decode(str));

String cardPlaceToJson(CardPlace data) => json.encode(data.toJson());

class CardPlace {
  CardPlace({
    required this.meta,
    required this.results,
  });

  final Meta meta;
  final List<Result> results;

  factory CardPlace.fromJson(Map<String, dynamic> json) => CardPlace(
        meta: Meta.fromJson(json["meta"]),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Meta {
  Meta({
    required this.alerts,
    required this.warnings,
    required this.precision,
    required this.page,
    required this.engine,
    required this.requestId,
  });

  final List<dynamic> alerts;
  final List<dynamic> warnings;
  final int precision;
  final Page page;
  final Engine engine;
  final String requestId;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        alerts: List<dynamic>.from(json["alerts"].map((x) => x)),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
        precision: json["precision"],
        page: Page.fromJson(json["page"]),
        engine: Engine.fromJson(json["engine"]),
        requestId: json["request_id"],
      );

  Map<String, dynamic> toJson() => {
        "alerts": List<dynamic>.from(alerts.map((x) => x)),
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
        "precision": precision,
        "page": page.toJson(),
        "engine": engine.toJson(),
        "request_id": requestId,
      };
}

class Engine {
  Engine({
    required this.name,
    required this.type,
  });

  final String name;
  final String type;

  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
      };
}

class Page {
  Page({
    required this.current,
    required this.totalPages,
    required this.totalResults,
    required this.size,
  });

  final int current;
  final int totalPages;
  final int totalResults;
  final int size;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        current: json["current"],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "total_pages": totalPages,
        "total_results": totalResults,
        "size": size,
      };
}

class Result {
  Result(
      {required this.country,
      required this.img,
      required this.address,
      required this.activity,
      required this.city,
      required this.latlong,
      required this.name,
      required this.detail,
      required this.category,
      required this.meta,
      required this.id,
      this.data});

  final Activity country;
  final Activity img;
  final Activity address;
  final Activity activity;
  final Activity city;
  final Activity latlong;
  final Activity name;
  final Activity detail;
  final Activity category;
  final MetaClass meta;
  final Activity id;
  Uint8List? data;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        country: Activity.fromJson(json["country"]),
        img: Activity.fromJson(json["img"]),
        address: Activity.fromJson(json["address"]),
        activity: Activity.fromJson(json["activity"]),
        city: Activity.fromJson(json["city"]),
        latlong: Activity.fromJson(json["latlong"]),
        name: Activity.fromJson(json["name"]),
        detail: Activity.fromJson(json["detail"]),
        category: Activity.fromJson(json["category"]),
        meta: MetaClass.fromJson(json["_meta"]),
        id: Activity.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "country": country.toJson(),
        "img": img.toJson(),
        "address": address.toJson(),
        "activity": activity.toJson(),
        "city": city.toJson(),
        "latlong": latlong.toJson(),
        "name": name.toJson(),
        "detail": detail.toJson(),
        "category": category.toJson(),
        "_meta": meta.toJson(),
        "id": id.toJson(),
      };
}

class Activity {
  Activity({
    required this.raw,
  });

  String raw;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        raw: json["raw"],
      );
  set setRaw(str) {
    raw = str;
  }

  Map<String, dynamic> toJson() => {
        "raw": raw,
      };
}

class MetaClass {
  MetaClass({
    required this.engine,
    required this.score,
    required this.id,
  });

  final String engine;
  final double score;
  final String id;

  factory MetaClass.fromJson(Map<String, dynamic> json) => MetaClass(
        engine: json["engine"],
        score: json["score"].toDouble(),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "engine": engine,
        "score": score,
        "id": id,
      };
}
