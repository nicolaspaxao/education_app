import 'package:education_app/core/utils/typedefs.dart';

abstract class OnBoardingRepo {
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTime();
}
