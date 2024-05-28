import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selaga_ver1/repositories/models/api_response.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/models/login_user_model.dart';
import 'package:selaga_ver1/repositories/models/register_user_model.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';
import 'package:selaga_ver1/repositories/models/venue_model.dart';

class ApiRepository {
  final Dio api;

  ApiRepository({Dio? dio}) : api = dio ?? Dio() {
    api.options.baseUrl = "http://192.168.0.106/skripsi-selaga/public/api";
    api.options.receiveDataWhenStatusError = true;
  }

  Future<ApiResponse<UserProfileModel>> getMyProfile(String token) async {
    try {
      final result = await api.get("/profileMitra",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return ApiResponse(
          result: UserProfileModel.fromJson(result.data['data']));
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> userLogin(LoginUserModel user) async {
    try {
      final result = await api.post("/login", data: user.toRawJson());
      return ApiResponse(result: result.data['token'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> userRegister(RegisterUserModel user) async {
    try {
      final result = await api.post("/register", data: user.toRawJson());
      return ApiResponse(result: result.data['token'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> userLogout(String token) async {
    try {
      final result = await api.get("/logout",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return ApiResponse(result: result.data['message'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.error.toString());
    }
  }

  Future<ApiResponse<String>> daftarVenue(
      String token, List<File> img, List<String> fasilitas) async {
    var formData = FormData.fromMap({
      "nameVenue": 'gor leuwi anyar',
      "lokasiVenue": 'leuwi anyar',
      "descVenue": 'lorem ipsumm',
      "price": '75000',
      "rating": '5',
    }, ListFormat.multiCompatible);

    for (var e in fasilitas) {
      formData.fields.addAll([MapEntry('fasilitasVenue[]', e)]);
    }

    for (var file in img) {
      formData.files.addAll([
        MapEntry(
            "file[]",
            await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last)),
      ]);
    }
    try {
      final result = await api.post("/venue",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data: formData);
      return ApiResponse(result: result.data['message'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> mitraLogin(LoginUserModel user) async {
    try {
      final result = await api.post("/loginMitra", data: user.toRawJson());
      return ApiResponse(result: result.data['token'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> mitraRegister(RegisterUserModel user) async {
    try {
      final result = await api.post("/registerMitra", data: user.toRawJson());
      return ApiResponse(result: result.data['token'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> mitraLogout(String token) async {
    try {
      final result = await api.get("/logoutMitra",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return ApiResponse(result: result.data['message'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.error.toString());
    }
  }

  Future<ApiResponse<List<VenueModel>>> getAllVenue(String token) async {
    try {
      final result = await api.get("/venue",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      final List<dynamic> data = result.data['data'];
      final response =
          data.map<VenueModel>((e) => VenueModel.fromJson(e)).toList();
      return ApiResponse(result: response);
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<VenueModel>> getVenueDetail(String token, int id) async {
    try {
      final result = await api.get("/venue/$id",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return ApiResponse(result: VenueModel.fromJson(result.data['data']));
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<List<Lapangan>>> getMyLapangan(
      String token, int id) async {
    try {
      final result = await api.get("/venue/$id",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      final List<dynamic> lapangan = result.data['data']['lapangans'];
      final response = lapangan
          .map<Lapangan>((lapangan) => Lapangan.fromJson(lapangan))
          .toList();
      return ApiResponse(result: response);
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> daftarLapangan(
      String token, String nama, int id) async {
    var formData = FormData.fromMap({
      "nameLapangan": nama,
      "days": '1111-11-11',
      "hour": '0',
      "venueId": '$id',
    }, ListFormat.multiCompatible);

    try {
      final result = await api.post("/lapangan",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }),
          data: formData);
      return ApiResponse(result: result.data['message'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<List<JadwalLapanganModel>>> getJadwalLapangan(
      String token) async {
    try {
      final result = await api.get("/timetable",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      final List<dynamic> data = result.data['data'];
      final response = data
          .map<JadwalLapanganModel>((e) => JadwalLapanganModel.fromJson(e))
          .toList();
      return ApiResponse(result: response);
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }
}
