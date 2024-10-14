import 'package:ai_sample/core/shared/navigate.dart';
import 'package:ai_sample/features/auth/presentation/screens/sign_up.dart';
import 'package:ai_sample/features/auth/presentation/widgets/custom_textbutton.dart';
import 'package:ai_sample/features/auth/presentation/widgets/divider.dart';
import 'package:ai_sample/features/auth/presentation/widgets/login_email_password.dart';
import 'package:ai_sample/features/auth/presentation/widgets/text_field.dart';
import 'package:ai_sample/features/chat_boot/presentation/chat_boot.dart';
import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final List<ArticleEntity> articles;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  LoginScreen(this.articles);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Icon(
                    FontAwesomeIcons.brain,
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text(
                    'Welcome back you have been missed',
                    style: TextStyle(fontSize: 21, color: Colors.grey[800]),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  validator: _validator,
                  controller: userNameController,
                  obscure: false,
                  keyboared: TextInputType.emailAddress,
                  text: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  validator: _validator,
                  controller: passwordController,
                  obscure: true,
                  keyboared: TextInputType.visiblePassword,
                  text: 'Password',
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextButton(
                  text: 'Login',
                  press: () async => await Login(
                      articles: articles,
                      formkey: _formkey,
                      password: passwordController.text,
                      context: context,
                      email: userNameController.text),
                ),
                SizedBox(
                  height: 20,
                ),
                divider(text: 'Sign up if you are not one of us yet'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Not a member ?! ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => _navigateTo_singup(
                          articles: articles, context: context),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validator(dynamic? value) {
    if (value == null || value.isEmpty) {
      return 'Enter somthing valid'; // Error messageWrite
    }
    return null; // Validation passed
  }

  void _navigateTo_singup(
      {required BuildContext context, required List<ArticleEntity> articles}) {
    navigateWithoutBack(context: context, screen: SignUp(articles));
  }
}
