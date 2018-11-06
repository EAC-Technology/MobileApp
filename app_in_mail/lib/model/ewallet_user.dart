class Profile {
  final String firstName;
  final String lastName;
  final String country;
  final String phone;
  final String birthday;
  final String nationality;

  Profile(
      {this.firstName,
      this.lastName,
      this.country,
      this.phone,
      this.birthday,
      this.nationality});

      factory Profile.fromJson(Map<dynamic, dynamic> json) {
        final map = json;
        return Profile(
          firstName: map['first_name'],
          lastName:  map['last_name'],
          country:  map['country'],
          phone:  map['phone'],
          birthday:  map['birthday'],
          nationality:  map['nationality'],
        );
      }
}

class EwalletUser {
  final Profile profile;
  final String firstName;
  final String lastName;
  final String pisId;
  final String accessToken;
  final String country;
  final String email;
  final String phone;
  final String birthday;
  final bool isLifeTimeMember;
  final String nationality;
  final String login;
  final String guid;
  final String shortLogin;

  EwalletUser(
      {this.profile,
      this.firstName,
      this.lastName,
      this.pisId,
      this.accessToken,
      this.country,
      this.email,
      this.phone,
      this.birthday,
      this.isLifeTimeMember,
      this.nationality,
      this.login,
      this.guid,
      this.shortLogin});

  factory EwalletUser.fromJson(Map<dynamic, dynamic> json) {
    final map = json;
    return EwalletUser(
        profile:  Profile.fromJson(map['profile']),
        firstName: map['first_name'],
        lastName: map['last_name'],
        pisId: map['pis_id'],
        accessToken: map['access_token'],
        country: map['country'],
        email: map['email'],
        phone: map['phone'],
        birthday: map['birthday'],
        isLifeTimeMember: map['is_lifetime_member'],
        nationality: map['nationality'],
        login: map['login'],
        guid: map['guid'],
        shortLogin: map['short_login']);
  }
}
