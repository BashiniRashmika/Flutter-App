import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  void _handleLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(User(
          id: '1',
          username: 'Test User',
          email: _emailController.text,
          role: _emailController.text.contains('teacher')
              ? UserRole.teacher
              : UserRole.student,
          points: 0,
          badges: [],
          completedLessons: [],
        ));

        Navigator.pushReplacementNamed(context, '/dashboard');
      });
    } else {
      setState(() {
        _errorMessage = 'Please enter both email and password';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter both email and password'),
          backgroundColor: const Color.fromARGB(255, 176, 26, 26),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 33, 38, 129),
              const Color.fromARGB(
                  255, 113, 153, 213), // Purple shade from the image
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to EduConnect',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: const Color.fromARGB(255, 246, 243, 243),
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                      _emailController, 'Email', Icons.email, false),
                  const SizedBox(height: 16),
                  _buildInputField(
                      _passwordController, 'Password', Icons.lock, true),
                  const SizedBox(height: 24),
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 118, 32, 25)),
                    ),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 210, 86, 48), // Green shade
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 183, 196, 204))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label,
      IconData icon, bool isPassword) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      obscureText: isPassword && !_isPasswordVisible,
    );
  }
}
