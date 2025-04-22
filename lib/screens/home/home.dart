import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barber_shop_app/service/auth_service.dart';

import '../../Utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: RetroColors.brown.shade500,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              _buildMenuItems(context),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text("Home"),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return DrawerHeader(
      decoration: BoxDecoration(color: RetroColors.orange.shade600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
            backgroundColor: Colors.white24,
            child: user?.photoURL == null
                ? const Icon(Icons.person, size: 40, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              user?.displayName ?? 'Usuário',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              user?.email ?? 'E-mail',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Página Inicial'),
          onTap: () {
            Navigator.pop(context); // Fecha o drawer
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          onTap: () {
            Navigator.pop(context);
            // Navegar para perfil
            Navigator.pushNamed(context, '/perfil');
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sair'),
          onTap: () {
            _authService.logout();
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/login",
                  (route) => false,
            );
          },
        ),
      ],
    );
  }
}