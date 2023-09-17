abstract class OnboardingLocalDataSource {
  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTime();
}
