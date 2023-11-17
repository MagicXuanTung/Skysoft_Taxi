import 'package:flutter/material.dart';

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

  // late UserModel user;
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  bool isEmailFieldEmpty = true; // icon delete text
  bool isPasswordFieldEmpty = true; // icon show the password
  bool _obscurePassword = true;
  bool _obscureconfirmPassword = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Image.network(
                      'https://image.winudf.com/v2/image1/Y29tLnNreXNvZnQuZ3BzX2ljb25fMTU1OTE4NzY5NF8wMjQ/icon.png?w=184&fakeurl=1',
                      width: 120,
                      height: 120,
                    ),
                  ),
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
                                    setState(() {
                                      _signUpEmailController.clear();
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
                                    _obscureconfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureconfirmPassword =
                                          !_obscureconfirmPassword;
                                    });
                                  },
                                ),
                        ),
                        obscureText: _obscureconfirmPassword,
                        onChanged: (text) {
                          setState(() {
                            isPasswordFieldEmpty = text.isEmpty;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //sign in button
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen()))
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.cyan,
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreen()))
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
