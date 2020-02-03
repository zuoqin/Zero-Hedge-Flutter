class ZHSingleItem {
  String title;
  String updated;
  String body;
  String reference;

  ZHSingleItem(String title, String updated, String body, String reference) {
    this.title = title;
    this.updated = updated;
    this.body = body;
    this.reference = reference;
  }

  ZHSingleItem.fromJson(Map json)
      : title = json['title'],
        updated = json['updated'],
        reference = json['reference'],
        body = json['body'];


  Map toJson() {
    return {'title': title, 'updated': updated, 'body': body, 'reference': reference};
  }
}