import 'package:dio/dio.dart';
import 'package:medical_scheduler/core/constants/api_urls.dart';
import 'package:medical_scheduler/data/model/branch_model.dart';
import 'package:medical_scheduler/data/source/data_source/branch_data_src.dart';

class BranchDataSourceImpl implements BranchDataSrc {
  final Dio dio;

  BranchDataSourceImpl(this.dio);

  @override
  Future<List<BranchModel>> getAllBranches() async {
    try {
      final response = await dio.get('${ApiUrls.baseURL}/branches');
      return (response.data as List)
          .map((e) => BranchModel.fromJson(e))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch branches: $e');
    }
  }

  @override
  Future<BranchModel> getBranchById(int branchId) async {
    try {
      final response = await dio.get('${ApiUrls.baseURL}/branches/$branchId');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          return BranchModel.fromJson(response.data);
        } else {
          print('Unexpected response data type: ${response.data.runtimeType}');
          throw Exception('Expected a JSON object but got something else');
        }
      } else {
        throw Exception("Failed to load branch: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Failed to fetch branch with ID $branchId: $e');
    }
  }


  @override
  Future<void> deleteBranch(int id) async {
    try {
      await dio.delete('${ApiUrls.baseURL}/branches/$id');
    } catch (e) {
      throw Exception('Failed to delete branch with ID $id: $e');
    }
  }
}
