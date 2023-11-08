import 'package:flutter/material.dart';
import 'package:skysoft_taxi/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool isEmailFieldEmpty = true;
  bool isPasswordFieldEmpty = true;

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey[500]!, Colors.grey[300]!],
            ),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 32.0),
              FittedBox(
                fit: BoxFit.contain,
                child: Image.network(
                  'https://image.winudf.com/v2/image1/Y29tLnNreXNvZnQuZ3BzX2ljb25fMTU1OTE4NzY5NF8wMjQ/icon.png?w=184&fakeurl=1',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'SkySoft Taxi Booking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.blueGrey,
                tabs: [
                  Tab(text: 'Login'),
                  Tab(text: 'Signup'),
                ],
              ),
              const SizedBox(height: 16.0),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Email or Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            suffixIcon: _emailController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () {
                                      setState(() {
                                        _emailController.clear();
                                      });
                                    },
                                  )
                                : null,
                          ),
                          onChanged: (text) {
                            setState(() {
                              isEmailFieldEmpty = text.isEmpty;
                            });
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            suffixIcon: isPasswordFieldEmpty
                                ? null
                                : IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                          ),
                          obscureText: _obscurePassword,
                          onChanged: (text) {
                            setState(() {
                              isPasswordFieldEmpty = text.isEmpty;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
