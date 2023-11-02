import 'package:hive_flutter/hive_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/app/entities/recent.dart';
import 'package:movie/common/error/failure.dart';

import 'package:movie/modules/search/data/datasource/recent_local_data_source.dart';
import 'package:movie/modules/search/data/models/recent_model.dart';
import 'package:movie/modules/search/data/repository/recent_repository.dart';

class RecentRepositoryImpl extends RecentRepository {
  final RecentLocalDataSource _baseRecentLocalDataSource;

  RecentRepositoryImpl(this._baseRecentLocalDataSource);

  @override
  Future<Either<Failure, List<Recent>>> getRecentItems() async {
    final result = (await _baseRecentLocalDataSource.getRecentItems());
    try {
      return Right(result);
    } on HiveError catch (failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, Recent>> addRecentItem(Recent recent) async {
    try {
      Recent r = await _baseRecentLocalDataSource.addRecentItem(
        RecentModel.fromEntity(recent),
      );
      return Right(r);
    } on HiveError catch (failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, Recent>> removeRecentItem(Recent recent) async {
    try {
      Recent r = await _baseRecentLocalDataSource
          .removeRecentItem(RecentModel.fromEntity(recent));
      return Right(r);
    } on HiveError catch (failure) {
      return Left(DatabaseFailure(failure.message));
    }
  }
}
