import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medical_scheduler/data/model/RequestModel/doctor_request_model.dart';
import 'package:medical_scheduler/data/model/ResponseModel/receptionist_model.dart';
import 'package:medical_scheduler/data/source/data_source/receptionist_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';

class ReceptionistDataSrcImp implements ReceptionistDataSrc {
  final Dio dio;
  final storage = FlutterSecureStorage();
  ReceptionistDataSrcImp(this.dio);

  @override
  Future<List<ReceptionistModel>> getAllReceptionists() async {
    try {
      final response = await dio.get('/receptionists');
      return (response.data as List)
          .map((e) => ReceptionistModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to load receptionists: $e');
    }
  }

  @override
  Future<ReceptionistModel> getReceptionistById(int id) async {
    try {
      final response = await dio.get('/receptionists/$id');
      return ReceptionistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load receptionist with ID $id: $e');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  @override
  Future<Receptionist> createReceptionist(
    EmployeeRequestModel receptionist,
  ) async {
    final token = await getToken();
    try {
      final response = await dio.post(
        '/receptionists',
        data: receptionist.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 201) {
        return ReceptionistModel.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to create receptionist: ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Failed to create receptionist: $e');
    }
  }

  @override
  Future<void> updateReceptionist(Receptionist receptionist) async {
    try {
      await dio.put(
        '/users/update/${receptionist.userId}',
        data: (receptionist as ReceptionistModel).toJson(),
      );
    } catch (e) {
      throw Exception(
        'Failed to update receptionist with ID ${receptionist.userId}: $e',
      );
    }
  }
}
