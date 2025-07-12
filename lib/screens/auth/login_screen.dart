import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  bool showForm = false;

  @override
  void initState() {
    super.initState();
    // Delay showing the form slightly for a smooth fade-in
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => showForm = true);
    });
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .login(email.trim(), password.trim());
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Welcome to Bima App',
                  textStyle: Theme.of(context).textTheme.headlineSmall,
                  speed: const Duration(milliseconds: 60),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 500),
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              opacity: showForm ? 1 : 0,
              duration: const Duration(milliseconds: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      onChanged: (val) => email = val,
                      validator: (val) => val != null && val.contains('@')
                          ? null
                          : 'Enter valid email',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onChanged: (val) => password = val,
                      validator: (val) => val != null && val.length >= 6
                          ? null
                          : 'Min. 6 characters',
                    ),
                    const SizedBox(height: 24),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isLoading ? 48 : double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(isLoading ? 24 : 8),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: const Text("Don't have an account? Register"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
