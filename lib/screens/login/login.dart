import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Utils/custom_dialog.dart';
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

  bool isRegister = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                      const SizedBox(height: 20),
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
            backgroundColor: Colors.red,
          );
        } else if (password.length < 6) {
          // Validação de senha com tamanho mínimo
          showCustomSnackBar(
            context,
            'A senha deve ter pelo menos 6 caracteres.',
            backgroundColor: Colors.red,
          );
        }

        _authService.registerUser(name: name, email: email, password: password);
      } else {
        _authService.getUser(email: email, password: password).then((value) {
          if (value != null) {
            print("${value.user?.displayName}");

            Navigator.pushNamedAndRemoveUntil(
              context,
              "home",
              (route) => false,
            );
          }
        });
      }
    } else {
      print("Formulário inválido!");
    }
  }
}
