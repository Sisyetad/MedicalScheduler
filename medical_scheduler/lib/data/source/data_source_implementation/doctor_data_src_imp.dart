import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medical_scheduler/core/constants/api_urls.dart';
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/doctor_model.dart';
import 'package:medical_scheduler/data/source/data_source/doctor_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';

class DoctorDataSourceImpl implements DoctorDataSrc {
  final Dio dio;
  final storage = FlutterSecureStorage();
  DoctorDataSourceImpl(this.dio);

  @override
  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final response = await dio.get('${ApiUrls.baseURL}/doctors');
      return (response.data as List)
          .map((e) => DoctorModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  @override
  Future<DoctorModel> createDoctor(EmployeeRequestModel doctor) async {
    final token = await getToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }
    try {
      final response = await dio.post(
        '/doctors',
        data: doctor.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 201) {
        print('Doctor created successfully: ${response.data}');
        return DoctorModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create doctor: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to create doctor: $e');
    }
  }

  @override
  Future<void> updateDoctor(Doctor doctor) async {
    try {
      final doctorModel = DoctorModel.fromJson(doctor as Map<String, dynamic>);
      await dio.put(
        '${ApiUrls.baseURL}/doctors/${doctor.userId}',
        data: doctorModel.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update doctor with ID ${doctor.userId}: $e');
    }
  }
}
