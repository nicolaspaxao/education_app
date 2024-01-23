import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.bio,
    super.profilePic,
    super.groupIds,
    super.enrolledCourseIds,
    super.following,
    super.followers,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
        );

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          groupIds: List<String>.from(map['groupIds'] as List<dynamic>),
          enrolledCourseIds:
              (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
        );

  DataMap toMap() => {
        'uid': uid,
        'email': email,
        'profilePic': profilePic,
        'bio': bio,
        'points': points,
        'fullName': fullName,
        'groupIds': groupIds,
        'enrolledCourseIds': enrolledCourseIds,
        'following': following,
        'followers': followers,
      };
}
