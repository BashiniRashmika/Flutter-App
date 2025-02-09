import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;

  final Quiz quiz = Quiz(
    id: '1',
    lessonId: '1',
    teacherId: 'teacher1',
    title: 'Basic Algebra',
    description: 'A quiz on basic algebra concepts',
    createdAt: DateTime.now(),
    timeLimit: 10,
    questions: [
      QuizQuestion(
        question: 'What is algebra?',
        options: [
          'Study of numbers',
          'Study of mathematical symbols and rules',
          'Study of shapes',
          'Study of statistics'
        ],
        correctAnswer: 1,
        explanation: 'Algebra is the study of mathematical symbols and the rules for manipulating these symbols.',
      ),
      QuizQuestion(
        question: 'Which of these is an algebraic expression?',
        options: [
          '2 + 2 = 4',
          'x + 5 = 10',
          '3.14',
          'ABC'
        ],
        correctAnswer: 1,
        explanation: 'An algebraic expression is an expression built up from integer constants, variables, and the algebraic operations.',
      ),
    ],
  );

  void _handleOptionSelect(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _handleNext() {
    if (_selectedOptionIndex == quiz.questions[_currentQuestionIndex].correctAnswer) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < quiz.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final points = _score * 10;
    userProvider.updatePoints(points);

    if (_score == quiz.questions.length) {
      userProvider.addBadge('Quiz Master');
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('Your score: $_score/${quiz.questions.length}\nPoints earned: $points'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/dashboard');
            },
            child: const Text('Back to Dashboard'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = quiz.questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / quiz.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 16),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${quiz.questions.length}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              question.question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              question.options.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () => _handleOptionSelect(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedOptionIndex == index
                        ? Colors.blue
                        : Colors.grey[200],
                    foregroundColor: _selectedOptionIndex == index
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(question.options[index]),
                  ),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedOptionIndex != null ? _handleNext : null,
              child: Text(
                _currentQuestionIndex == quiz.questions.length - 1
                    ? 'Finish Quiz'
                    : 'Next Question',
              ),
            ),
          ],
        ),
      ),
    );
  }
}