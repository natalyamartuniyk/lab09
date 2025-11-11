import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true;
  bool _isConfirmObscured = true;
  final _confirmPasswordController = TextEditingController();



  @override
  void dispose() {
    _nameController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Реєстрація'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Ім'я користувача",
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Введіть імʼя';
                  }
                  return null;
                }
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: 'Логін (E-mail)',
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Введіть E-mail';
                  }
                  if (!value.contains('@')){
                    return 'Некоректний E-mail';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

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
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Введіть пароль';
                  }
                  if (value.length < 7) {
                    return 'Пароль має бути від 7 символів';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              //перевірка

              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isConfirmObscured,
                decoration: InputDecoration(
                  labelText: 'Підтвердіть пароль',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: (){
                      setState(() {
                        _isConfirmObscured = !_isConfirmObscured;
                      });
                    },
                  ),

                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Введіть пароль';
                  }
                  if (value != _passwordController.text) {
                    return 'Паролі не співпадають';
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
                        title: const Text('Успіх!'),
                        content: Text('Акаунт для ${_nameController.text} створено!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              Navigator.pop(context);
                            },
                            child: const Text('Чудово!'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Зареєструватися'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Повернутися до авторизації'),
              ),
            ],
          ),

        ),

      ),
    );
  }
}