import 'package:flutter/material.dart';
import '../models/user.dart';

class LessonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lesson = ModalRoute.of(context)!.settings.arguments as Lesson;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLessonDetailsCard(lesson, context),
            const SizedBox(height: 24),
            _buildLessonContent(lesson.content),
            const SizedBox(height: 24),
            _buildTakeQuizButton(context, lesson.id),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonDetailsCard(Lesson lesson, BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.subject,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              lesson.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text('Points: ${lesson.points}'),
                  backgroundColor: Colors.blue.shade100,
                ),
                Chip(
                  label: Text('Language: ${lesson.language}'),
                  backgroundColor: Colors.green.shade100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonContent(String content) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lesson Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTakeQuizButton(BuildContext context, String lessonId) {
    return Center(
      child: ElevatedButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/quiz', arguments: lessonId),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
          backgroundColor: const Color.fromARGB(255, 33, 78, 155),
        ),
        child: const Text(
          'Take Quiz',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
