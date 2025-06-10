import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/data/repository/doctor_repo_imp.dart';
import 'package:medical_scheduler/data/repository/receptionist_repo_imp.dart';
import 'package:medical_scheduler/data/repository/user_repo_imp.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/doctor_data_src_imp.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/receptionist_data_src_imp.dart';
import 'package:medical_scheduler/data/source/data_source_implementation/user_src_imp.dart';
import 'package:medical_scheduler/Application/Usecases/admin/get_admin_dashboard_data.dart';
import 'package:medical_scheduler/Application/Usecases/doctor/add_doctor.dart';
import 'package:medical_scheduler/Application/Usecases/receptionist/add_receptionist.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Admin/add_employee_view_model.dart';
import 'package:medical_scheduler/presentation/Provider/notifiers/Admin/admin_dashboard_view_model.dart';
import 'package:medical_scheduler/presentation/Provider/providers/Auth/auth_provider.dart'; // To reuse dio
import 'package:medical_scheduler/presentation/Provider/states/Admin/add_employee_state.dart';
import 'package:medical_scheduler/presentation/Provider/states/Admin/admin_dashboard_state.dart';
import 'package:medical_scheduler/Application/Usecases/user/delete_user.dart';

// --- Data Sources ---
final userDataSourceProvider = Provider(
  (ref) => UserSrcImp(ref.watch(dioProvider)),
);
final adminDoctorDataSourceProvider = Provider(
  (ref) => DoctorDataSourceImpl(ref.watch(dioProvider)),
);
final adminReceptionistDataSourceProvider = Provider(
  (ref) => ReceptionistDataSrcImp(ref.watch(dioProvider)),
);

// --- Repositories ---
final userRepositoryProvider = Provider(
  (ref) => UserRepoImp(ref.watch(userDataSourceProvider)),
);
final adminDoctorRepositoryProvider = Provider(
  (ref) => DoctorRepositoryImpl(ref.watch(adminDoctorDataSourceProvider)),
);
final adminReceptionistRepositoryProvider = Provider(
  (ref) => ReceptionistRepositoryImpl(
    ref.watch(adminReceptionistDataSourceProvider),
  ),
);

// --- Use Cases ---
final getAdminDashboardDataProvider = Provider(
  (ref) => GetAdminDashboardData(ref.watch(userRepositoryProvider)),
);
final addDoctorUseCaseProvider = Provider(
  (ref) => AddDoctor(ref.watch(adminDoctorRepositoryProvider)),
);
final addReceptionistUseCaseProvider = Provider(
  (ref) => AddReceptionist(ref.watch(adminReceptionistRepositoryProvider)),
);
final deleteUserUseCaseProvider = Provider(
  (ref) => DeleteUser(ref.watch(userRepositoryProvider)),
);
// --- ViewModels / Notifiers ---
final adminDashboardNotifierProvider =
    StateNotifierProvider<AdminDashboardNotifier, AdminDashboardState>(
      (ref) => AdminDashboardNotifier(
        ref.watch(getAdminDashboardDataProvider),
        ref.watch(deleteUserUseCaseProvider), // <-- Inject delete use case
      ),
    );

final addEmployeeNotifierProvider =
    StateNotifierProvider<AddEmployeeNotifier, AddEmployeeState>((ref) {
      final addDoctorUseCase = ref.read(addDoctorUseCaseProvider);
      final addReceptionistUseCase = ref.read(addReceptionistUseCaseProvider);
      return AddEmployeeNotifier(
        addDoctorUseCase: addDoctorUseCase,
        addReceptionistUseCase: addReceptionistUseCase,
      );
    });
