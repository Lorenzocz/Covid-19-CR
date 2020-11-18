import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: new Scaffold(
          body: GestureDetector(onTap: () {}, child: new ContactList(kContacts))),
    );
  }
}

const kContacts = const <Contact>[
  
  const Contact(
      fullName: 'Licda. Fabiana Loiza Solano',
      depto: 'Becas y Atención Socioeconómicas',
      email: ' ',
      numero: ' 2511-7718'),
      const Contact(
      fullName: 'Licdo. Jhonny Vargas',
      depto: 'Biblioteca UCR Sede Sur',
      email: 'biblioteca.ssur@ucr.ac.cr ',
      numero: ' 2511-7729'),
      const Contact(
      fullName: 'Licdo. Jhonny Vargas',
      depto: 'Biblioteca UCR Sede Sur',
      email: 'biblioteca.ssur@ucr.ac.cr ',
      numero: ' 2511-0129'),
  const Contact(
      fullName: 'MSP. Roxana Hernández Vargas',
      depto: 'Coordinación de Vida Estudiantil',
      email: 'roxana.hernandezvargas@ucr.ac.cr',
      numero: '2511-7708'),
  const Contact(
      fullName: 'Licda. Sheila Vega Hidalgo',
      depto: 'Grupos deportivos, recreativos y artísticos',
      email: 'sheila.vega@ucr.ac.cr',
      numero: '2511-7707'),
  const Contact(
      fullName: 'Mag. Nelsy Camejo Guido',
      depto: 'Psicología',
      email: 'nelsy.camejo@ucr.ac.cr ',
      numero: '2511-7731'),
  const Contact(
      fullName: 'Srta. Nancy García Atencio',
      depto: 'Registro e Información',
      email: 'nancy.garcia@ucr.ac.cr',
      numero: '2511-7704'),
  const Contact(
      fullName: 'Licda. Dilena Navarrete Noel',
      depto: 'Secretaria de coordinación',
      email: 'yeudy.navarrete@ucr.ac.cr ',
      numero: '2511-7707'),
  const Contact(
      fullName: 'Licda. Jessica Aguilar López',
      depto: 'Orientación',
      email: ' jessica.aguilar@ucr.ac.cr',
      numero: '2511-7730'),
];

class ContactList extends StatelessWidget {
  final List<Contact> _contacts;

  ContactList(this._contacts);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      padding: new EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  new _ContactListItem(_contacts[index]),
                ],
              ),
            ),
            Divider(
              color: Colors.blue,
            )
          ],
        );
      },
      itemCount: _contacts.length,
    );
  }
}

class _ContactListItem extends ListTile {
  _ContactListItem(Contact contact)
      : super(
            onTap: () => _launchURL(contact),
            title: new Text(contact.depto,
                style: TextStyle(color: Colors.blue, fontSize: 20)),
            subtitle: new Text(
              'Encargad@: ${contact.fullName}\nEmail: ${contact.email}\nTelefono: ${contact.numero}',
              style: TextStyle(color: Colors.black54),
            ),
            leading: new ClipRRect(
                child: IconButton(
                    tooltip: 'Llamar',
                    icon: Icon(
                      Icons.call,
                      color: Colors.blue,
                    ),
                    onPressed: () => _launchURL(contact))));

  static void _launchURL(Contact contact) async {
    String u = contact.numero;

    if (await canLaunch('tel:' + u)) {
      await launch('tel:' + u);
    } else {
      throw 'Could not launch $u';
    }
  }
}

class Contact {
  final String fullName;
  final String depto;
  final String email;
  final String numero;

  const Contact({this.fullName, this.depto, this.numero, this.email});
}
