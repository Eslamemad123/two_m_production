import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Data/Model/productModel.dart';
import 'package:two_m_production/features/pages/Setting/Domain/Repo/settingRepo.dart';

class AddProductUseCase {
  final SettingRepo settingRepo;
  AddProductUseCase({required this.settingRepo});

  Future<Either<Failure, bool>> call(ProductModel product) {
    return settingRepo.addNewProduct(product);
  }
}
