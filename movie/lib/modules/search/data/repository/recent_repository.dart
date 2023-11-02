import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/recent.dart';
import 'package:movie/common/error/failure.dart';

abstract class RecentRepository {
  Future<Either<Failure, List<Recent>>> getRecentItems();
  Future<Either<Failure, Recent>> addRecentItem(Recent recent);
  Future<Either<Failure, Recent>> removeRecentItem(Recent recent);
}
