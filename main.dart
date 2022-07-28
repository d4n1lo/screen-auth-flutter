import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    initialRoute: "/login",
    routes: {
      "/login": (context) => LoginPage(),
      "/home": (context) => HomePage()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Usuario Logado com Sucesso!")),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username;
  String? password;

  var isLoading = false;

  final formKey = GlobalKey<FormState>();

  void login({
    required String username,
    required String password,
  }) async {
    isLoading = true;
    setState(() {});
    final response = await apiLogin(username: username, password: password);
    isLoading = false;
    setState(() {});
    if (response) {
      Navigator.pushNamed(context, "/home");
    }
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  String? validateUsername(String? username) =>
      username != null && username.isNotEmpty ? null : "Login incorreto";
  String? validatePassword(String? password) =>
      password != null && password.length >= 6
          ? null
          : "A senha precisa de no mínimo 6 caracteres";

  Future<bool> apiLogin(
      {required String username, required String password}) async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.email), hintText: "Username"),
              validator: (value) => validateUsername(value),
              onSaved: (value) => username = value,
            ),
            TextFormField(
              validator: (value) => validatePassword(value),
              onSaved: (value) => password = value,
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                hintText: "Password",
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 32,
            ),
            if (isLoading)
              CircularProgressIndicator()
            else
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    if (validate()) {
                      login(username: username!, password: password!);
                    }
                    print("Username $username | Password $password");
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ))
          ],
        ),
      ),
    ));
  }
}
