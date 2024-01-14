import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/chat_app/widgets/user_image_pikcer.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<AuthScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  void _onSubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();

    try {
      if (_isLogin) {
        // login
        await _firebase.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
      } else {
        // create
        await _firebase.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
      }
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).clearMaterialBanners();
      String errMsg = err.message ?? 'Error';
      if (err.code == 'email-already-in-use') {
        errMsg = 'Email already in use.';
      }
      if (err.code == 'invalid-email') {
        errMsg = 'Invalid email.';
      }
      if (err.code == 'operation-not-allowed') {
        errMsg = 'Operation not allowed.';
      }
      if (err.code == 'weak-password') {
        errMsg = 'Weak password.';
      }
      if (err.code == 'user-disabled') {
        errMsg = 'User disabled.';
      }
      if (err.code == 'user-not-found') {
        errMsg = 'User not found.';
      }
      if (err.code == 'wrong-password') {
        errMsg = 'Wrong password.';
      }
      print('errMsg$errMsg,${err.code}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errMsg),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin) const UserImagePicker(),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            // 不會自動修正文字
                            autocorrect: false,
                            // 確保文字第一個字不會是大寫
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value;
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            // 使文字無法被看到
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value;
                            },
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                              onPressed: _onSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Login' : 'SignUp')),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I already have an account.'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
