class AppUrl {
  // static const String baseUrl = 'https://cf6a732c447c.ngrok-free.app/api';
  static const String baseUrl = 'https://1f68c6de5409.ngrok-free.app/api';

  // login in section
  static const String login = '/login';
  static const String register = '/signup';
  static const String verifyOtp = '/otp';
  static const String resendotp = '';
  static const String forgetotp = '/forget-otp';
  static const String verifyotp = '/verify-forget-otp';
  static const String forgetpassword = '/forgot-password';

  // video sections
  static const String getVideos = '/vedio';
  static const String getCategories = '/category';
  static const String sub_category = '/view-play-list';

  // profile sections
  static const String add_guardiandetails = '/guardian-profile';
  static const String add_basicinfo = '/basic-profile';
  static const String add_gender = '/gender-profile';
  static const String add_age = '/age-profile';
  static const String add_image = '/image-profile';
  static const String get_user_age = '/user-age-level';
  static const String get_profile = '/get-profile';

  static const String show_all_quiz = '/all-quizes';
  static const String get_category_quiz = '/category-quiz';

  static const String AddOrder = '/user/customer-order';
  static const String getOrder = '/user/get-customer-order';
  static const String cancelOrder = '/user/return-order';
}
