import 'package:dio/dio.dart';
import 'package:quiz/utils/app_consultant.dart';
import 'app_url.dart';
import 'api_services.dart';

class ApiService {
  final APIClient apiClient = APIClient();

  static const String _baseUrl = AppUrl.baseUrl;

  static const String _apiKey =
      '4Iuw5gfYUrRwOPY8ZYh1aC2zxiBOOntaxkhlMgpNyE78Ebj7YBFjU13YJhBRBWBu';

  Map<String, String> get _defaultHeaders => {
    'X-API-KEY': _apiKey,
    'token': AppConstant.getUserToken ?? 'NIKVAXVKR-07242', // Fallback token
    'Content-Type': 'application/json',
  };
  // Future<Response> login({var params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.login,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: {'key': _apiKey},
  //     );
  //   } catch (e) {
  //     print('Login error: $e');
  //     rethrow;
  //   }
  // }

  Future<Response> login({var params}) async {
    try {
      final response = await apiClient.post(
        url: AppUrl.login,
        params: params,
        baseUrl: _baseUrl,
        headers: {'X-API-KEY': _apiKey},
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        final token = response.data['token'] ?? '';
        final email = params['email'];
        final password = params['password'];

        if (token.isNotEmpty) {
          await AppConstant.saveUserCredentials(
            Authorization: token,
            apiKey:
                '4Iuw5gfYUrRwOPY8ZYh1aC2zxiBOOntaxkhlMgpNyE78Ebj7YBFjU13YJhBRBWBu', // ✅ added
            email: email,
            password: password,
          );
        }
      }

      return response;
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<Response> register({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.register,
        params: params,
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json', // 👈 only this for signup
        },
      );
    } catch (e) {
      print('Register error: $e');
      rethrow;
    }
  }

