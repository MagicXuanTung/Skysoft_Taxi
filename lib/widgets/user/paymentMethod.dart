import 'dart:developer';

import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final Function(IconData icon, String name) onDone;

  const PaymentScreen({Key? key, required this.onDone}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedTip = 0;
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 20,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Phương thức thanh toán",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(left: 16, right: 14),
          children: [
            const Divider(
              height: 2,
              color: Color(0xFFCCCCCC),
            ),
            const SizedBox(height: 20),
            const Text("Lựa chọn phương thức: ",
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            PaymentMethodCheckBox(
              "Tiền mặt",
              this,
              Icons.money,
              iconColor: Colors.green,
            ),
            const SizedBox(height: 16),
            PaymentMethodCheckBox(
              "Ngân hàng",
              this,
              Icons.account_balance,
              iconColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 2,
              color: Color(0xFFCCCCCC),
            ),
            const SizedBox(height: 20),
            const Text("Các ví điện tử khác:", style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text("Ví điện tử"),
              leading: const Icon(Icons.account_balance_wallet),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                log('Ví điện tử');
              },
            ),
            ListTile(
              title: const Text("Thẻ"),
              leading: const Icon(Icons.credit_card),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                log('Thẻ');
              },
            ),
            ListTile(
              title: const Text("Zalo Pay"),
              leading: const Icon(Icons.public),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                log('Zalo Pay');
              },
            ),
            ListTile(
              title: const Text("Momo"),
              leading: const Icon(Icons.monetization_on),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                log('Momo');
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod == "Cash") {
                  widget.onDone(Icons.account_balance_wallet, "Cash");
                } else if (selectedPaymentMethod == "ATM") {
                  widget.onDone(Icons.credit_card, "ATM");
                }

                Navigator.pop(context, selectedPaymentMethod);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                minimumSize: WidgetStateProperty.all(const Size(200, 45)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
              ),
              child: const Text(
                "Xác nhận",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCheckBox extends StatelessWidget {
  final String method;
  final _PaymentScreenState parent;
  final IconData iconData;
  final Color iconColor; // New parameter for icon color

  const PaymentMethodCheckBox(
    this.method,
    this.parent,
    this.iconData, {
    Key? key,
    required this.iconColor, // Add the required iconColor parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: method == parent.selectedPaymentMethod,
          onChanged: (bool? value) {
            // ignore: invalid_use_of_protected_member
            parent.setState(() {
              parent.selectedPaymentMethod = method;
            });
          },
        ),
        Icon(iconData, color: iconColor),
        const SizedBox(width: 5),
        Text(method),
      ],
    );
  }
}
