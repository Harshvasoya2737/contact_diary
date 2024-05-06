import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:contact_diary/controller/contact_provider.dart';

class DetailPage extends StatefulWidget {
  int? index;

  DetailPage({Key? key, this.index}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late StepperType stepperType = StepperType.vertical;
  File? image;
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController names = TextEditingController();

  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    stepperType = StepperType.vertical;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.index != null) {
      var contact = Provider.of<ContactProvider>(context, listen: false)
          .contactList[widget.index!];
      name.text = contact.name ?? "";
      names.text = contact.names ?? "";
      gmail.text = contact.gmail ?? "";
      number.text = contact.number ?? "";
      image = contact.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(widget.index != null ? "Edit Contact" : "Add Contact"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 80,
              backgroundImage: image != null ? FileImage(image!) : null,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("From Gallery"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromCamera();
                  },
                  child: Text("From Camera"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Stepper(
              type: stepperType,
              currentStep: currentStep,
              onStepCancel: () {
                setState(() {
                  if (currentStep > 0) {
                    currentStep -= 1;
                  }
                });
              },
              onStepContinue: () {
                setState(() {
                  if (currentStep < 3) {
                    currentStep += 1;
                  } else {
                    currentStep = 0;
                  }
                });
              },
              steps: [
                Step(
                  title: Text('Name 1'),
                  content: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  isActive: currentStep >= 0,
                ),
                Step(
                  title: Text('Name 2'),
                  content: TextFormField(
                    controller: names,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  isActive: currentStep >= 1,
                ),
                Step(
                  title: Text('Gmail'),
                  content: TextFormField(
                    controller: gmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  isActive: currentStep >= 2,
                ),
                Step(
                  title: Text('Number'),
                  content: TextFormField(
                    controller: number,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  isActive: currentStep >= 3,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.index != null) {
                  Provider.of<ContactProvider>(context, listen: false)
                      .editContact(
                    widget.index!,
                    name.text,
                    names.text,
                    number.text,
                    gmail.text,
                    image,
                  );
                } else {
                  Provider.of<ContactProvider>(context, listen: false)
                      .addContact(name.text, names.text, number.text,
                          gmail.text, image);
                }
                Navigator.pop(context);
              },
              child: Text(widget.index != null ? "Edit" : "Add"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }
}
