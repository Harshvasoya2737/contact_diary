import 'package:contact_diary/controller/contact_provider.dart';
import 'package:contact_diary/model/contact_model.dart';
import 'package:contact_diary/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:contact_diary/controller/theme_provider.dart';
import 'contact_detail.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool contactsExist = false;

  @override
  void didChangeDependencies() {
    SharedPreferences.getInstance().then((value) {
      var themeMode = value.getInt("themeMode");
      Provider.of<ThemeProvider>(context, listen: false)
          .changeTheme(themeMode ?? 0);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text("Contacts", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 168),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(child: Text("System"), value: 0),
                PopupMenuItem(child: Text("Light"), value: 1),
                PopupMenuItem(child: Text("Dark"), value: 2),
              ];
            },
            onSelected: (value) async {
              var instance = await SharedPreferences.getInstance();
              instance.setInt("themeMode", value ?? 0);

              Provider.of<ThemeProvider>(context, listen: false)
                  .changeTheme(value ?? 0);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Hi,Welecome to Your Contact Diary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {
                // Perform exit action
                Navigator.pop(context); // Close the drawer
              },
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<ThemeProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Row(
                    children: [
                      Text(
                        "Theme :",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton(
                        dropdownColor: Colors.black38,
                        value: value.themeMode,
                        items: [
                          DropdownMenuItem(child: Text("System"), value: 0),
                          DropdownMenuItem(child: Text("Light"), value: 1),
                          DropdownMenuItem(child: Text("Dark"), value: 2),
                        ],
                        onChanged: (value) async {
                          var instance = await SharedPreferences.getInstance();
                          instance.setInt("themeMode", value ?? 0);

                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme(value ?? 0);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          contactsExist = value.contactList.isNotEmpty;
          return contactsExist
              ? ListView.builder(
                  itemCount: value.contactList.length,
                  itemBuilder: (context, index) {
                    ContactModel contact = value.contactList[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ContactDetailPage(contact: contact);
                            },
                          ),
                        );
                      },
                      leading: InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          backgroundImage: contact.image != null
                              ? FileImage(contact.image!)
                              : null,
                          child: contact.image == null
                              ? Text("${contact.name ?? ""}"[0].toUpperCase())
                              : null,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(contact.name ?? ""),
                          SizedBox(
                            width: 5,
                          ),
                          Text(contact.names ?? ""),
                        ],
                      ),
                      subtitle: Text(contact.number ?? ""),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                launchUrl(Uri.parse("tel:${contact.number}"));
                              },
                              icon: Icon(Icons.call)),
                          SizedBox(
                            width: 25,
                          ),
                          PopupMenuButton(
                            child: Icon(Icons.edit),
                            tooltip: "",
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Text("Edit"),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return DetailPage(
                                          index: index,
                                        );
                                      },
                                    ));
                                  },
                                ),
                                PopupMenuItem(
                                  child: Text("Delete"),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Delete Contact"),
                                          content: Text(
                                              "Are you sure you want to delete (${contact.name ?? ""}) Contact number (${contact.number})?"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Provider.of<ContactProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteContact(index);
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              child: Text("Delete"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.contact_mail_outlined,
                        size: 150,
                      ),
                      Text(
                        "You have no contacts yet.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailPage();
            },
          ));
        },
        child: Icon(Icons.person_add_alt_1_outlined),
      ),
    );
  }
}
