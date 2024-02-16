import 'package:malikopal/model/requestbody/ProfilePicReqBody.dart';

class UpdateProfileReqBody {
  UpdateProfileReqBody({this.data, this.uploadPicture});

  final UpdateProfileReqData? data;
  ProfilePicReqData? uploadPicture;

  factory UpdateProfileReqBody.fromJson(Map<String, dynamic> json) =>
      UpdateProfileReqBody(
        data: UpdateProfileReqData.fromJson(json["Data"]),
        uploadPicture: ProfilePicReqData.fromJson(json["UploadPicture"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "UploadPicture": uploadPicture?.toJson(),
      };
}

class UpdateProfileReqData {
  String? newImageName;
  String? imageUrl;
  String? accountHolderName;
  String? accountHolderCNIC;
  String? email;
  String? phoneNumber;
  String? address;
  String? fatherName;
  String? nextOfKinName;
  String? cnicIssuedDate;
  String? nextOfKinRelation;
  String? nextOfKinCNIC;
  String? nextOfKinPhone;
  String? dIRPROFILEIMAGES;
  String? guardianType;
  String? source;

  UpdateProfileReqData(
      {this.newImageName,
      this.imageUrl,
      this.accountHolderName,
      this.accountHolderCNIC,
      this.email,
      this.phoneNumber,
      this.address,
      this.fatherName,
      this.nextOfKinName,
      this.nextOfKinRelation,
      this.cnicIssuedDate,
      this.nextOfKinCNIC,
      this.nextOfKinPhone,
      this.dIRPROFILEIMAGES,
      this.guardianType,
      this.source});

  UpdateProfileReqData.fromJson(Map<String, dynamic> json) {
    newImageName = json['NewImageName'];
    imageUrl = json['ImageUrl'];
    accountHolderName = json['AccountHolderName'];
    cnicIssuedDate = json['CnicIssuedDate'];
    accountHolderCNIC = json['AccountHolderCNIC'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
    address = json['Address'];
    fatherName = json['FatherName'];
    nextOfKinName = json['NextOfKinName'];
    nextOfKinRelation = json['NextOfKinRelation'];
    nextOfKinCNIC = json['NextOfKinCNIC'];
    nextOfKinPhone = json['NextOfKinPhone'];
    dIRPROFILEIMAGES = json['DIR_PROFILE_IMAGES'];
    guardianType = json['GuardianType'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NewImageName'] = this.newImageName;
    data['ImageUrl'] = this.imageUrl;
    data['AccountHolderName'] = this.accountHolderName;
    data['AccountHolderCNIC'] = this.accountHolderCNIC;
    data['CnicIssuedDate'] = this.cnicIssuedDate;
    data['Email'] = this.email;
    data['PhoneNumber'] = this.phoneNumber;
    data['Address'] = this.address;
    data['FatherName'] = this.fatherName;
    data['NextOfKinName'] = this.nextOfKinName;
    data['NextOfKinRelation'] = this.nextOfKinRelation;
    data['NextOfKinCNIC'] = this.nextOfKinCNIC;
    data['NextOfKinPhone'] = this.nextOfKinPhone;
    data['DIR_PROFILE_IMAGES'] = this.dIRPROFILEIMAGES;
    data['GuardianType'] = this.guardianType;
    data['Source'] = this.source;
    return data;
  }
}
