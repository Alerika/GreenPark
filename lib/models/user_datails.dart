class UserDetails {
  String? displayName;
  String? email;


  //constructor
  UserDetails({this.displayName, this.email});

  // we need to create map
  UserDetails.fromJson(Map<String, dynamic> json) {
    displayName = json["displayName"];
    email = json["email"];
  }
  Map<String, dynamic> toJson() {
    // object - data
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;


    return data;

  }
}