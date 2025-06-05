

import 'package:medical_scheduler/data/source/data_source/admin_data_src.dart';
import 'package:medical_scheduler/domain/entities/response/headoffice.dart';
import 'package:medical_scheduler/domain/repository/admin_repo.dart';

class HeadOfficeRepositoryImpl implements HeadofficeRepository {
  final HeadofficeDataSource dataSource;

  HeadOfficeRepositoryImpl(this.dataSource);

  @override
  Future<List<HeadOffice>> getAllHeadoffices() async {
    return await dataSource.getAllHeadoffices();
  }

  @override
  Future<HeadOffice?> getHeadOfficebyId(int id) async {
    return await dataSource.getHeadofficeById(id);
  }

}
