import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/recent.dart';
import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/search/data/repository/recent_repository.dart';

class RemoveRecentItemUseCase extends BaseUseCase<Recent, Recent> {
  final RecentRepository _baseRecentRepository;

  RemoveRecentItemUseCase(this._baseRecentRepository);

  @override
  Future<Either<Failure, Recent>> call(Recent p) async {
    return await _baseRecentRepository.removeRecentItem(p);
  }
}
