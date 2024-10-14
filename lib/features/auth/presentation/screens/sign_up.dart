import 'package:ai_sample/core/shared/navigate.dart';
import 'package:ai_sample/features/auth/presentation/screens/login.dart';
import 'package:ai_sample/features/auth/presentation/widgets/custom_textbutton.dart';
import 'package:ai_sample/features/auth/presentation/widgets/divider.dart';
import 'package:ai_sample/features/auth/presentation/widgets/text_field.dart';
import 'package:ai_sample/features/tec_articles/domain/entities/tech_article.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final List<ArticleEntity> articles;

  SignUp(
    this.articles,
  );
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
                  height: 20,
                ),
                Center(
                  child: Icon(
                    FontAwesomeIcons.brain,
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'sign up and be part of the family',
                    style: TextStyle(fontSize: 30, color: Colors.grey[900]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Name',
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
                  controller: namecontroller,
                  obscure: false,
                  keyboared: TextInputType.emailAddress,
                  text: 'Name',
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Phone',
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
                  controller: phonecontroller,
                  obscure: false,
                  keyboared: TextInputType.emailAddress,
                  text: 'Phone',
                ),
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 10,
                ),
                CustomTextButton(
                    text: 'Sign up',
                    press: () async => await _SignUp(
                        articles: articles,
                        context: context,
                        user: userNameController.text,
                        password: passwordController.text)),
                SizedBox(
                  height: 20,
                ),
                divider(text: 'login if aleardy part of the family'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Aleardy member ?! ',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => _navigateTo_login(
                          articles: articles, context: context),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text(
                          'Login',
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

  Future<void> _SignUp({
    required BuildContext context,
    required String user,
    required String password,
    required List<ArticleEntity> articles,
  }) async {
    if (_formkey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user,
          password: password,
        );
        FirebaseAuth.instance!.currentUser!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Verification email has been sent. Please check your inbox.'),
            duration: Duration(seconds: 6),
          ),
        );
        navigateWithoutBack(context: context, screen: LoginScreen(articles));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'weak-password');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: 'email-already-in-use');
          print('The account already exists for that email.');
        }
      } catch (e) {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            title: e.toString());

        print(e);
      }
    }
  }

  void _navigateTo_login(
      {required BuildContext context, required List<ArticleEntity> articles}) {
    navigateWithoutBack(context: context, screen: LoginScreen(articles));
  }
}
