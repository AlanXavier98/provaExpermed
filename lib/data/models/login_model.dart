class LoginModel {
  String? name;
  String? email;
  String? pass;
  String? id;

  LoginModel({this.name, this.email, this.pass, this.id});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    pass = json['pass'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['pass'] = this.pass;
    data['id'] = this.id;
    return data;
  }
}
