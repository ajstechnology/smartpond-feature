import 'package:flutter/material.dart';

class CommingSoon extends StatelessWidget {
  final String title;
  CommingSoon(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Center(
        child: Text("Comming Soon"),
      ),
    );
  }
}
