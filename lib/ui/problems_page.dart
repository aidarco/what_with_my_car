import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/problemModel.dart';

class Problem extends StatefulWidget {
  const Problem({super.key});

  @override
  State<Problem> createState() => _ProblemState();
}

class _ProblemState extends State<Problem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text(
          "Проблемы",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.grey.shade800,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('problems').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final problems = snapshot.data!.docs
              .map((doc) =>
                  ProblemModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return Stack(
            children: [
              ListView.builder(
                itemCount: problems.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            width: double.infinity,
                            height: 330,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              image: problems[index].imageUrls.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          problems[index].imageUrls.first),
                                      fit: BoxFit.cover)
                                  : const DecorationImage(
                                      image: AssetImage("lib/images/ss.webp"),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Text(
                          problems[index].id,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          problems[index].userId,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          problems[index].description,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  right: 20,
                  bottom: 20,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "add");
                      },
                      child: Text(
                        "Добавить",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ))),
            ],
          );
        },
      ),
    );
  }
}
