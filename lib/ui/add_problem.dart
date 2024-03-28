import 'package:flutter/material.dart ';
import 'package:image_picker/image_picker.dart';

import '../repos/firebase_firestore.dart';

class AddProblem extends StatefulWidget {
  AddProblem({super.key});

  @override
  State<AddProblem> createState() => _AddProblemState();
}

class _AddProblemState extends State<AddProblem> {

  final picker = ImagePicker();
  List<String> selectedImagePaths = [];

  final TextEditingController problemNameController = TextEditingController();

  final TextEditingController problemDescriptionController =
      TextEditingController();
  Future<void> pickImage() async {
    final result = await picker.pickMultiImage();
    if (result != null) {
      setState(() {
        selectedImagePaths = result.map((image) => image.path).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text(
          "Добавление проблемы",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey.shade800,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                TextFieldAddWidget(
                  hintText: "Название проблемы",
                  controller: problemNameController,
                ),
                const SizedBox(
                  height: 24,
                ),

                TextFieldAddWidget(
                  hintText: "Описание проблемы",
                  controller: problemDescriptionController,
                  maxLines:   8,
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  onPressed: pickImage,
                  child: Text("Выбрать фотографии"),
                ),
                TextButton(onPressed: () async{

                  Firebasefirestore().addProblemToFirestore(problemName: problemNameController.text , description: problemDescriptionController.text, imagePaths: selectedImagePaths
                  );

                }, child: Text("Добавить проблему", style: TextStyle(color: Colors.white, fontSize: 24),))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldAddWidget extends StatelessWidget {
  final hintText;
  final controller;
  final maxLines;


  const TextFieldAddWidget(
      {super.key, required this.hintText, required this.controller, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      cursorColor: Colors.white,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade600),
        filled: true,
        fillColor: Colors.grey.shade800,
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white)),
      ),
      style: TextStyle(color: Colors.grey.shade300),
    );
  }
}
