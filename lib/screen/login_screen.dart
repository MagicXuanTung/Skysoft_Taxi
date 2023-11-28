import 'package:flutter/material.dart';
import 'package:skysoft_taxi/global/global.dart';
import 'package:skysoft_taxi/models/user.model.dart';
import 'package:skysoft_taxi/screen/homeDriver.dart';
import 'package:skysoft_taxi/screen/xanh_sm_clone_User/home_user_xanh_sm.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  late UserModel user;

  bool isEmailFieldEmpty = true;
  bool isPasswordFieldEmpty = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
                        controller: _emailController,
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
                          suffixIcon: _emailController.text.isNotEmpty
                              ? IconButton(
                                  color: Colors.black,
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
                    ),
                  ),
                  const SizedBox(height: 15),
                  //Passwords
                  SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: _passwordController,
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
                  GestureDetector(
                    onTap: () {
                      String enteredUsername = _emailController.text;
                      List<String> temp = enteredUsername.split(".");
                      String role = temp.first;
                      String userName = temp.last;
                      if (role == "user") {
                        // Đăng nhập thành công với tài khoản user, chuyển đến trang Home.
                        userModel.name = userName;
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const HomeUserXanhSm();
                          },
                        ));
                        userModel.changeStatusWithMessage("ENDTRIP");
                      } else if (role == "driver") {
                        // Đăng nhập thành công với tài khoản driver, chuyển đến trang HomeDriver.
                        driverModel.name = userName;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const HomeDriver();
                            },
                          ),
                        );
                        driverModel.changeStatusWithMessage("ENDTRIP");
                      } else {
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
                              content: const Text('Lỗi đăng nhập tài khoản.'),
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
                        );
                      }
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
                          'Đăng Nhập',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Register now
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Người dùng mới sử dụng?',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterScreen()))
                          },
                          child: Text(
                            'Đăng ký',
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
