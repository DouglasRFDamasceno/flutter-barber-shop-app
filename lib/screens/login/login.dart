import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../Utils/colors.dart';
import '../../Utils/custom_snack_bar.dart';
import '../../Utils/submit_buttom.dart';
import '../../Utils/text_input.dart';
import '../../service/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService _authService = AuthService();

  void initState() {
    super.initState();
    _loadLoginPreferences();
  }

  bool isRegister = false;
  bool rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  File? _userImage;
  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF8D6E63), Color(0xFFD7A86E)],
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        'assets/images/barber_shop.png',
                        height: 260,
                        color: Colors.black,
                      ),
                      Visibility(
                        visible: isRegister,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey[300],
                                backgroundImage:
                                    _userImage != null
                                        ? FileImage(_userImage!)
                                        : null,
                                child:
                                    _userImage == null
                                        ? Icon(
                                          Icons.camera_alt,
                                          size: 40,
                                          color: Colors.grey[700],
                                        )
                                        : null,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        label: "E-mail",
                        hintText: "Digite seu e-mail",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "E-mail inválido";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        label: "Senha",
                        obscureText: true,
                        showPasswordIcon: true,
                        hintText: "Digite sua senha",
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Senha inválida";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: isRegister,
                        child: Column(
                          children: [
                            TextInput(
                              label: "Confirme a senha",
                              obscureText: true,
                              showPasswordIcon: true,
                              hintText: "Confirme sua senha",
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Senha inválida";
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                                visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                              ),
                              const Text(
                                "Lembrar e-mail",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              _showForgotPasswordDialog(context);
                            },
                            child: const Text(
                              "Esqueceu a senha?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SubmitButtom(
                        onPressed: Submit,
                        text: (isRegister) ? "Cadastrar" : "Entrar",
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isRegister = !isRegister;
                          });
                        },
                        child: Text(
                          (isRegister)
                              ? "Tem uma conta? Entre!"
                              : "Ainda não tem conta? Cadastrar-se!",
                          style: TextStyle(
                            color: Color(0xFF5D4037),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Submit() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (isRegister) {
        if (password != confirmPassword) {
          // Exibe mensagem se as senhas forem diferentes
          showCustomSnackBar(
            context,
            'As senhas não coincidem. Por favor, verifique!',
            backgroundColor: RetroColors.red.shade500,
          );

          return;
        } else if (password.length < 6) {
          // Validação de senha com tamanho mínimo
          showCustomSnackBar(
            context,
            'A senha deve ter pelo menos 6 caracteres.',
            backgroundColor: RetroColors.red.shade500,
          );

          return;
        }

        _authService.registerUser(
          name: name,
          email: email,
          password: password,
          imageFile: _userImage,
        );

        showCustomSnackBar(
          context,
          'Usuário cadastrado com sucesso. Realize o Login.',
          backgroundColor: RetroColors.blue.shade500,
        );

        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        _authService.getUser(email: email, password: password).then((
          value,
        ) async {
          if (value != null) {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            // Salva o e-mail no dispositivo caso o usuário queira
            if (rememberMe) {
              await prefs.setString('saved_email', email);
              await prefs.setBool('remember_me', true);
            } else {
              await prefs.remove('saved_email');
              await prefs.setBool('remember_me', false);
            }

            Navigator.pushNamedAndRemoveUntil(
              context,
              "/home",
              (route) => false,
            );
          } else {
            showCustomSnackBar(
              context,
              'Usuário não encontrado!',
              backgroundColor: RetroColors.red.shade500,
            );
          }
        });
      }
    } else {
      showCustomSnackBar(
        context,
        'Erro inesperado!',
        backgroundColor: RetroColors.red.shade500,
      );
    }
  }

  void _loadLoginPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('saved_email');
    bool? savedRememberMe = prefs.getBool('remember_me');

    if (savedEmail != null && savedRememberMe == true) {
      _emailController.text = savedEmail;
      setState(() {
        rememberMe = true;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _userImage = File(pickedFile.path);
      });
    }
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Redefinir senha"),
          content: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Digite seu e-mail",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                if (email.isNotEmpty) {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("E-mail de redefinição enviado!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Erro: ${e.toString()}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text("Enviar"),
            ),
          ],
        );
      },
    );
  }
}
