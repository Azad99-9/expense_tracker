import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/services/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:expense_tracker/models/user_model.dart';

class UserService {
  static User? currentUser = FirebaseAuth.instance.currentUser;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static bool get loggedIn => _auth.currentUser != null;
  static User? get getUser => _auth.currentUser;

  UserService() {
    _auth.authStateChanges().listen((onData) {
      print(onData);
    });
  }

  static Future<User?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication authDetails =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: authDetails.accessToken,
        idToken: authDetails.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }
  }

  static Future<bool> userExists() async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(UserService.currentUser!.uid);
    final DocumentSnapshot snapshot = await docRef.get();
    return snapshot.exists;
  }

  Future<UserModel> fetchUserDoc() async {
    try {
      // Get the current user's UID
      final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (uid.isEmpty) {
        throw Exception("User not logged in.");
      }

      // Reference to the Firestore `users` collection
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!docSnapshot.exists) {
        throw Exception("User document does not exist.");
      }

      final UserModel fetchedUser = UserModel.fromJson(docSnapshot.data()!);
      print(fetchedUser.toString());
      // Map the fetched document data to the `UserModel`
      return fetchedUser;
    } catch (e) {
      throw Exception("Failed to fetch user document: $e");
    }
  }

  static Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  static Future<void> createNewUser(UserModel user) async {
    await DBService.users.doc(user.uid).set(user.toJson());
    return;
  }
}
