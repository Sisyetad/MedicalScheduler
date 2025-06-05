import 'package:medical_scheduler/domain/entities/response/Branch.dart';

abstract class BranchRepository {
  Future<List<Branch>> getAllBranches();
  Future<Branch?> getBranchById(int branchId);
  Future<void> deleteBranch(int id);
}
