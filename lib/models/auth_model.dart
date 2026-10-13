class User {
  final int id;
  final String type;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final bool isVerified;

  User({
    required this.id,
    required this.type,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      type: json['type'] ?? 'public_user',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
      isVerified: json['is_verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'is_verified': isVerified,
    };
  }
}

class LoginResponse {
  final String tokenType;
  final String accessToken;
  final int expiresIn;
  final String refreshToken;
  final int refreshExpiresIn;
  final User user;

  LoginResponse({
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
    required this.refreshExpiresIn,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      tokenType: json['token_type'] ?? 'Bearer',
      accessToken: json['access_token'] ?? '',
      expiresIn: json['expires_in'] ?? 3600,
      refreshToken: json['refresh_token'] ?? '',
      refreshExpiresIn: json['refresh_expires_in'] ?? 2592000,
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

class RegisterResponse {
  final String message;
  final String? userId;

  RegisterResponse({
    required this.message,
    this.userId,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] ?? '',
      userId: json['user_id']?.toString(),
    );
  }
}
