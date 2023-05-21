import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String eula = "";

  @override
  void initState() {
    super.initState();
    loadEula();
  }

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();

  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> loadEula() async {
    eula = await rootBundle.loadString('assets/eula.txt');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration Form")),
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (val) => val!.isEmpty || val.length < 3
                        ? "Name must be more than three characters"
                        : null,
                        controller:_nameEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.person),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        val!.isEmpty || !val.contains("@") || !val.contains(".")
                            ? "Enter a valid email address"
                            : null,
                     controller:_emailEditingController,       
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.email),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (val) => val!.isEmpty||                   
                            val.length > 12 ||
                            val.length < 9
                        ? "Enter a valid phone number (should be 10/11 digits)"
                        : null,
                        controller:_phoneEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) => validatePassword(val.toString()),
                    controller: _passEditingController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.password),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) {
                      validatePassword(val.toString());
                      if (val != _passEditingController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    controller:_pass2EditingController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Re-Password',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.password),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: _showEULA,
                          child: const Text(
                            'Agree with terms',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        minWidth: 115,
                        height: 50,
                        elevation: 10,
                        onPressed: _registerAccountDialog,
                        color: Theme.of(context).colorScheme.primary,
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter a password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter a valid password';
      }
    }
    return null;
  }

  void _registerAccountDialog() {
    String _name = _nameEditingController.text;
    String _email = _emailEditingController.text;
    String _phone = _phoneEditingController.text;
    String _pass = _passEditingController.text;
    String _pass2 = _pass2EditingController.text;

    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Please complete the registration form first",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0,
      );
      return;
    }
    if (_pass != _pass2) {
      Fluttertoast.showToast(
          msg: "Please Check your password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please Accept Term",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Register new account?",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser(_name, _email, _phone, _pass);
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showEULA() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "EULA",
            style: TextStyle(),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                eula,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void _registerUser (String name, String email, String phone, String pass){
http.post(Uri.parse("http://192.168.56.1/bartlet/php/register_user.php"),
        body: {"name": name, "email": email, "password": pass})
    .then((response) {
      print(response.body);
    });
}


