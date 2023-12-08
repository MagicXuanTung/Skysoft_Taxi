import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityHandler {
  static final ConnectivityHandler _instance = ConnectivityHandler._internal();

  factory ConnectivityHandler() {
    return _instance;
  }

  ConnectivityHandler._internal();

  late StreamSubscription<ConnectivityResult> _subscription;
  bool _showLoading = false;

  void startListening(BuildContext context) {
    _subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          showNoInternetToast();
          if (!_showLoading) {
            showLoadingScreen(context);
          }
        } else {
          // Internet connection is restored
          if (_showLoading) {
            Navigator.pop(
                context); // Remove loading screen if it's currently shown
            _showLoading = false;
          }
        }
      },
    );
  }

  void stopListening() {
    _subscription.cancel();
  }

  void showNoInternetToast() {
    Fluttertoast.showToast(
      msg: 'Mất kết nối internet. Vui lòng thử lại sau.',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  void showLoadingScreen(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _showLoading = true;
        return Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const DefaultTextStyle(
              style: TextStyle(decoration: TextDecoration.none),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.lightBlue,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    strokeWidth: 5.0,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
