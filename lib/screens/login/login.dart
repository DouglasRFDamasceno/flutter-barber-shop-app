import 'package:flutter/material.dart';
import '../../Utils/text_input.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRegister = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                colors: [
                  Color(0xFF8D6E63),
                  Color(0xFFD7A86E),
                ],
              ),
            ),
          ),
          Form(
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
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6D4C41),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black,
                        ),
                        child: Text(
                          (isRegister) ? "Cadastrar" : "Entrar",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFF3E0),
                          ),
                        ),
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
                              : "Ainda não tem conta? Cadastrar-se",
                          style: TextStyle(
                            color: Color(0xFF5D4037),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
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
}
