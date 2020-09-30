import 'package:flutter/material.dart';
import 'file:///D:/Mobile/Flutter/loja_virtual/lib/tabs/productsTab.dart';
import 'file:///D:/Mobile/Flutter/loja_virtual/lib/widgets/customDrawer.dart';
import 'package:loja_virtual/tabs/homeTab.dart';
import 'package:loja_virtual/widgets/cartButton.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          body: Container(
            color: Colors.yellow,
          ),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          body: Container(
            color: Colors.green,
          ),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
