import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController {
  late Dio _dio;

  ApiController() {
    _dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        connectTimeout: Duration(milliseconds: 15000), // 15s
        receiveTimeout: Duration(milliseconds: 5000), // 5s
      ),
    );
  }

  Future register(
    String name,
    String email,
    String password,
    String no_telp,
    String tanggal_lahir,
    String jenis_kelamin,
    String alamat,
  ) async {
    print('name: $name');
    print('email: $email');
    print('password: $password');
    print('no_telp: $no_telp');
    print('tanggal_lahir: $tanggal_lahir');
    print('jenis_kelamin: $jenis_kelamin');
    print('alamat: $alamat');

    try {
      DateTime birthDate;
      try {
        // Convert tanggal_lahir from String to DateTime
        birthDate = DateTime.parse(tanggal_lahir);
      } on FormatException catch (e) {
        print('Invalid date format: $tanggal_lahir');
        throw e;
      }

      // Format birthDate to a string in the format "YYYY-MM-DD"
      String formattedBirthDate =
          "${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}";

      Response response = await _dio.post(
        'http://10.0.2.2:8000/api/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'no_telp': no_telp,
          'tanggal_lahir': formattedBirthDate, // Use the formatted birth date
          'jenis_kelamin': jenis_kelamin,
          'alamat': alamat,
          'id_role': 3,
        },
      );

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Received invalid status code: ${e.response?.statusCode}');
      } else {
        print('Unexpected error occurred: $e');
      }
      throw e;
    } catch (e) {
      print('Unexpected error occurred: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'http://10.0.2.2:8000/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      Map<String, dynamic> responseData = response.data;

      if (responseData.containsKey('access_token')) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'access_token',
          responseData['access_token'] ?? '',
        );

        final userId = responseData['user']['id_user'] as int?;
        print('User ID di APICont: $userId');
        await prefs.setInt('userId', userId ?? 0);

        final userName = responseData['user']['name'] as String?;
        print('User Name di APICont: $userName');
        await prefs.setString('userName', userName ?? '');

        final phoneNumber = responseData['user']['no_telp'] as String?;
        print('User phoneNumber di APICont: $phoneNumber');
        await prefs.setString('phoneNumber', phoneNumber ?? '');

        final birthDate = responseData['user']['tanggal_lahir'] as String?;
        print('User birthDate di APICont: $birthDate');
        await prefs.setString('birthDate', birthDate ?? '');

        final gender = responseData['user']['jenis_kelamin'] as String?;
        print('User gender di APICont: $gender');
        await prefs.setString('gender', gender ?? '');

        final selectedLocationName =
            responseData['user']['nama_lokasi'] as String?;
        print('User lokasi di APICont: $selectedLocationName');
        await prefs.setString(
            'selectedLocationName', selectedLocationName ?? '');

        return responseData;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error occurred during login: $e');
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getJasaProducts() async {
    try {
      Response response =
          await _dio.get('http://10.0.2.2:8000/api/produk/jasa');
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = response.data;

        // Pastikan data jasa ada di dalam objek responseBody dengan kunci tertentu, misalnya 'data'
        if (responseBody.containsKey('data')) {
          List<dynamic> body = responseBody['data'];

          // Ubah data jasa menjadi List<Map<String, dynamic>>
          List<Map<String, dynamic>> jasaProducts = body
              .where((item) => item is Map && item['jenisproduk'] == 'jasa')
              .map((item) => item as Map<String, dynamic>)
              .toList();

          return jasaProducts;
        } else {
          throw Exception('Failed to load data from API: Data not found');
        }
      } else {
        throw Exception('Failed to load data from API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load services: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getLocations() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8000/api/lokasis');

      if (response.statusCode != 200) {
        throw Exception('Failed to get locations');
      }

      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      print('Error getting locations: $e');
      throw e;
    }
  }

  Future<void> setUserLocation({
    required String accessToken,
    required int userId,
    required int locationId,
  }) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:8000/api/set-location',
        data: {
          'id_user': userId,
          'id_lokasi': locationId,
        },
        options: Options(
          headers: {
            'Authorization':
                'Bearer $accessToken', // Include access token in header
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to set user location');
      }
    } catch (e) {
      print('Error setting user location: $e');
      throw e;
    }
  }

  Future<void> bookAppointment(BuildContext context, DateTime dateTime,
      int productId, int userId, int locationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');
      final idUser = prefs.getInt('id_user');
      final selectedLocationId = prefs.getInt('id_lokasi');

      if (accessToken == null) {
        throw Exception("Access token is null");
      }

      Response response = await _dio.post(
        'http://10.0.2.2:8000/api/requestBooking',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: jsonEncode(<String, dynamic>{
          'id_user': idUser,
          'id_lokasi': selectedLocationId,
          'tanggal_booking': dateTime.toIso8601String(),
          'id_produk': productId,
        }),
      );
      if (response.statusCode != 201) {
        final statusCode = response.statusCode;
        throw Exception("Failed to book : $statusCode");
      }
      // handle jika berhasil
      return response.data;
    } catch (e) {
      throw Exception("Failed to book appointment: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getBookingHistory(
      int userId, int locationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception("Access token is null");
      }

      Response response = await _dio.get(
        'http://10.0.2.2:8000/api/userBookingHistory',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        queryParameters: {
          'id_user': userId,
          'id_lokasi': locationId,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody = response.data['bookings'];
        return List<Map<String, dynamic>>.from(responseBody.map((booking) {
          return {
            'layanan':
                booking['nama'] ?? 'Layanan tidak tersedia', // Tangani null
            'status': booking['status'],
            'tanggal_booking': booking['tanggal_booking'],
          };
        }));
      } else {
        throw Exception(
            'Failed to load booking history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load booking history: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getBookingProses(
      int userId, int locationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception("Access token is null");
      }

      Response response = await _dio.get(
        'http://10.0.2.2:8000/api/userBookingProcess',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        queryParameters: {
          'id_user': userId,
          'id_lokasi': locationId,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody = response.data['bookings'];
        return List<Map<String, dynamic>>.from(responseBody.map((booking) {
          return {
            'layanan':
                booking['nama'] ?? 'Layanan tidak tersedia', // Tangani null
            'status': booking['status'],
            'tanggal_booking': booking['tanggal_booking'],
          };
        }));
      } else {
        throw Exception(
            'Failed to load booking history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load booking history: $e');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}
