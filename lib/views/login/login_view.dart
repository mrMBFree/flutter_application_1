import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/my_colors.dart';
import 'package:flutter_application_1/utils/my_images.dart';
import 'package:flutter_application_1/views/home/notes_page.dart';
import 'package:flutter_application_1/views/register/register_view.dart';
import 'login_validation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Change to non-final
  final _formKey = GlobalKey<FormState>();

  void _togglePasswordVisibility() {
    setState(() {
      // Update the state to toggle visibility
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    MyImages.imageLogo,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: MyColors.purpleColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildInputField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icons.person,
                    validator: LoginValidation.validateEmail,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildPasswordInput(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    isPasswordVisible: _isPasswordVisible,
                    validator: LoginValidation.validatePassword,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color.fromARGB(255, 71, 26, 160),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  _buildSignInButton(context),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildSignUpText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    required String? Function(String?) validator, // Change here
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Color.fromARGB(255, 71, 26, 160),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Color.fromARGB(255, 71, 26, 160),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Color.fromARGB(255, 71, 26, 160),
          ),
        ),
        prefixIcon: Icon(prefixIcon, color: MyColors.purpleColor),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 71, 26, 160),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildPasswordInput({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool isPasswordVisible,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Color.fromARGB(255, 71, 26, 160),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Color.fromARGB(255, 71, 26, 160),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Color.fromARGB(255, 71, 26, 160),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            // Toggle visibility when the icon is pressed
            _togglePasswordVisibility();
          },
        ),
        prefixIcon: const Icon(
          Icons.lock,
          color: Color.fromARGB(255, 71, 26, 160),
        ),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 71, 26, 160),
        ),
      ),
      validator: validator, // Zaktualizowano tu
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.purpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(390, 50),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
      ),
      onPressed: () async {
        // Sprawdź poprawność danych logowania
        if (_formKey.currentState?.validate() ?? false) {
          // Pobierz wpisane dane
          final email = _emailController.text;
          final password = _passwordController.text;

          // Sprawdź poprawność loginu
          if (await LoginValidation.validateLogin(email, password)) {
            // Jeśli dane są poprawne, przejdź do HomeView
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const NotesPage(),
              ),
            );
          } else {
            // Jeśli dane są niepoprawne, wyświetl komunikat lub podejmij inne działania
            // W tym przykładzie wyświetlamy komunikat w konsoli
            // ignore: avoid_print
            print('Invalid login credentials');
          }
        }
      },
      child: const Text(
        'Sign In here',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 71, 26, 160),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: MyColors.purpleColor,
            ),
          ),
        ),
      ],
    );
  }
}
