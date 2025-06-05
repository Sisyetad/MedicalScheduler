import 'package:dio/dio.dart';
import 'package:medical_scheduler/data/source/data_source/admin_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/headoffice.dart';
import '../../model/headoffice_model.dart';

class HeadofficeDataSourceImpl implements HeadofficeDataSource {
  final Dio dio;

  HeadofficeDataSourceImpl({required this.dio});

  @override
  Future<List<HeadOffice>> getAllHeadoffices() async {
    try {
      final response = await dio.get('/headoffices');

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((json) => HeadofficeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

   @override
  Future<HeadOffice?> getHeadofficeById(int id) async {
    try {
      final response = await dio.get('/headoffices/$id');
      return HeadofficeModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch doctor with ID $id: $e');
    }
  }

  @override
  Future<void> createHeadoffice(HeadOffice headoffice) async {
    try {
      final model = HeadofficeModel.fromJson(headoffice as Map<String, dynamic>);
      await dio.post('/headoffices', data: model.toJson());
    } catch (e) {
      throw Exception('Failed to create headoffice: $e');
    }
  }
}

class HeadOfficeModel {
}
