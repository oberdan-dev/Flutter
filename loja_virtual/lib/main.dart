import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cartModel.dart';
import 'package:loja_virtual/models/userModel.dart';
import 'package:loja_virtual/screens/homeScreen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              home: HomeScreen(),
              title: 'Fardin Store',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.purple,
                primaryColor: Color.fromARGB(255, 4, 125, 141),
              ),
            ),
          );
        }));
  }
}
