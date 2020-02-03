class ZHItem {
  String title;
  String updated;
  String introduction;
  String reference;
  String picture;

  User(String title, String updated, String introduction, String reference, String picture) {
    this.title = title;
    this.updated = updated;
    this.introduction = introduction;
    this.reference = reference;
    this.picture = picture;
  }

  ZHItem.fromJson(Map json)
      : title = json['title'],
        updated = json['updated'],
        introduction = json['introduction'],
        reference = json['reference'],
        picture = json['picture'];


  Map toJson() {
    return {'title': title, 'updated': updated, 'introduciton': introduction, 'reference': reference, 'picture': picture};
  }
}