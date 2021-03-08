import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import '../../../app_localizations.dart';
import './login_with_google_bar.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(builder: (ctx, constraints) {
      return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return t('Please enter a valid email address.');
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Theme.of(context).primaryColor,
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: t('Email address'),
                          ),
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                      ),
                      if (!_isLogin)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value.isEmpty || value.length < 4) {
                                return t('Please enter at least 4 characters');
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(color: Colors.black),
                              fillColor: Theme.of(context).primaryColor,
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              labelText: t('Username'),
                            ),
                            onSaved: (value) {
                              _userName = value;
                            },
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return t(
                                  'Password must be at least 7 characters long.');
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            labelStyle: TextStyle(color: Colors.black),
                            fillColor: Theme.of(context).primaryColor,
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            labelText: t('Password'),
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _userPassword = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  Column(
                    children: [
                      Button(
                        child: Text(_isLogin ? t('Login') : t('Signup')),
                        onPressed: _trySubmit,
                        pink: true,
                      ),
                      Button(
                        child: Text(_isLogin
                            ? t('Create new account')
                            : t('I already have an account')),
                        onPressed: () {
                          setState(
                            () {
                              _isLogin = !_isLogin;
                            },
                          );
                        },
                        black: true,
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
