import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PhView extends StatefulWidget {
  const PhView({super.key});

  @override
  State<PhView> createState() => _PhViewState();
}

class _PhViewState extends State<PhView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

}
