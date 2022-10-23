//for access token and refresh token

class CredentialSecret {
  final String _accessToken;
  final String _refreshToken;

  CredentialSecret.fromJson(Map<String, dynamic> json)
      : _accessToken = json['accessToken'],
        _refreshToken = json['refreshToken'];

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
}
