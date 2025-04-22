import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import '../models/user_role.dart';
import '../providers/user_role_provider.dart';

class AuthService {
  final logger = Logger();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential?> registerUser({
    required String name,
    required String email,
    required String password,
    File? imageFile,
  }) async {
    try {
      logger.i('Tentando registrar usuário com e-mail: $email');

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        String? photoURL;

        logger.i('imageFile: $imageFile');

        // Se o usuário selecionou uma imagem
        if (imageFile != null) {
          final storageRef = _firebaseStorage
              .ref()
              .child('user_profiles')
              .child('${user.uid}.jpg');

          SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
          await storageRef.putFile(imageFile, metadata);
          photoURL = await storageRef.getDownloadURL();
          logger.i('foto: $photoURL');
        }

        // Atualiza nome e imagem no Firebase Auth
        await user.updateDisplayName(name);

        if (photoURL != null) {
          await user.updatePhotoURL(photoURL);
        }

        await user.reload();

        // Salva o papel do usuário no Firestore
        await _firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .set({
          'name': name,
          'email': email,
          'role': 'user',
        });

        logger.i('Usuário registrado com sucesso: ${user.uid}, nome: $name, foto: $photoURL');
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
    } catch (e) {
      logger.e('Erro inesperado ao registrar usuário. Erro: ${e.toString()}');
      return null;
    }
  }

  Future<UserCredential?> getUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      logger.i('Tentando fazer login com o e-mail: $email');

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      logger.i('Login bem-sucedido para o usuário: ${userCredential.user?.uid}');

      // Recupera o role após o login
      String role = await getUserRole(userCredential.user!.uid);

      // Atualizando o role no Provider
      Provider.of<UserRoleProvider>(context, listen: false).role = role;

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

  Future<String> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        UserRole userRole = UserRole.fromMap(userDoc.data() as Map<String, dynamic>);
        return userRole.role;
      } else {
        return 'user'; // Retorne um valor padrão se o usuário não existir no Firestore
      }
    } catch (e) {
      logger.e('Erro ao buscar role do usuário: $e');
      return 'user';  // Retorne um valor padrão em caso de erro
    }
  }

  Future<void> logout() async {
    try {
      logger.i('Tentando fazer logout do usuário atual...');
      await _firebaseAuth.signOut();
      logger.i('Logout realizado com sucesso.');
    } catch (e) {
      logger.e('Erro ao fazer logout: ${e.toString()}');
    }
  }
}
