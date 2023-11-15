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
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 45, left: 16, right: 14),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Đặt để nút và chữ "Payment Center" cùng về phía bên trái
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  onPressed: () {
                    // Điều hướng hoặc thực hiện hành động khi ấn nút mũi tên ngược
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                    width:
                        8), // Khoảng cách giữa biểu tượng và chữ "Payment Center"
                const Text(
                  "Payment Methods",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(
              height: 2,
              color: Color(0xFFCCCCCC),
            ),
            const SizedBox(height: 20),
            const Text("Linked Method: ", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            PaymentMethodCheckBox("Cash", this, Icons.account_balance_wallet),
            const SizedBox(height: 16),
            PaymentMethodCheckBox("ATM", this, Icons.credit_card),
            const SizedBox(height: 20),
            const Divider(
              height: 2,
              color: Color(0xFFCCCCCC),
            ),
            const SizedBox(height: 20),
            const Text("Select payment method:",
                style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text("Wallet"),
              leading: const Icon(Icons.account_balance_wallet),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Điều hướng đến trang khác khi bạn chọn Wallet
              },
            ),
            ListTile(
              title: const Text("Cards"),
              leading: const Icon(Icons.credit_card),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Điều hướng đến trang khác khi bạn chọn Cards
              },
            ),
            ListTile(
              title: const Text("Zalo Pay"),
              leading: const Icon(Icons.account_balance_sharp),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Điều hướng đến trang khác khi bạn chọn Zalo Pay
              },
            ),
            ListTile(
              title: const Text("Momo"),
              leading: const Icon(Icons.monetization_on),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Điều hướng đến trang khác khi bạn chọn Momo
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (selectedPaymentMethod == "Cash")
                  widget.onDone(Icons.account_balance_wallet, "Cash");
                if (selectedPaymentMethod == "ATM")
                  widget.onDone(Icons.credit_card, "ATM");

                // Perform payment confirmation
                Navigator.pop(context, selectedPaymentMethod);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Colors.blue), // Đặt màu nền thành màu xanh biển
                minimumSize: MaterialStateProperty.all(
                    const Size(200, 45)), // Điều chỉnh kích thước của nút
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        0))), // Đặt độ cong của góc thành 0 để loại bỏ bo góc
              ),
              child: const Text("Confirm ",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
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

  const PaymentMethodCheckBox(this.method, this.parent, this.iconData,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: method == parent.selectedPaymentMethod,
          onChanged: (bool? value) {
            parent.setState(() {
              parent.selectedPaymentMethod = method;
            });
          },
        ),
        Icon(iconData), // Sử dụng biểu tượng được chuyển vào
        Text(method),
      ],
    );
  }
}
