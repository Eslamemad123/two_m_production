import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Profits/Domain/Repo/profitsRepo.dart';

class GetProductNamesUseCase {
  final ProfitsRepo profitsRepo;

  GetProductNamesUseCase({required this.profitsRepo});

  Future<Either<Failure, List<String>>> call() {
    return profitsRepo.getProductNames();
  }
}
