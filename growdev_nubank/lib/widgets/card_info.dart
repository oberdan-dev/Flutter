import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: Card(
        margin: EdgeInsets.only(right: 20),
        child: Column(
          children: <Widget>[
            Expanded(child: mainBlock()),
            otherBlock(),
          ],
        ),
      ),
    );
  }

  Widget mainBlock() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.credit_card,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Cartão de crédito',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            'FATURA ATUAL',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent[400],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'R\$ 1.546,25',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent[400],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text.rich(
            TextSpan(
              text: 'Limite disponível ',
              children: [
                TextSpan(
                  text: 'R\$ 8.453,75',
                  style: TextStyle(
                    color: Colors.green[400],
                  ),
                ),
              ],
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget otherBlock() {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Icon(
            Icons.home,
            size: 40,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Compra mais recente em estabelecimento XPTO em Cachoeirinha',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right,
          ),
        ],
      ),
    );
  }
}
