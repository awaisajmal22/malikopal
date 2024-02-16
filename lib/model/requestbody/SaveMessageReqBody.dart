class SaveMessageReqBody {
  SaveMessageReqBody({
    this.data,
  });

  final SaveMessageReqBodyData? data;

  factory SaveMessageReqBody.fromJson(Map<String, dynamic> json) =>
      SaveMessageReqBody(
        data: SaveMessageReqBodyData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class SaveMessageReqBodyData {
  num? iD;
  num? profileID;
  String? text;
  String? sentBy;
  String? entryDate;
  bool? viewed;
  String? viewDate;

  SaveMessageReqBodyData(
      {this.iD,
      this.profileID,
      this.text,
      this.sentBy,
      this.entryDate,
      this.viewed,
      this.viewDate});

  SaveMessageReqBodyData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    profileID = json['ProfileID'];
    text = json['Text'];
    sentBy = json['SentBy'];
    entryDate = json['EntryDate'];
    viewed = json['Viewed'];
    viewDate = json['ViewDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ProfileID'] = this.profileID;
    data['Text'] = this.text;
    data['SentBy'] = this.sentBy;
    data['EntryDate'] = this.entryDate;
    data['Viewed'] = this.viewed;
    data['ViewDate'] = this.viewDate;
    return data;
  }
}
