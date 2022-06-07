import 'package:flutter/material.dart';
import 'package:thesis/pages/landing.dart';
import 'package:get/get.dart';


class MaterialAppClass extends StatelessWidget {
  const MaterialAppClass({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Thesis App',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Landing(), //initialRoute : '/',
    );
  }
}
