import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage dbClient;
  late AuthRemoteDataSource dataSource;

  setUp(() async {
    cloudStoreClient = FakeFirebaseFirestore();
    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final mockUser = MockUser(
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );

    authClient = MockFirebaseAuth(mockUser: mockUser);
    await authClient.signInWithCredential(credential);

    dbClient = MockFirebaseStorage();
    dataSource = AuthRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
  });

  const tPassword = 'Test Password';
  const tFullName = 'Test Full Name';
  const tEmail = 'testeemail@email.com';

  test('signUp', () async {
    await dataSource.signUp(
      email: tEmail,
      fullName: tFullName,
      password: tPassword,
    );

    //expect that the user was created in the firestore and the authCliente
    //also has this user
    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.displayName, tFullName);

    final user = await cloudStoreClient
        .collection('users')
        .doc(authClient.currentUser!.uid)
        .get();

    expect(user.exists, isTrue);
  });

  test('signIn', () async {
    await dataSource.signUp(
      email: 'newEmail@email.com',
      fullName: tFullName,
      password: tPassword,
    );

    await authClient.signOut();

    await dataSource.signIn(email: 'newEmail@email.com', password: tPassword);

    expect(authClient.currentUser, isNotNull);
    expect(authClient.currentUser!.email, equals('newEmail@email.com'));
  });

  group('updateUser', () {
    setUp(() async {
      //Arrange
      await dataSource.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );
    });
    test('displayName', () async {
      //Act
      await dataSource.updateUser(
        action: UpdateUserAction.displayName,
        userData: 'new name',
      );

      expect(authClient.currentUser!.displayName, 'new name');
    });

    test('email', () async {
      //Act
      await dataSource.updateUser(
        action: UpdateUserAction.email,
        userData: 'newemail@gmail.com',
      );

      expect(authClient.currentUser!.email, 'newemail@gmail.com');
    });
  });
}
