import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/new_baby_profile.dart';
import 'package:flutter_application_1/View/sign_up_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  _SignInPageStateful createState() => _SignInPageStateful();
}

class _SignInPageStateful extends ConsumerState<SignInPage> {
  late TextEditingController _controllerUsername;
  late TextEditingController _controllerPassword;
  @override
  void initState() {
    super.initState();
    _controllerUsername = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerUsername.text = "emirsaid";
    _controllerPassword.text = "Mal.2525";
  }

  @override
  void dispose() {
    super.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.nightlight_round,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: size.height * 0.2,
              top: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hello, \nWelcome Back",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: size.width * 0.1,
                      )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                          width: 30,
                          image: AssetImage('assets/icons/google.png')),
                      SizedBox(width: 40),
                      Image(
                          width: 30,
                          image: AssetImage('assets/icons/facebook.png'))
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      controller: _controllerUsername,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Username"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      obscureText: true,
                      controller: _controllerPassword,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Forgot Password?",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              Column(
                children: [
                  RaisedButton(
                    onPressed: () async {
                      int statusCode = await ApiController.authTokenFetch(
                          context,
                          _controllerUsername.text,
                          _controllerPassword.text);
                      if (statusCode == 200) {
                        await ApiController.fetchBabies(ref);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()));
                      }
                      print("object");
                    },
                    elevation: 0,
                    padding: const EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: Text("Create account",
                          style: Theme.of(context).textTheme.bodyText1))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
