import 'package:dartz/dartz.dart';
import 'package:two_m_production/core/error/failer.dart';
import 'package:two_m_production/features/pages/Home/Domain/Repo/homeRepo.dart';

class AddProductStock {
  final HomeRepo homeRepo;
  AddProductStock({required this.homeRepo});
  Future<Either<Failure, bool>> call(int count, String id,String date,String? note) {
    return homeRepo.addProducStock(count,id,date,note);
  }
}
