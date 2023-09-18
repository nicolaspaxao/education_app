// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'on_boarding_cubit.dart';

sealed class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

final class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

class CachingFirstTimer extends OnBoardingState {
  const CachingFirstTimer();
}

class CheckingIfUserIsFirstTimer extends OnBoardingState {
  const CheckingIfUserIsFirstTimer();
}

class UserCached extends OnBoardingState {
  const UserCached();
}

class OnboardingStatus extends OnBoardingState {
  const OnboardingStatus({required this.isFirstTimer});

  final bool isFirstTimer;

  @override
  List<bool> get props => [isFirstTimer];
}

class OnboardingError extends OnBoardingState {
  const OnboardingError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
