/*
 *  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 *  Copyright (C) 2021 Rich Design - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential.
 *
 *  Written by Yakup Zengin <yakup@designsrich.com>, March 2021
 *
 */


import '../../persistent.dart';

class UserFavoriteEntity extends Persistent{
  UserFavoriteEntity({
    this.favoritesId,
    this.favoritesUid,
    this.favoritesAdsId,
    this.id,
    this.mid,
    this.sid,
    this.pid,
    this.price,
    this.discountPrice,
    this.stock,
    this.maxSell,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.bid,
    this.cid,
    this.name,
    this.sku,
    this.image,
    this.descriptions,
    this.allergy,
    this.contents,
    this.slug,
    this.url,
    this.marketSlug,
    this.marketName,
    this.selected = false,
  });

  int favoritesId;
  int favoritesUid;
  int favoritesAdsId;
  int id;
  int mid;
  int sid;
  int pid;
  String price;
  String discountPrice;
  int stock;
  bool selected;
  dynamic maxSell;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int bid;
  int cid;
  String name;
  String sku;
  String image;
  dynamic descriptions;
  dynamic allergy;
  dynamic contents;
  String slug;
  String url;
  String marketSlug;
  String marketName;

  factory UserFavoriteEntity.fromJson(Map<String, dynamic> json) => UserFavoriteEntity(
    favoritesId: json["favoritesId"] == null ? null : json["favoritesId"],
    favoritesUid: json["favoritesUid"] == null ? null : json["favoritesUid"],
    favoritesAdsId: json["favoritesAds_id"] == null ? null : json["favoritesAds_id"],
    id: json["id"] == null ? null : json["id"],
    mid: json["mid"] == null ? null : json["mid"],
    sid: json["sid"] == null ? null : json["sid"],
    pid: json["pid"] == null ? null : json["pid"],
    price: json["price"] == null ? null : json["price"],
    discountPrice: json["discountPrice"] == null ? null : json["discountPrice"],
    stock: json["stock"] == null ? null : json["stock"],
    maxSell: json["maxSell"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    bid: json["bid"] == null ? null : json["bid"],
    cid: json["cid"] == null ? null : json["cid"],
    name: json["name"] == null ? null : json["name"],
    sku: json["sku"] == null ? null : json["sku"],
    image: json["image"] == null ? null : json["image"],
    descriptions: json["descriptions"],
    allergy: json["allergy"],
    contents: json["contents"],
    slug: json["slug"] == null ? null : json["slug"],
    url: json["url"] == null ? null : json["url"],
    marketSlug: json["marketSlug"] == null ? null : json["marketSlug"],
    marketName: json["marketName"] == null ? null : json["marketName"],
  );

  Map<String, dynamic> toJson() => {
    "favoritesId": favoritesId == null ? null : favoritesId,
    "favoritesUid": favoritesUid == null ? null : favoritesUid,
    "favoritesAds_id": favoritesAdsId == null ? null : favoritesAdsId,
    "id": id == null ? null : id,
    "mid": mid == null ? null : mid,
    "sid": sid == null ? null : sid,
    "pid": pid == null ? null : pid,
    "price": price == null ? null : price,
    "discountPrice": discountPrice == null ? null : discountPrice,
    "stock": stock == null ? null : stock,
    "maxSell": maxSell,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "bid": bid == null ? null : bid,
    "cid": cid == null ? null : cid,
    "name": name == null ? null : name,
    "sku": sku == null ? null : sku,
    "image": image == null ? null : image,
    "descriptions": descriptions,
    "allergy": allergy,
    "contents": contents,
    "slug": slug == null ? null : slug,
    "url": url == null ? null : url,
    "marketSlug": marketSlug == null ? null : marketSlug,
    "marketName": marketName == null ? null : marketName,
  };
}