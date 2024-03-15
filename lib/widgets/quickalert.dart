import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: 'Transaction Completed Successfully!',
            );
          },
          child: Text("showdialog"),
        ),
      ),
    );
  }
}
