class SendNotificationResponse {
  SendNotificationResponse({
    required this.data,
    required this.message,
    required this.errorList,
  });

  late List<SendNotificationResponseData>? data;
  late String message;
  late List<String> errorList;
  factory SendNotificationResponse.fromJson(Map<String, dynamic> json) =>
      SendNotificationResponse(
        data: json["Data"] == null
            ? null
            : List<SendNotificationResponseData>.from(json["Data"]
                .map((x) => SendNotificationResponseData.fromJson(x))),
        message: json["Message"] == null ? "" : json["Message"],
        errorList: List<String>.from(json["ErrorList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        // "Data": data.toJson(),
        "Message": message,
        "ErrorList": List<dynamic>.from(errorList.map((x) => x)),
      };
}

class SendNotificationResponseData {
  num? notificationID;
  num? notificationUserID;
  String? title;
  String? desc;
  String? date;
  num? newMsgs;

  SendNotificationResponseData(
      {this.notificationID,
      this.notificationUserID,
      this.title,
      this.desc,
      this.date,
      this.newMsgs});

  SendNotificationResponseData.fromJson(Map<String, dynamic> json) {
    notificationID = json['NotificationID'];
    notificationUserID = json['NotificationUserID'];
    title = json['Title'];
    desc = json['Desc'];
    date = json['Date'];
    newMsgs = json['NewMsgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationID'] = this.notificationID;
    data['NotificationUserID'] = this.notificationUserID;
    data['Title'] = this.title;
    data['Desc'] = this.desc;
    data['Date'] = this.date;
    data['NewMsgs'] = this.newMsgs;
    return data;
  }
}
