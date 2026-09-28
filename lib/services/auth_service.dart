import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new account
  Future<UserCredential> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    // 1. Create account in Firebase Authentication
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );

    // 2. Get the newly created user's UID
    final User? user = userCredential.user;

    if (user == null) {
      throw Exception('User account could not be created.');
    }

    // 3. Save the user's profile in Firestore
    await _firestore.collection('users').doc(user.uid).set({
      'name': name.trim(),
      'email': email.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    return userCredential;
  }

  // Login an existing user
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Currently logged-in Firebase user
  User? get currentUser => _auth.currentUser;

  // Get the user's profile from Firestore
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile(
    String uid,
  ) async {
    return await _firestore.collection('users').doc(uid).get();
  }
}
