import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class GetInjectionUsecase {
  final SettingRepo settingRepo;
  GetInjectionUsecase({required this.settingRepo});

  Future<Either<Failure, Map<String, dynamic>>> call(String product) {
    return settingRepo.getInjectionData(product);
  }
}
