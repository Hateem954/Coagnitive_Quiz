// class LoginResponse {
//   final bool success;
//   final String message;
//   final String token;
//   final User user;

//   LoginResponse({
//     required this.success,
//     required this.message,
//     required this.token,
//     required this.user,
//   });

//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       token: json['token'] ?? '',
//       user: User.fromJson(json['user'] ?? {}),
//     );
//   }
// }

// class User {
//   final int id;
//   final String email;
//   final String password;
//   final String? otp;
//   final String token;
//   final int isVerified;
//   final int otpIsVerified;
//   final String createdAt;
//   final String updatedAt;

//   User({
//     required this.id,
//     required this.email,
//     required this.password,
//     this.otp,
//     required this.token,
//     required this.isVerified,
//     required this.otpIsVerified,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] ?? 0,
//       email: json['email'] ?? '',
//       password: json['password'] ?? '',
//       otp: json['otp'],
//       token: json['token'] ?? '',
//       isVerified: json['is_verified'] ?? 0,
//       otpIsVerified: json['otp_is_verified'] ?? 0,
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//     );
//   }
// }
class LoginResponse {
  final bool success;
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

class User {
  final int id;
  final String email;
  final String password;
  final String? otp;
  final String? token;
  final int isVerified;
  final int otpIsVerified;
  final int isProfile;
  final String latitude;
  final String longitude;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.email,
    required this.password,
    this.otp,
    this.token,
    required this.isVerified,
    required this.otpIsVerified,
    required this.isProfile,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      otp: json['otp'],
      token: json['token'],
      isVerified: json['is_verified'] ?? 0,
      otpIsVerified: json['otp_is_verified'] ?? 0,
      isProfile: json['is_profile'] ?? 0,
      latitude: json['latitude']?.toString() ?? '',
      longitude: json['longitude']?.toString() ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
