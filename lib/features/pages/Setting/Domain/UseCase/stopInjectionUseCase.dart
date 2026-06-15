import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class StopInjectionUsecase {
  final SettingRepo settingRepo;
  StopInjectionUsecase({required this.settingRepo});

  Future<Either<Failure, bool>> call(String product) {
    return settingRepo.NewInjectionMolding(product);
  }
}
