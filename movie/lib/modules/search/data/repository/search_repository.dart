import 'package:dartz/dartz.dart';
import 'package:movie/common/error/failure.dart';
import 'package:movie/modules/search/data/models/search_result_item.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
}
