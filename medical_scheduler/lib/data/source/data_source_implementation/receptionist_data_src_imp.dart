import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/model/receptionist_model.dart';
import 'package:medical_scheduler/data/source/data_source/receptionist_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/receptionist.dart';

class ReceptionistDataSrcImp implements ReceptionistDataSrc {
  final Dio dio;

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

  @override
  Future<void> createReceptionist(Receptionist receptionist) async {
    try {
      await dio.post('/receptionists', data: (receptionist as ReceptionistModel).toJson());
    } catch (e) {
      throw Exception('Failed to create receptionist: $e');
    }
  }

  @override
  Future<void> updateReceptionist(Receptionist receptionist) async {
    try {
      await dio.put('/receptionists/${receptionist.userId}', data: (receptionist as ReceptionistModel).toJson());
    } catch (e) {
      throw Exception('Failed to update receptionist with ID ${receptionist.userId}: $e');
    }
  }

  @override
  Future<void> deleteReceptionist(int id) async {
    try {
      await dio.delete('/receptionists/$id');
    } catch (e) {
      throw Exception('Failed to delete receptionist with ID $id: $e');
    }
  }
}
