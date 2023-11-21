import "package:flutter/material.dart";
import "package:test1/cam.dart";
import "cam.dart";

void main() {
  runApp(home());
}

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: cam(),
    );
  }
}
