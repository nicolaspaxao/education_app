import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.bio,
    this.groupIds = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
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
  final String? bio;
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

  LocalUser copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullName,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return LocalUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupIds: groupIds ?? this.groupIds,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}
