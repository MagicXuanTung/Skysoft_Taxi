import 'package:flutter/material.dart';

import '../../util/connectivity_handler.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool isEmailFieldEmpty = true;
  bool isPasswordFieldEmpty = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late ConnectivityHandler _connectivityHandler;

  @override
  void initState() {
    super.initState();
    _connectivityHandler = ConnectivityHandler();
    _connectivityHandler.startListening(context);
  }

  @override
  void dispose() {
    _connectivityHandler.stopListening();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool _validatePassword() {
    return _signUpPasswordController.text == _confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const LogoImage(imageUrl: '-assets/images/logo.png'),
                  const SizedBox(height: 10),
                  const Text(
                    'Skysoft Taxi',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Email or Username
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: _signUpEmailController,
                        focusNode: _emailFocusNode,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Colors.grey.shade600, width: 2.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Email hoặc Tên Tài Khoản",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 15),
                          suffixIcon: _signUpEmailController.text.isNotEmpty
                              ? IconButton(
                                  color: Colors.black,
                                  icon: const Icon(Icons.cancel),
                                  onPressed: () {
                                    _signUpEmailController.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                        ),
                        onChanged: (text) {
                          isEmailFieldEmpty = text.isEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //Passwords
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: _signUpPasswordController,
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Colors.grey.shade600, width: 2.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Mật Khẩu",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 15),
                          suffixIcon: isPasswordFieldEmpty
                              ? null
                              : IconButton(
                                  color: Colors.black,
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    _obscurePassword = !_obscurePassword;
                                    setState(() {});
                                  },
                                ),
                        ),
                        obscureText: _obscurePassword,
                        onChanged: (text) {
                          isPasswordFieldEmpty = text.isEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //  ConfirmPassword
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Colors.grey.shade600, width: 2.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: "Xác nhận mật khẩu",
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 15),
                          suffixIcon: isPasswordFieldEmpty
                              ? null
                              : IconButton(
                                  color: Colors.black,
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                    setState(() {});
                                  },
                                ),
                        ),
                        obscureText: _obscureConfirmPassword,
                        onChanged: (text) {
                          isPasswordFieldEmpty = text.isEmpty;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //sign in button
                  GestureDetector(
                    onTap: () => {
                      if (_validatePassword())
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Skysoft Taxi',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text('Đăng ký thành công!'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          ),
                        }
                      else
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Lỗi !',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text('Mật khẩu không trùng.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          ),
                        },
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Đã có tài khoản ứng dụng ?',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            ),
                          },
                          child: Text(
                            'Đăng Nhập',
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
