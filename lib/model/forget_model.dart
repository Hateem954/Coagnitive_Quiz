class OtpResponse {
  final bool success;
  final String message;
  final int otp;

  OtpResponse({
    required this.success,
    required this.message,
    required this.otp,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      otp: json['otp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'otp': otp};
  }
}
