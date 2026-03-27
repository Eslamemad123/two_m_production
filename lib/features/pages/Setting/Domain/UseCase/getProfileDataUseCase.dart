import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class GetProfileDataUseCase {
  final SettingRepo settingRepo;
  GetProfileDataUseCase({required this.settingRepo});

  Future<Either<Failure, Map<String, String>>> call() {
    return settingRepo.getProfileData();
  }
}
