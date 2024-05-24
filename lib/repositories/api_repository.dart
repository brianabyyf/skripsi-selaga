import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selaga_ver1/repositories/models/api_response.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/models/login_user_model.dart';
import 'package:selaga_ver1/repositories/models/register_user_model.dart';
import 'package:selaga_ver1/repositories/models/user_profile_model.dart';

class ApiRepository {
  final Dio api;

  ApiRepository({Dio? dio}) : api = dio ?? Dio() {
    api.options.baseUrl = "http://192.168.0.106/skripsi-selaga/public/api";
    api.options.receiveDataWhenStatusError = true;
  }

  Future<ApiResponse<UserProfileModel>> getMyProfile(String token) async {
    try {
      print(token);
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

  Future<ApiResponse<List<LapanganModel>>> getAllLapangan(String token) async {
    try {
      final result = await api.get("/lapangan",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      final List<dynamic> data = result.data['data'];
      final response =
          data.map<LapanganModel>((e) => LapanganModel.fromJson(e)).toList();
      return ApiResponse(result: response);
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<DetailLapanganModel>> getLapanganDetail(
      String token, int id) async {
    try {
      final result = await api.get("/lapangan/$id",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return ApiResponse(
          result: DetailLapanganModel.fromJson(result.data['data']));
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.data['message'].toString());
    }
  }

  Future<ApiResponse<String>> daftarVenue(String token, List<File> img) async {
    var formData = FormData.fromMap({
      "venue": 'gor leuwi anyar',
      "name": 'lapangan 2',
      "address": 'leuwi anyar',
      "price": '250000',
      "decs": 'lorem ipsumm',
      "timetableDays": 'senin,selasa',
      "timetableHours": 'pickupTime',
    }, ListFormat.multiCompatible);

    for (var file in img) {
      formData.files.addAll([
        MapEntry(
            "file[]",
            await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last)),
      ]);
    }
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

  Future<ApiResponse<String>> mitraLogin(LoginUserModel user) async {
    try {
      final result = await api.post("/loginMitra", data: user.toRawJson());
      return ApiResponse(result: result.data['token'].toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.error.toString());
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
}
