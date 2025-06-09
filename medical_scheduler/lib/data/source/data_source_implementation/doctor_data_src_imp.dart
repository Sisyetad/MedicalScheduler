import 'package:dio/dio.dart';
import 'package:medical_scheduler/core/constants/api_urls.dart';
import 'package:medical_scheduler/data/model/ResponseModel/doctor_model.dart';
import 'package:medical_scheduler/data/source/data_source/doctor_data_src.dart';
import 'package:medical_scheduler/domain/entities/request/doctor_request.dart';
import 'package:medical_scheduler/domain/entities/response/doctor.dart';

class DoctorDataSourceImpl implements DoctorDataSrc {
  final Dio dio;

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

  @override
  Future<DoctorModel> createDoctor(DoctorRequest doctor) async {
    try {
      final doctorModel = DoctorModel.fromJson(doctor as Map<String, dynamic>);
      final response = await dio.post(
        '${ApiUrls.baseURL}/doctors',
        data: doctorModel.toJson(),
      );
      if (response.statusCode == 201) {
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

  @override
  Future<void> deleteDoctor(int id) async {
    try {
      await dio.delete('${ApiUrls.baseURL}/doctors/$id');
    } catch (e) {
      throw Exception('Failed to delete doctor with ID $id: $e');
    }
  }
}
