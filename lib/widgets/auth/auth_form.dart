import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      String email, String password, String userName, bool isLogin) submitFn;
  final bool isLoading;

  const AuthForm({Key? key, required this.submitFn, required this.isLoading})
      : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = false;

  String? _userEmail;
  String? _userPassword;
  String _userName = '';

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail!.trim(), _userPassword!.trim(),
          _userName.trim(), _isLogin);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                // This column take minium space for its children
                mainAxisSize: MainAxisSize.min,

                children: [
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('user name'),
                      decoration: InputDecoration(
                        label: Text('User name'),
                      ),
                      validator:
                          RequiredValidator(errorText: 'User name is required'),
                      onSaved: (val) {
                        _userName = val!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      label: Text('Email address'),
                      hintText: 'abc@gmail.com',
                    ),
                    validator: MultiValidator(
                      [
                        EmailValidator(errorText: 'Please enter valid email'),
                        RequiredValidator(errorText: 'Email is required')
                      ],
                    ),
                    onSaved: (val) {
                      _userEmail = val;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Password'),
                    ),
                    validator: (val) {
                      if (val == null || val.length < 6) {
                        return 'Password atleast 7 characters long';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _userPassword = val;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (!widget.isLoading)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: _submit,
                      child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account!'),
                    ),
                  if (widget.isLoading) CircularProgressIndicator()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
