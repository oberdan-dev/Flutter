import 'package:flutter/material.dart';
import 'package:growdev_nubank/themes/colors.dart';
import 'package:growdev_nubank/widgets/account_info.dart';
import 'package:growdev_nubank/widgets/card_info.dart';
import 'package:growdev_nubank/widgets/custom_bottom_app_bar.dart';
import 'package:growdev_nubank/widgets/person_identification.dart';
import 'package:growdev_nubank/widgets/tab_option.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        title: PersonIdentification(),
        bottom: CustomBottomAppBar(
          isExpanded: _isExpanded,
          onTap: (){
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          bottom: 20,
          top: 20,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: AccountInfo(
                    isExpanded: _isExpanded,
                  ),
                ),
                SizedBox(height: 15),
                CardInfo(),
                SizedBox(height: 15),
                CardInfo(),
                SizedBox(height: 15),
                CardInfo(),
              ]),
            ),
            SizedBox(height: 20),
            TabOption(),
          ],
        ),
      ),
    );
  }
}
