// data/repositories/doctor_repository_impl.dart
import 'package:medical_scheduler/data/source/data_source/branch_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/Branch.dart';
import 'package:medical_scheduler/domain/repository/branch_repo.dart';

class BranchRepositoryImpl implements BranchRepository {
  final BranchDataSrc dataSource;

  BranchRepositoryImpl(this.dataSource);

  @override
  Future<List<Branch>> getAllBranches() async {
    return await dataSource.getAllBranches();
  }

  @override
  Future<Branch?> getBranchById(int branchId) async {
    return await dataSource.getBranchById(branchId) as Branch;
  }

  @override
  Future<void> deleteBranch(int id) async {
    await dataSource.deleteBranch(id);
  }
}
