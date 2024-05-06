import 'package:flutter/material.dart';
import 'package:contact_diary/model/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class ContactDetailPage extends StatefulWidget {
  final ContactModel contact;

  const ContactDetailPage({Key? key, required this.contact}) : super(key: key);

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Contact Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              SizedBox(height: 10),
              if (widget.contact.image != null)
                CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(widget.contact.image!),
                ),
              Text(
                "${widget.contact.name ?? ""}\t${widget.contact.names ?? ""}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 220, top: 50),
                child: Text(
                  "+91 ${widget.contact.number ?? ""}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      launchUrl(Uri.parse("tel:${widget.contact.number}"));
                    },
                    shape: CircleBorder(),
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.call,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        launchUrl(Uri.parse("sms:${widget.contact.number}"));
                      },
                      backgroundColor: Colors.yellow,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.message_outlined,
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        launchUrl(Uri.parse("mailto:${widget.contact.gmail}"));
                      },
                      backgroundColor: Colors.cyan,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.mail,
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  FloatingActionButton(
                      onPressed: () {
                        String con =
                            'The Number of ${widget.contact.name ?? ""} ${widget.contact.names ?? ""},${widget.contact.number ?? ""} ';
                        Share.share(con);
                      },
                      backgroundColor: Colors.orange,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.share,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
