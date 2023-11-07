import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();
  ResultFuture<LocalUser> forgotPassword(
    String email,
  );

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<LocalUser> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<LocalUser> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
