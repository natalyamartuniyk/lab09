import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Відновлення паролю'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: 'Логін (E-mail)',
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'Введіть логін або E-mail';
                  }
                  if (!value.contains('@')){
                    return 'Некоректний E-mail';
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
                        title: const Text('Надіслано!'),
                        content: Text('Інструкції надіслано для ${_loginController.text}.'),
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
                child: const Text('Надіслати'),
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