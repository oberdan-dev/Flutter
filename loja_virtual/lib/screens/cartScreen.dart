import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cartModel.dart';
import 'package:loja_virtual/models/userModel.dart';
import 'package:loja_virtual/screens/loginScreen.dart';
import 'package:loja_virtual/tiles/CartTile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int productsQuantity = model.products.length;
                return Text(
                  '${productsQuantity ?? 0} ${productsQuantity == 1
                      ? 'ITEM'
                      : 'ITENS'}',
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        // ignore: missing_return
          builder: (context, child, model) {
            if (model.isLoading && UserModel.of(context).isLoggedIn()) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (!UserModel.of(context).isLoggedIn()) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove_shopping_cart,
                      size: 80.0,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Faça o login para adicionar itens ao carrinho!',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    RaisedButton(
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        }),
                  ],
                ),
              );
            } else if (model.products == null || model.products.length == 0) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.exposure_zero,
                      size: 80.0,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'O carrinho está vazio!',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return ListView(
                children: <Widget>[
                  Column(
                    children: model.products.map((product){
                      return CartTile(product);
                    }).toList(),
                  )
                ],
              );
            }
          }),
    );
  }
}
