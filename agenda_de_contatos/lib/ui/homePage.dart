import 'package:flutter/material.dart';
import 'package:agenda_de_contatos/ui/contactPage.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { orderAz, orderZa }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem(
                child: Text('Ordenar de A a Z'),
                value: OrderOptions.orderAz,
              ),
              const PopupMenuItem(
                child: Text('Ordenar de Z a A'),
                value: OrderOptions.orderZa,
              ),
            ],
            onSelected: _orderList,
          )
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: contacts[index].image != null
                          ? FileImage(File(contacts[index].image))
                          : AssetImage('images/person.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        contacts[index].name ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contacts[index].email ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        contacts[index].phone ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          _showOptions(context, index);
        });
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              enableDrag: true,
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.green,
                              ),
                              FlatButton(
                                onPressed: () {
                                  if (contacts[index].phone != null) {
                                    launch('tel:${contacts[index].phone}');
                                  } else{
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text("Número de telefone inválido!"),
                                      duration: Duration(seconds: 3),
                                    ));
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(
                                  'Chamar',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20.0),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.edit, color: Colors.green),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showContactPage(contact: contacts[index]);
                                },
                                child: Text(
                                  'Editar',
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 20.0),
                                ),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.delete, color: Colors.red),
                              FlatButton(
                                onPressed: () {
                                  _deleteConfirmation(index);
                                },
                                child: Text(
                                  'Excluir',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20.0),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                );
              });
        });
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));
    if (recContact != null) {
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  Future _deleteConfirmation(int index) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("EXCLUIR"),
            content: Text("Deseja excluir o contato ${contacts[index].name}?"),
            actions: <Widget>[
              FlatButton(
                child: Text("SIM"),
                onPressed: () {
                  helper.deleteContact(contacts[index].id);
                  Navigator.pop(context);
                  setState(() {
                    contacts.removeAt(index);
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                child: Text("CANCELAR"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _orderList(OrderOptions result) {
    switch (result) {
      case OrderOptions.orderAz:
        contacts.sort((contactA, contactB) {
          return contactA.name
              .toLowerCase()
              .compareTo(contactB.name.toLowerCase());
        });
        break;
      case OrderOptions.orderZa:
        contacts.sort((contactA, contactB) {
          return contactB.name
              .toLowerCase()
              .compareTo(contactA.name.toLowerCase());
        });
        break;
    }
    setState(() {});
  }
}
