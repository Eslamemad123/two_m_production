import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class UpdateLastConnectionUseCase {
  final SettingRepo settingRepo;
  UpdateLastConnectionUseCase({required this.settingRepo});

  Future<Either<Failure, bool>> call() {
    return settingRepo.updateLastConnection();
  }
}
