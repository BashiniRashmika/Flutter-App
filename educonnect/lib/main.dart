import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/lesson_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/student/student_resources_screen.dart';
import 'screens/student/question_papers_screen.dart';
import 'screens/teacher/create_lesson_screen.dart';
import 'screens/teacher/create_quiz_screen.dart';
import 'screens/teacher/manage_papers_screen.dart';
import 'screens/teacher/teacher_resources_screen.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: EduConnectApp(),
    ),
  );
}

class EduConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/lesson': (context) => LessonScreen(),
        '/quiz': (context) => QuizScreen(),
        '/profile': (context) => ProfileScreen(),
        // Student routes
        '/student-resources': (context) => StudentResourcesScreen(),
        '/question-papers': (context) => QuestionPapersScreen(),
        // Teacher routes
        '/create-lesson': (context) => CreateLessonScreen(),
        '/create-quiz': (context) => CreateQuizScreen(),
        '/manage-papers': (context) => ManagePapersScreen(),
        '/teacher-resources': (context) => TeacherResourcesScreen(),
      },
    );
  }
}

class QuestionPapersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Papers'),
      ),
      body: Center(
        child: Text('Question Papers Screen'),
      ),
    );
  }
}

class TeacherResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Resources'),
      ),
      body: Center(
        child: Text('Teacher Resources Screen'),
      ),
    );
  }
}

class ManagePapersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Papers'),
      ),
      body: Center(
        child: Text('Manage Papers Screen'),
      ),
    );
  }
}

class CreateQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Quiz'),
      ),
      body: Center(
        child: Text('Create Quiz Screen'),
      ),
    );
  }
}