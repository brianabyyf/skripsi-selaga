import 'package:dio/dio.dart';
import 'package:selaga_ver1/repositories/models/api_response.dart';
import 'package:selaga_ver1/repositories/models/lapangan_model.dart';
import 'package:selaga_ver1/repositories/models/login_user_model.dart';
import 'package:selaga_ver1/repositories/models/register_user_model.dart';

class ApiRepository {
  final Dio api;

  ApiRepository({Dio? dio}) : api = dio ?? Dio() {
    api.options.baseUrl = "http://192.168.0.106/skripsi-selaga/public/api";
    api.options.receiveDataWhenStatusError = true;
  }

  Future<ApiResponse<String>> userLogin(LoginUserModel user) async {
    try {
      final result = await api.post("/login", data: user.toRawJson());
      return ApiResponse(result: result.data.toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<String>> userRegister(RegisterUserModel user) async {
    try {
      final result = await api.post("/register", data: user.toRawJson());
      return ApiResponse(result: result.data.toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.statusCode.toString());
    }
  }

  Future<ApiResponse<List<LapanganModel>>> getAllLapangan(String token) async {
    try {
      final result = await api.get("/lapangan",
          options: Options(headers: {
            'Authorization': 'Bearer $token ',
          }));
      final List<dynamic> data = result.data['data'];
      final response =
          data.map<LapanganModel>((e) => LapanganModel.fromJson(e)).toList();
      return ApiResponse(result: response);
    } on DioException catch (e) {
      return ApiResponse(error: e.response?.statusCode.toString());
    }
  }

  Future<ApiResponse<String>> mitraLogin(LoginUserModel user) async {
    try {
      final result = await api.post("/loginMitra", data: user.toRawJson());
      return ApiResponse(result: result.data.toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.toString());
    }
  }

  Future<ApiResponse<String>> mitraRegister(RegisterUserModel user) async {
    try {
      final result = await api.post("/registerMitra", data: user.toRawJson());
      return ApiResponse(result: result.data.toString());
    } on DioException catch (e) {
      return ApiResponse(error: e.toString());
    }
  }
}
