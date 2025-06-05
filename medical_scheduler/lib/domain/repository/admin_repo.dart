import '../entities/response/headoffice.dart';

abstract class HeadofficeRepository {
  Future<List<HeadOffice>> getAllHeadoffices();
  Future<HeadOffice?> getHeadOfficebyId(int headofficeId);
}
