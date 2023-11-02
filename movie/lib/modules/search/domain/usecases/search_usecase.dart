import 'package:dartz/dartz.dart';

import 'package:movie/common/error/failure.dart';
import 'package:movie/common/utils/base_use_case.dart';
import 'package:movie/modules/search/data/models/search_result_item.dart';
import 'package:movie/modules/search/data/repository/search_repository.dart';

class SearchUseCase extends BaseUseCase<List<SearchResultItem>, String> {
  final SearchRepository _baseSearchRepository;

  SearchUseCase(this._baseSearchRepository);

  @override
  Future<Either<Failure, List<SearchResultItem>>> call(String p) async {
    return await _baseSearchRepository.search(p);
  }
}
