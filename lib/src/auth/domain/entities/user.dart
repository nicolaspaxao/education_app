// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.bio,
    required this.points,
    required this.fullName,
    required this.groupIds,
    required this.enrolledCourseIds,
    required this.following,
    required this.followers,
    this.profilePic,
  });
  const LocalUser.empty()
      : this(
          uid: '',
          email: '',
          bio: '',
          points: 0,
          fullName: '',
          profilePic: '',
          groupIds: const [],
          enrolledCourseIds: const [],
          followers: const [],
          following: const [],
        );

  final String uid;
  final String email;
  final String? profilePic;
  final String bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  List<Object> get props {
    return [
      uid,
      email,
    ];
  }

  @override
  String toString() {
    return 'LocalUser{ '
        'uid: $uid, '
        'email: $email, '
        'profilePic: $profilePic, '
        'bio: $bio, '
        'points: $points, '
        'fullName: $fullName, '
        'groupIds: $groupIds, '
        'enrolledCourseIds: $enrolledCourseIds, '
        'following: $following, '
        'followers: $followers }';
  }
}
