import 'dart:convert';
// import 'package:apk_barbershop/Booking.dart';
import 'package:apk_barbershop/Produk.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        connectTimeout: Duration(milliseconds: 30000),
        receiveTimeout: Duration(milliseconds: 5000),
      ),
    );
  }

  // Base URL for the API
  String baseUrl() {
    return 'http://api.daengbarbershop.my.id';
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
        '${baseUrl()}/api/auth/register',
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
    } on DioException catch (e) {
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
        '${baseUrl()}/api/auth/login',
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

        final point = responseData['user']['point'] as String?;
        print('User point di APICont: $point');
        await prefs.setString('point', point ?? '');

        final selectedLocationName =
            responseData['user']['nama_lokasi'] as String?;
        print('User lokasi di APICont: $selectedLocationName');
        await prefs.setString(
            'selectedLocationName', selectedLocationName ?? '');

        return responseData;
      } else {
        _showErrorToast('Password atau email yang anda masukkan salah');
        throw Exception('Password atau email yang anda masukkan salah');
      }
    } catch (e) {
      _showErrorToast('Error occurred during login');
      print(
          'Error occurred during login: $e'); // Tambahkan informasi lebih lanjut tentang kesalahan
      throw e;
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<List<Map<String, dynamic>>> getJasaProducts() async {
    try {
      // Retrieve the token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception('No access token found. Please log in.');
      }

      // Add authorization headers with the retrieved token
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      // Make the request with authorization headers
      Response response = await _dio.get(
        '${baseUrl()}/api/produk/jasa',
        options: options,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = response.data;

        // Ensure 'data' exists in the response
        if (responseBody.containsKey('data')) {
          List<dynamic> body = responseBody['data'];

          // Convert 'data' into a list of Map<String, dynamic>
          List<Map<String, dynamic>> jasaProducts = body
              .map((item) => item['produk'] as Map<String, dynamic>)
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

  // Fungsi untuk mengambil produk berdasarkan jenis
  // Future<List<Info>> getProdukByJenis() async {
  //   try {
  //     Response response = await _dio.get('${baseUrl()}/api/produk/jenis');

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseBody = response.data;

  //       if (responseBody.containsKey('data')) {
  //         Map<String, dynamic> data = responseBody['data'];

  //         List<Info> filteredProduk = [];

  //         for (var type in ['jasa', 'barang']) {
  //           if (data.containsKey(type)) {
  //             filteredProduk.addAll(
  //               (data[type] as List<dynamic>).map(
  //                 (item) => Info(
  //                   gambar: item['gambar'] ?? '',
  //                   nama: item['nama'] ?? '',
  //                   deskripsi: item['deskripsi'] ?? '',
  //                   harga: item['harga'] ?? '',
  //                 ),
  //               ),
  //             );
  //           }
  //         }

  //         return filteredProduk;
  //       } else {
  //         throw Exception('Expected data not found in API response');
  //       }
  //     } else {
  //       throw Exception('Failed to load data: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error in getProdukByJenis: $e');
  //     throw Exception('Failed to load products by jenis: $e');
  //   }
  // }

  Future<List<Info>> getProdukByJenis() async {
    try {
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token');

      if (token == null) {
        throw Exception('Token tidak tersedia. Silakan login terlebih dahulu.');
      }

      // Buat request ke API dengan menyertakan token dalam header Authorization
      Response response = await Dio().get(
        '${baseUrl()}/api/produk/jenis',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = response.data;

        List<Info> produkList = [];

        if (responseBody.containsKey('data')) {
          Map<String, dynamic> data = responseBody['data'];

          // Parsing produk 'jasa'
          if (data.containsKey('jasa')) {
            produkList.addAll(
              (data['jasa'] as List<dynamic>)
                  .map(
                    (item) => Info(
                      gambar: item['gambar']?.toString() ?? '',
                      nama: item['nama']?.toString() ?? '',
                      harga: item['harga']?.toString() ?? '',
                      deskripsi: item['deskripsi']?.toString() ?? '',
                    ),
                  )
                  .toList(),
            );
          }

          // Parsing produk 'barang'
          if (data.containsKey('barang')) {
            produkList.addAll(
              (data['barang'] as List<dynamic>)
                  .map(
                    (item) => Info(
                      gambar: item['gambar']?.toString() ?? '',
                      nama: item['nama']?.toString() ?? '',
                      harga: item['harga']?.toString() ?? '',
                      deskripsi: item['deskripsi']?.toString() ?? '',
                    ),
                  )
                  .toList(),
            );
          }
        } else {
          print('Unexpected data format: $responseBody');
          throw Exception('Data key not found in API response');
        }

        return produkList;
      } else {
        String errorMessage =
            'Unexpected status code: ${response.statusCode}. Response: ${response.data}';
        print('Error: $errorMessage');
        throw Exception('Failed to load data from API: $errorMessage');
      }
    } catch (e) {
      print('Error in getProdukByJenis: $e');
      throw Exception('Failed to load products by jenis: $e');
    }
  }

//location

  Future<List<Map<String, dynamic>>> getLocations() async {
    try {
      final response = await _dio.get('${baseUrl()}/api/lokasis');

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
        '${baseUrl()}/api/set-location',
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
      // final bookingID = prefs.getInt('id_booking');

      if (accessToken == null) {
        throw Exception("Access token is null");
      }

      Response response = await _dio.post(
        '${baseUrl()}/api/requestBooking',
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

  Future<List<Map<String, dynamic>>> getBookingHistory(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception("Access token is null");
      }

      Response response = await _dio.get(
        '${baseUrl()}/api/userBookingHistory',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        queryParameters: {
          'id_user': userId,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> responseBody = response.data['bookings'];
        return List<Map<String, dynamic>>.from(responseBody.map((booking) {
          return {
            'id_booking': booking['id_booking'],
            'nama_produk': booking['produk']['nama'] ??
                'Nama tidak tersedia', // Tangani null
            'harga_produk': booking['produk']['harga']?.toString() ??
                'Harga tidak tersedia', // Tangani null
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

  Future<List<Map<String, dynamic>>> getBookingProcess(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception("Access token is null");
      }

      Response response = await _dio.get(
        '${baseUrl()}/api/userBookingProcess',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        queryParameters: {
          'id_user': userId,
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        List<dynamic> responseBody = response.data['bookings'];

        // Convert the response into a list of maps with the necessary fields
        return List<Map<String, dynamic>>.from(responseBody.map((booking) {
          return {
            'id_booking': booking['id_booking'],
            'nama_produk': booking['produk']['nama'] ?? 'Nama tidak tersedia',
            'harga_produk': booking['produk']['harga']?.toString() ??
                'Harga tidak tersedia',
            'status': booking['status'],
            'tanggal_booking': booking['tanggal_booking'],
          };
        }));
      } else {
        throw Exception(
            'Failed to load booking process: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load booking process: $e');
    }
  }

  Future<String?> redirectToPayment(int bookingId) async {
    final url = '${baseUrl()}/api/redirectToPayment/$bookingId';

    try {
      final response = await _dio.get(
        url,
        options: Options(
          followRedirects: false, // Set to false to handle redirects manually
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('redirect_url')) {
          return responseData['redirect_url'];
        } else {
          throw Exception('Unexpected response format');
        }
      } else if (response.statusCode == 302) {
        return response.headers['location']?.first;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> updateProfile({
    required String name,
    required String noTelp,
    required DateTime tanggalLahir,
    required String alamat,
    // required String email,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('access_token');

      if (accessToken == null) {
        throw Exception("Access token is null");
      }

      final data = {
        'name': name,
        'no_telp': noTelp,
        'tanggal_lahir': tanggalLahir.toString(),
        'alamat': alamat,
        // 'email': email,
      };

      final response = await _dio.put(
        '${baseUrl()}/api/updatecustomers',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode != 200) {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print('Error updating profile: $e');
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getContents() async {
    try {
      final response = await _dio.get('${baseUrl()}/api/contents');
      if (response.statusCode == 200) {
        List<dynamic> contents = response.data['data'];
        return contents.map((content) {
          return {
            'id': content['id'],
            'title': content['title'],
            'description': content['description'],
            'image_path': content['image_path'] ?? '',
            'expiry_date': content['expiry_date'],
          };
        }).toList();
      } else {
        throw Exception('Failed to load contents');
      }
    } catch (e) {
      throw Exception('Error fetching contents: $e');
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

// class Info {
//   final String gambar;
//   final String nama;
//   final String deskripsi;
//   final String harga;

//   Info({
//     required this.gambar,
//     required this.nama,
//     required this.deskripsi,
//     required this.harga,
//   });
// }
