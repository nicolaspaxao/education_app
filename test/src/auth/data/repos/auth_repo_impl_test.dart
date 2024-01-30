import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:education_app/src/auth/data/repos/auth_repo_impl.dart';
import 'package:education_app/src/auth/domain/repos/auth_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource dataSource;
  late AuthRepoImpl repoImpl;

  setUp(() {
    dataSource = MockAuthRemoteDataSource();
    repoImpl = AuthRepoImpl(dataSource);
  });

  //* 1. Testar se é uma subclasse
  test('should be a subclass of [AuthRepo]', () {
    expect(repoImpl, isA<AuthRepo>());
  });

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tLocalUserModel = LocalUserModel.empty();

  group('forgotPassword', () {
    test(
      'should complete successfully when call remote datasource is successful',
      () async {
        when(() => dataSource.forgotPassword(any())).thenAnswer(
          (_) async => Future.value(),
        );
        final result = await repoImpl.forgotPassword(tEmail);
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => dataSource.forgotPassword(tEmail)).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );

    test('should throw an exception when something went wrong', () async {
      when(() => dataSource.forgotPassword(any())).thenThrow(
        const ServerException(message: 'An error occurred', statusCode: '403'),
      );
      final result = await repoImpl.forgotPassword(tEmail);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(message: 'An error occurred', statusCode: '403'),
          ),
        ),
      );
      verify(() => dataSource.forgotPassword(tEmail)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('signIn', () {
    test(
      'should complete successfully when call remote datasource successful',
      () async {
        when(
          () => dataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Future.value(tLocalUserModel));
        final result =
            await repoImpl.signIn(email: tEmail, password: tPassword);
        expect(
          result,
          equals(const Right<dynamic, LocalUserModel>(tLocalUserModel)),
        );
        verify(
          () => dataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dataSource);
      },
    );

    test('should throw an exception when something went wrong', () async {
      when(
        () => dataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        const ServerException(
          message: 'An error occured',
          statusCode: '401',
        ),
      );

      final result = await repoImpl.signIn(email: tEmail, password: tPassword);
      expect(
        result,
        equals(
          Left<ServerFailure, dynamic>(
            ServerFailure(
              message: 'An error occured',
              statusCode: '401',
            ),
          ),
        ),
      );
      verify(
        () => dataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}
