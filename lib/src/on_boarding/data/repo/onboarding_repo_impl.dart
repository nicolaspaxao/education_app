import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/data/datasource/onboarding_local_datasource.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

class OnboardingRepoImpl implements OnBoardingRepo {
  OnboardingRepoImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;
  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTime() async {
    final result = await _localDataSource.checkIfUserIsFirstTime();
    return Right(result);
  }
}
