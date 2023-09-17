import 'package:dartz/dartz.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo_mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test(
    'should get a response from  the [MockOnboardingRepo]',
    () async {
      when(() => repo.checkIfUserIsFirstTime()).thenAnswer(
        (_) async => const Right(true),
      );

      final result = await usecase();

      expect(result, equals(const Right<dynamic, bool>(true)));

      verify(() => repo.checkIfUserIsFirstTime()).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
