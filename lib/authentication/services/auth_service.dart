import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> entrarUsuario(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: senha)
          .then((value) {});
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return "O e-mail não esta cadastrado";
        case "wrong-password":
          return "Senha incorreta";
      }
      return e.code;
    }
    return null;
  }

  Future<String?> cadastrarUsuario({
    required String email,
    required String senha,
    required String nome,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      userCredential.user!.updateDisplayName(nome);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "O email já esta em uso";
        default:
      }
      return e.code;
    }
    return null;
  }
}