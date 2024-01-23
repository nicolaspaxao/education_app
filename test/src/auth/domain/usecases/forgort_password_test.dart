import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/usecases/forgort_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo_mock.dart';

void main() {
  late MockAuthRepo repo;
  late ForgotPassword usecase;

  const tEmail = 'Test email';

  setUp(() {
    repo = MockAuthRepo();
    usecase = ForgotPassword(repo);
  });

  test('should call [AuthRepo] for [ForgotPassword]', () async {
    //Arrenge
    when(
      () => repo.forgotPassword(any()),
    ).thenAnswer((_) async => const Right(null));

    //Act
    final result = await usecase(tEmail);

    //Assert
    expect(result, const Right<dynamic, void>(null));

    verify(() => repo.forgotPassword(tEmail)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
