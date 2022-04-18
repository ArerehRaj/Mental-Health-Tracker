import 'package:flutter/material.dart';

import '../widgets/text_button.dart';
import '../widgets/my_text_field.dart';
import '../widgets/my_password_field.dart';
import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
  static const routeName = '/register-screen';
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userPhone = '';

  bool passwordVisibility = true;

  void _trySubmit(Function submitFunction) {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
      print(_userPassword);

      submitFunction(
        _userName.trim(),
        _userPassword.trim(),
        _userEmail.trim(),
        _userPhone.trim(),
        false,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final authFunction = routeArgs['auth_function'];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Register",
                              style: kHeadline,
                            ),
                            const Text(
                              "Create new account to get started.",
                              style: kBodyText2,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                style: kBodyText.copyWith(color: Colors.white),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid input';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userName = value.toString();
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: 'Name',
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                style: kBodyText.copyWith(color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid input';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userEmail = value.toString();
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: 'Email',
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                style: kBodyText.copyWith(color: Colors.white),
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid input';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userPhone = value.toString();
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: 'Phone',
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            // MyTextField(
                            //   hintText: 'Name',
                            //   inputType: TextInputType.name,
                            //   inputValue: _userName,
                            // ),
                            // MyTextField(
                            //   hintText: 'Email',
                            //   inputType: TextInputType.emailAddress,
                            //   inputValue: _userEmail,
                            // ),
                            // MyTextField(
                            //   hintText: 'Phone',
                            //   inputType: TextInputType.phone,
                            //   inputValue: _userPhone,
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                style: kBodyText.copyWith(
                                  color: Colors.white,
                                ),
                                obscureText: passwordVisibility,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 7) {
                                    return 'Please enter atleast 7 chars long password.';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _userPassword = value.toString();
                                },
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          passwordVisibility =
                                              !passwordVisibility;
                                        });
                                      },
                                      icon: Icon(
                                        passwordVisibility
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText: 'Password',
                                  hintStyle: kBodyText,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                            // MyPasswordField(
                            //   isPasswordVisible: passwordVisibility,
                            //   onTap: () {
                            //     setState(() {
                            //       passwordVisibility = !passwordVisibility;
                            //     });
                            //   },
                            //   inputValue: _userPassword,
                            // )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        Text(
                          "Sign In",
                          style: kBodyText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Register',
                      onTap: () {
                        _trySubmit(authFunction);
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
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
