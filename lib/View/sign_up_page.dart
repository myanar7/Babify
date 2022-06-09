import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageStateful createState() => _SignUpPageStateful();
}

class _SignUpPageStateful extends State<SignUpPage> {
  late TextEditingController _controllerUsername;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerFirstName;
  late TextEditingController _controllerLastName;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerConfirmPassword;
  late TextEditingController _controllerPhoneNumber;
  @override
  void initState() {
    super.initState();
    _controllerUsername = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerFirstName = TextEditingController();
    _controllerLastName = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPhoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    _controllerEmail.dispose();
    _controllerLastName.dispose();
    _controllerFirstName.dispose();
    _controllerPhoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.nightlight_round,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          //height: size.height,
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: size.height * 0.2,
              top: size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Create \nNew Account",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: size.width * 0.1,
                      )),
              const SizedBox(
                height: 20,
              ),
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
                      controller: _controllerFirstName,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "First Name"),
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
                      controller: _controllerLastName,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Last Name"),
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
                      controller: _controllerEmail,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "E-mail"),
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
                      keyboardType: TextInputType.number,
                      controller: _controllerPhoneNumber,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Phone Number"),
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      obscureText: true,
                      controller: _controllerConfirmPassword,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Confirm Password"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () => {
                      ApiController.authRegisterFetch(
                          context,
                          _controllerEmail.text,
                          _controllerUsername.text,
                          _controllerPassword.text)
                    },
                    elevation: 0,
                    padding: const EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                      "Create",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
