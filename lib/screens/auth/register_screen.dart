import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isLoading = false;
  bool showForm = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => showForm = true);
    });
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .signUp(email.trim(), password.trim());
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
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Create your Bima account',
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
                      validator: (val) =>
                      val != null && val.contains('@') ? null : 'Enter valid email',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onChanged: (val) => password = val,
                      validator: (val) =>
                      val != null && val.length >= 6 ? null : 'Min. 6 characters',
                    ),
                    const SizedBox(height: 24),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isLoading ? 48 : double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _register,
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
                            : const Text("Register"),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text("Already have an account? Login"),
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
