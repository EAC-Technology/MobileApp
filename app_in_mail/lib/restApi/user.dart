class User {
  final String email;
  final String guid;
  final String firstName;
  final String lastName;
  final String sessionId;

  User({this.email, this.guid, this.firstName, this.lastName, this.sessionId});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    final map = json;
    return User(
        email: map['email'],
        guid: map['guid'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        sessionId: map['sid']);
  }
}
