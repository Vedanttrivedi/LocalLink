class CustomUser {
  String? uid;
  String? email;
  String? fullname;
  List<dynamic>? groups;
  String? deviceId;
  CustomUser({this.uid, this.email, this.fullname, this.groups, this.deviceId});

  CustomUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    fullname = json['fullname'];
    groups = json['groups'].cast<String>();
    deviceId = json["deviceid"];
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'groups': groups,
      "deviceid": deviceId
    };
  }
}
