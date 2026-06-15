import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Home/Domain/Repo/homeRepo.dart';

class GetHomeSectionUseCase {
  final HomeRepo homeRepo;
  GetHomeSectionUseCase({required this.homeRepo});
  Stream<Either<Failure, List<ProductModel>>> call(String section) {
    return homeRepo.getHomeSection(section);
  }
}
