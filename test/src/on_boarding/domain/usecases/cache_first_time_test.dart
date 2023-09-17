import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo_mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
    'should call the [OnboardingRepo.cacheFirstTimer] and return the right data',
    () async {
      when(() => repo.cacheFirstTimer()).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Unkown error Occurred',
            statusCode: 500,
          ),
        ),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(message: 'Unkown error Occurred', statusCode: 500),
          ),
        ),
      );

      verify(() => repo.cacheFirstTimer()).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
