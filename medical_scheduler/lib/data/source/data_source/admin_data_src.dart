import '../../../domain/entities/response/headoffice.dart';

abstract class HeadofficeDataSource {
  Future<List<HeadOffice>> getAllHeadoffices();
  Future<HeadOffice?> getHeadofficeById(int id);
  Future<void> createHeadoffice(HeadOffice admin);
}