  Future<Response> VerifyOtp({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.verifyOtp,
        params: params,
        baseUrl: _baseUrl,
        headers: {'key': _apiKey},
      );
    } catch (e) {
      print('Verify OTP error: $e');
      rethrow;
    }
  }

  Future<Response> getVideos(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.getVideos, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Videos error: $e');
      rethrow;
    }
  }

  Future<Response> ResendOtp({var params}) async {
    try {
      return await apiClient.post(
        url: AppUrl.resendotp,
        params: params,
        baseUrl: _baseUrl,
        headers: {'key': _apiKey},
      );
    } catch (e) {
      print('Resend OTP error: $e');
      rethrow;
    }
  }

  Future<Response> getCategories() async {
    try {
      return await apiClient.get(
        url: AppUrl.getCategories, // ✅ make sure endpoint is correct
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Categories error: $e');
      rethrow;
    }
  }

  Future<Response> getCategoriesByHashid(String hashid) async {
    try {
      return await apiClient.get(
        url: "${AppUrl.sub_category}/$hashid", // ✅ Correct interpolation
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Sub Categories error: $e');
      rethrow;
    }
  }

  Future<Response> addGuardianDetails({
    required String fatherName,
    required String contactNumber,
    required String emergencyContact,
    required String remarks,
  }) async {
    final formData = FormData.fromMap({
      'f_father_name': fatherName,
      'f_contact_number': contactNumber,
      'f_emergency_contact': emergencyContact,
      'f_remarks': remarks,
    });
    try {
      return await apiClient.post(
        url: AppUrl.add_guardiandetails,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Add Guardian Details error: $e');
      rethrow;
    }
  }

  Future<Response> addbasicinfo({
    required String name,
    required String address,
    required String zipcode,
    required String about,
  }) async {
    final formData = FormData.fromMap({
      's_name': name,
      's_address': address,
      's_zipcode': zipcode,
      's_about_youself': about,
    });
    try {
      return await apiClient.post(
        url: AppUrl.add_basicinfo,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Add basic information error: $e');
      rethrow;
    }
  }

  Future<Response> addgender({required String gender}) async {
    final formData = FormData.fromMap({'s_gender': gender});
    try {
      return await apiClient.post(
        url: AppUrl.add_gender,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Gender Details error: $e');
      rethrow;
    }
  }

  Future<Response> getage(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.get_user_age, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get age error: $e');
      rethrow;
    }
  }

  Future<Response> addage({required String age}) async {
    final formData = FormData.fromMap({'s_age': age});
    try {
      return await apiClient.post(
        url: AppUrl.add_age,
        params: formData,
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Age Details error: $e');
      rethrow;
    }
  }

  Future<Response> addimage({required FormData image}) async {
    try {
      return await apiClient.post(
        url: AppUrl.add_image,
        params: image, // now passing FormData
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Image Details error: $e');
      rethrow;
    }
  }

  Future<Response> getprofile(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.get_profile, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get profile error: $e');
      rethrow;
    }
  }

  Future<Response> showallquizzes(var params) async {
    try {
      return await apiClient.get(
        url: AppUrl.show_all_quiz, // ✅ correct endpoint
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get age error: $e');
      rethrow;
    }
  }

  Future<Response> getcategoryquiz(String hashid) async {
    try {
      return await apiClient.get(
        url: "${AppUrl.get_category_quiz}/$hashid", // ✅ Correct interpolation
        headers: {
          'X-API-KEY': _apiKey,
          'Accept': "application/json",
          'Authorization': 'Bearer ${AppConstant.getUserToken}',
        },
      );
    } catch (e) {
      print('Get Categories of Quiz error: $e');
      rethrow;
    }
  }

  Future<Response> cancelOrder({
    required int orderId,
    required String orderStatus,
  }) async {
    try {
      final formData = FormData.fromMap({
        "id": orderId,
        "order_status": orderStatus,
      });

      return await apiClient.post(
        url: AppUrl.cancelOrder,
        params: formData,
        headers: _defaultHeaders,
        baseUrl: _baseUrl,
      );
    } catch (e) {
      print('Cancel order error: $e');
      rethrow;
    }
  }

  // Future<Response> fetchLikedItems({FormData? params}) async {
  //   print('home api...: ${AppConstant.getUserToken}');
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.fetchLiked,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get liked items error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> createOrder({dynamic params}) async {
  //   try {
  //     final response = await apiClient.post(
  //       url: AppUrl.AddOrder,
  //       params: params, // Send as JSON, not FormData
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //     print('Fetch Liked items response: ${response.data}');
  //     return response;
  //   } catch (e) {
  //     print('Create Liked items error: $e');
  //     rethrow;
  //   }
  // }

  Future<Response> createOrder({dynamic params}) async {
    try {
      final isFormData = params is FormData;

      final response = await apiClient.post(
        url: AppUrl.AddOrder,
        params: params,
        baseUrl: _baseUrl,
        headers: {
          ..._defaultHeaders,
          "Accept": "application/json",
          if (isFormData) "Content-Type": "multipart/form-data",
        },
      );

      print('Create order response: ${response.data}');
      return response;
    } catch (e) {
      print('Create order error: $e');
      rethrow;
    }
  }

  // Future<Response> fetchOrderDetails({required String orderId}) async {
  //   final formData = FormData.fromMap({'order_id': orderId});
  //   try {
  //     final response = await apiClient.post(
  //       url: AppUrl.viewOrder,
  //       params: formData,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //     print('Order Details Response: ${response.data}');
  //     print('OrderDetailsOrderID: ${orderId}');
  //     return response;
  //   } catch (e) {
  //     print('Fetch order details error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> changePasswordToNewPass({var params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.changePassword,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Change password error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> forgotPassword({var params, String? url}) async {
  //   try {
  //     return await apiClient.post(
  //       url: url ?? AppUrl.forgotPassword,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: {'key': _apiKey},
  //     );
  //   } catch (e) {
  //     print('Forgot password error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> logout({var params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.logoutUrl,
  //       params: params,
  //       baseUrl: _baseUrl,
  //     );
  //   } catch (e) {
  //     print('Logout error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getBooksData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.bookListing,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get books data error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getBookCategoryData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.bookCategory,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get book category error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getShopData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.shopListing,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get shop data error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getShopCategoryData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.shopCategory,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get shop category error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getCoursesData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.courseListing,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get courses data error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getCourseCategoryData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.courseCategory,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get course category error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getCommunityData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.communityListing,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get community data error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getCommunityCategoryData({FormData? params}) async {
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.communityCategory,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //   } catch (e) {
  //     print('Get community category error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getAboutUsData({FormData? params}) async {
  //   try {
  //     return await apiClient.get(
  //       url: AppUrl.aboutUs,
  //       headers: {'key': _apiKey},
  //     );
  //   } catch (e) {
  //     print('Get about us data error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getSessionMethod({
  //   required String endDate,
  //   required String startDate,
  // }) async {
  //   final formData = FormData.fromMap({
  //     'page_no': '1',
  //     'limit': '50',
  //     'start': startDate,
  //     'end': endDate,
  //   });
  //   try {
  //     return await apiClient.post(
  //       url: AppUrl.sessionListing,
  //       params: formData,
  //       headers: _defaultHeaders,
  //       baseUrl: _baseUrl,
  //     );
  //   } catch (e) {
  //     print('Get session method error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getConsultantData({FormData? params}) async {
  //   try {
  //     final response = await apiClient.post(
  //       url: AppUrl.getConsultant,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //     return response;
  //   } catch (e) {
  //     print('Get consultant data error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> getProfileData() async {
  //   print('profile api...: ${AppConstant.getUserToken}');
  //   try {
  //     final formData = {'user_id': AppConstant.getUserID};
  //     final response = await apiClient.post(
  //       url: AppUrl.profile,
  //       params: formData,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //     print('Profile response status: ${response.statusCode}');
  //     print('Profile response data: ${response.data}');
  //     return response;
  //   } catch (e) {
  //     print('Get profile data error: $e');
  //     rethrow;
  //   }
  // }

  // Future<Response> updateProfileData({var params}) async {
  //   try {
  //     final response = await apiClient.post(
  //       url: AppUrl.updateProfile,
  //       params: params,
  //       baseUrl: _baseUrl,
  //       headers: _defaultHeaders,
  //     );
  //     print('Update profile response status: ${response.statusCode}');
  //     print('Update profile response data: ${response.data}');
  //     return response;
  //   } catch (e) {
  //     print('Update profile data error: $e');
  //     rethrow;
  //   }
  // }
}
