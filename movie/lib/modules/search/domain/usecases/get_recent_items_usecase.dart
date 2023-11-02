import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/recent.dart';

import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/search/data/repository/recent_repository.dart';

class GetRecentItemsUseCase extends BaseUseCase<List<Recent>, NoParameters> {
  final RecentRepository _baseRecentRepository;

  GetRecentItemsUseCase(this._baseRecentRepository);

  @override
  Future<Either<Failure, List<Recent>>> call(NoParameters p) async {
    return await _baseRecentRepository.getRecentItems();
  }
}
