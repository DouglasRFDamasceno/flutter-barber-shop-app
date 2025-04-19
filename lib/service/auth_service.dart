import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  final logger = Logger();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      logger.i('Tentando registrar usuário com e-mail: $email');

      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();

        logger.i('Usuário registrado com sucesso: ${user.uid}, nome: $name');
        return userCredential;
      } else {
        logger.w('Usuário retornado é nulo.');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          logger.w('E-mail já está em uso.');
          break;
        case 'invalid-email':
          logger.w('E-mail inválido.');
          break;
        case 'weak-password':
          logger.w('Senha fraca.');
          break;
        default:
          logger.e('Erro desconhecido: ${e.code}');
          break;
      }
      return null;
    } catch (e, stacktrace) {
      logger.e('Erro inesperado ao registrar usuário. Erro: ${e.toString()}');
      return null;
    }
  }

  Future<UserCredential?> getUser({
    required String email,
    required String password,
  }) async {
    try {
      logger.i('Tentando fazer login com o e-mail: $email');

      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      logger.i('Login bem-sucedido para o usuário: ${userCredential.user?.uid}');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          logger.w('Usuário não encontrado para o e-mail: $email');
          break;
        case 'wrong-password':
          logger.w('Senha incorreta para o e-mail: $email');
          break;
        case 'invalid-email':
          logger.w('E-mail inválido fornecido: $email');
          break;
        default:
          logger.e('Erro de autenticação desconhecido: ${e.code}. Erro: ${e.toString()}');
          break;
      }
      return null;
    } catch (e) {
      logger.e('Erro inesperado ao tentar logar o usuário. Erro: ${e.toString()}');
      return null;
    }
  }
}
