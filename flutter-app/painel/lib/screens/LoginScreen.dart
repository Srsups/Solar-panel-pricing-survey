import 'dart:ui'; // Import necessário para ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(SolarLoginApp());

class SolarLoginApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: '/forgot',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/create-account',
        builder: (context, state) => CreateAccountScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF023047);
  final Color accentColor = Color(0xFF219EBC);
  final Color darkBlue = Color(0xFF023047);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/solar_background1.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.6),
            colorBlendMode: BlendMode.darken,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // Bordas arredondadas
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Desfoque
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2), // Transparência
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3), // Borda esmaecida
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo or title
                      Text(
                        "Your logo",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      // Login title
                      Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 24),
                      // Email TextField
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: accentColor),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      // Password TextField
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: accentColor),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      // Forgot password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.go('/forgot');
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: accentColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Sign in button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          context.go('/home');
                        },
                        child: Center(
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Divider with "or continue with"
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "or continue with",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Social login buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.google, color: accentColor),
                            iconSize: 40,
                            onPressed: () {
                              // Ação para login com Google
                            },
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.github, color: accentColor),
                            iconSize: 40,
                            onPressed: () {
                              // Ação para login com GitHub
                            },
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.facebook, color: accentColor),
                            iconSize: 40,
                            onPressed: () {
                              // Ação para login com Facebook
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Register link
                      TextButton(
                        onPressed: () {
                          context.go('/create-account');
                        },
                        child: Text(
                          "Don't have an account? Register for free",
                          style: TextStyle(color: accentColor),
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel Solar'),
        backgroundColor: Color(0xFFFFB703),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => context.go('/profile'),
          )
        ],
      ),
      body: Center(
        child: Text('Bem-vindo a calculadora de energia solar!',
            style: TextStyle(fontSize: 24, color: Colors.black)),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Color(0xFFFFB703),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text('Usuário', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: Text('Sair'),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueci minha senha'),
        backgroundColor: Color(0xFFFFB703),
      ),
      body: Center(
        child: Text('Tela de recuperação de senha em construção!',
            style: TextStyle(fontSize: 24, color: Colors.black)),
      ),
    );
  }
}

class CreateAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta'),
        backgroundColor: Color(0xFFFFB703),
      ),
      body: Center(
        child: Text('Tela de criação de conta em construção!',
            style: TextStyle(fontSize: 24, color: Colors.black)),
      ),
    );
  }
}