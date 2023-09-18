import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/on_boarding/data/datasource/onboarding_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnboardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnboardingLocalDataSrcImpl(prefs);
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to cache the data', () async {
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

      await localDataSource.cacheFirstTimer();

      verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
      'should throw a [CacheException] when there is an error caching the data',
      () async {
        when(() => prefs.setBool(any(), any())).thenThrow(Exception());

        final methodCall = localDataSource.cacheFirstTimer;

        expect(methodCall, throwsA(isA<Exception>()));
        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should call [SharedPreferences] to check if user is first timer '
      'return the right response from storage when data exists',
      () async {
        when(() => prefs.getBool(any())).thenReturn(false);

        final result = await localDataSource.checkIfUserIsFirstTime();

        expect(result, false);

        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should return true if there is no data in storage',
      () async {
        when(() => prefs.getBool(any())).thenReturn(null);

        final result = await localDataSource.checkIfUserIsFirstTime();

        expect(result, true);

        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should return throw a [CacheException] when there is an error '
      'retrieving the data',
      () async {
        when(() => prefs.getBool(any())).thenThrow(Exception());

        final call = localDataSource.checkIfUserIsFirstTime;

        expect(call, throwsA(isA<CacheException>()));

        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );
  });
}
