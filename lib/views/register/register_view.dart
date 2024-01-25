import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/my_images.dart';
import 'package:flutter_application_1/views/login/login_view.dart';
import 'register_validation.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _areFormFieldsNotEmpty() {
    return _usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  _registerUser() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Wywołaj funkcję z pliku register_validation.dart
    registerValidation(context, username, email, password, confirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            width: 213,
            height: 183,
            top: statusBarHeight - 90,
            left: screenWidth - 166,
            child: Image.asset(MyImages.imageEllipse),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, statusBarHeight + 16, 16, 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.purple,
                    ),
                    label: const Text(
                      'Go Back!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _usernameController,
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordInput(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    isVisible: _isPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordInput(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
                    isVisible: _isConfirmPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 70),
                  _buildRegisterButton(),
                  const SizedBox(height: 8),
                  _buildSignInText(),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.purple),
      ),
    );
  }

  Widget _buildPasswordInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required Function toggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isVisible,
      style: const TextStyle(color: Colors.purple),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.purple,
          ),
          onPressed: () {
            toggleVisibility();
          },
        ),
        prefixIcon: const Icon(Icons.lock, color: Colors.purple),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      width: 390,
      height: 50,
      margin: const EdgeInsets.only(top: 25, left: 0),
      child: ElevatedButton(
        onPressed: () {
          if (_areFormFieldsNotEmpty()) {
            _registerUser();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else {
            _showEmptyFieldsDialog(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSignInText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: const Text(
        'Already have an account? Sign In!',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void _showEmptyFieldsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Empty Fields'),
          content: const Text('Please fill in all the required fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
