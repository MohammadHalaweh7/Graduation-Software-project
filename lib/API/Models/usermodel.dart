class usermodel {
  late String Name;
  late String Email;
  late String password;
  late String id;

  usermodel(this.Name, this.Email, this.id);

  usermodel.fromJson(Map<String, dynamic> map) {
    this.Name = map['name'];
    this.Email = map['email'];
    this.id = map['_id'];
    this.password = map['password'];
  }
}
