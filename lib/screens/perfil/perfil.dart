import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


import '../../Utils/colors.dart';
import '../../Utils/custom_snack_bar.dart';
import '../../Utils/submit_buttom.dart';
import '../../Utils/text_input.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  File? _newImageFile;

  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = user.displayName ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = '';
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _newImageFile = File(picked.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    String? photoURL;

    // Atualizar imagem se tiver nova
    if (_newImageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_profiles/${user.uid}.jpg');

      await ref.putFile(_newImageFile!);
      photoURL = await ref.getDownloadURL();
    }

    // Atualizar nome, foto e telefone
    await user.updateDisplayName(_nameController.text);
    if (photoURL != null) await user.updatePhotoURL(photoURL);

    // Atualizar o telefone no Firestore
    final phone = _phoneController.text;

    await user.reload();

    // Atualiza tela com novas infos
    setState(() {});

    showCustomSnackBar(
      context,
      'Perfil atualizado com sucesso!',
      backgroundColor: RetroColors.green.shade500,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final photo = _newImageFile != null
        ? FileImage(_newImageFile!)
        : (user.photoURL != null
        ? NetworkImage(user.photoURL!)
        : const AssetImage('assets/default_user.png')) as ImageProvider;

    // Configurando a máscara de telefone
    final phoneInputFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: RetroColors.brown.shade500,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    backgroundImage: photo,
                    radius: 75,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextInput(
                      label: "Nome",
                      hintText: "Digite seu nome",
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nome inválido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInput(
                      label: "Telefone",
                      hintText: "Digite seu telefone",
                      controller: _phoneController,
                      inputFormatter: phoneInputFormatter,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Telefone inválido";
                        }
                        final phoneRegex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');
                        if (!phoneRegex.hasMatch(value)) {
                          return "Telefone inválido. Formato esperado: (XX) XXXXX-XXXX";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextInput(
                      label: "E-mail",
                      enabled: false,
                      hintText: "Digite seu e-mail",
                      controller: _emailController,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SubmitButtom(
                  onPressed: _saveChanges,
                  text: "Salvar Alterações",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
