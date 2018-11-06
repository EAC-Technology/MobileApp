class EmailUser {
  final String email;
  final String guid;
  final String firstName;
  final String lastName;
  final String sessionId;

  EmailUser({this.email, this.guid, this.firstName, this.lastName, this.sessionId});

  factory EmailUser.fromJson(Map<dynamic, dynamic> json) {
    final map = json;
    return EmailUser(
        email: map['email'],
        guid: map['guid'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        sessionId: map['sid']);
  }
}
