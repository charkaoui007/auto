import 'package:authentification/modules/home/screens/pages/port_page.dart';
import 'package:flutter/material.dart';
import 'package:authentification/modules/auth/widgets/email_widget.dart';
import 'package:authentification/modules/auth/widgets/password_widget.dart';
import 'package:authentification/utils/services/local_storage_service.dart';
import 'package:authentification/utils/services/rest_api_service.dart';
import 'package:authentification/modules/home/screens/pages/notification_page.dart';
import '../../../../common/button_widget.dart';

import '../../../../common/logo_widget.dart';
import '../../../../constants/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    children: [
                      const Text(
                        "Welcome",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: const Text(
                          "Check your Portfolio Page",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                EmailWidget(_email),
                PasswordWidget(_password),
                const SizedBox(
                  height: 18,
                ),
                loginButton(),

                if (_isLoading)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: const CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Builder(
        builder: (context) => ButtonWidget("CONNECT", 0, () {
          FocusScope.of(context).unfocus();
          var isValid = _formKey.currentState!.validate();
          checkLoginStatus(context, isValid);
        }),
      );


  checkLoginStatus(BuildContext context, bool isValid) {
    if (isValid) {
      setState(() => _isLoading = true);
      RestApiService.login(_email.text, _password.text).then((value) {
        if (value != null && value.accessToken!.isNotEmpty) {
          setLoginState();
          navigateToPortPage(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              value?.message ?? "Invalid credentials",
              style: const TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.red,
          ));
        }
        setState(() => _isLoading = false);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Wrong Credentials",
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.red,
        ));
        setState(() => _isLoading = false);
      });
    }
  }


  void navigateToNotificationPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NotificationPage()),
    );
  }
  void navigateToPortPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PortPage()),
    );
  }


  void navigateToHomeScreen(BuildContext context) {
    Navigator.popAndPushNamed(context, AppRoutes.home);
  }



  Future setLoginState() async {
    LocalStorageService.setStateLogin(true);
  }
}
