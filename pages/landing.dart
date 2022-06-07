import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thesis/pages/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thesis/pages_with_cubit/courses_page_with_cubit.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    //user == null ? Get.to(AuthPage()) : Get.to(ClassCoursePageWithCubit());
    return user == null ? AuthPage() : ClassCoursePageWithCubit();
  }

}
