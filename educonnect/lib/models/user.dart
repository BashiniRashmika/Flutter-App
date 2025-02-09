import 'package:flutter/foundation.dart';

enum UserRole {
  student,
  teacher,
}

class User {
  final String id;
  final String username;
  final String email;
  final UserRole role;
  final int points;
  final List<String> badges;
  final List<String> completedLessons;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.points,
    required this.badges,
    required this.completedLessons,
  });
}

class Lesson {
  final String id;
  final String title;
  final String subject;
  final String description;
  final String content;
  final int points;
  final String language;
  final String teacherId;
  final DateTime createdAt;
  final List<String> attachments;

  Lesson({
    required this.id,
    required this.title,
    required this.subject,
    required this.description,
    required this.content,
    required this.points,
    required this.language,
    required this.teacherId,
    required this.createdAt,
    required this.attachments,
  });
}

class Quiz {
  final String id;
  final String lessonId;
  final String teacherId;
  final String title;
  final String description;
  final DateTime createdAt;
  final List<QuizQuestion> questions;
  final int timeLimit; // in minutes

  Quiz({
    required this.id,
    required this.lessonId,
    required this.teacherId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.questions,
    required this.timeLimit,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}

class LearningResource {
  final String id;
  final String title;
  final String description;
  final String content;
  final ResourceType type;
  final String url;
  final String authorId;
  final DateTime createdAt;
  final List<String> tags;
  final UserRole targetAudience;

  LearningResource({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.type,
    required this.url,
    required this.authorId,
    required this.createdAt,
    required this.tags,
    required this.targetAudience,
  });
}

enum ResourceType {
  article,
  video,
  tip,
  questionPaper,
}