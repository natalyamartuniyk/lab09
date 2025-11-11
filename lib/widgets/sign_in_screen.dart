import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'reset_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Екран Авторизації'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [

                Image.asset(
                  'assets/images/flutter-icon.webp',
                  height: 100,
                ),

                const SizedBox(height: 30),

                //логін
                TextFormField(
                  controller: _loginController,
                  decoration: const InputDecoration(
                    labelText: 'Логін',
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Введіть логін';
                    }
                    if (!value.contains('@')){
                      return 'Некоректний E-mail';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                //пароль
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    labelText: 'Пароль',

                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: (){
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Введіть пароль';
                    }
                    if (value.length < 7){
                      return 'Пароль має бути від 7 символів';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Успіх'),
                          content: Text('Вхід дозволено для ${_loginController.text}'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Увійти'),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text('Реєстрація'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                        );
                      },
                      child: const Text('Забули пароль?'),
                    ),
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}
