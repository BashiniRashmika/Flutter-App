import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        if (user == null) return const Center(child: CircularProgressIndicator());

        return Scaffold(
          appBar: AppBar(
            title: Text(user.role == UserRole.student ? 'Student Dashboard' : 'Teacher Dashboard'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Navigator.pushNamed(context, '/profile'),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildUserStats(user),
              const SizedBox(height: 24),
              if (user.role == UserRole.student) ...[
                _buildStudentSections(context),
              ] else ...[
                _buildTeacherSections(context),
              ],
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Quizzes',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Resources',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 1:
                  Navigator.pushNamed(context, '/quizzes');
                  break;
                case 2:
                  Navigator.pushNamed(
                    context, 
                    user.role == UserRole.student ? '/student-resources' : '/teacher-resources'
                  );
                  break;
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildUserStats(User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              user.username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (user.role == UserRole.student)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('Points', user.points.toString()),
                  _buildStat('Badges', user.badges.length.toString()),
                  _buildStat('Completed', user.completedLessons.length.toString()),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildStudentSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          context,
          'Lessons',
          Icons.book,
          'Access your learning materials',
          () => Navigator.pushNamed(context, '/lessons'),
        ),
        _buildSection(
          context,
          'Question Papers',
          Icons.assignment,
          'Practice with previous papers',
          () => Navigator.pushNamed(context, '/question-papers'),
        ),
        _buildSection(
          context,
          'Learning Resources',
          Icons.library_books,
          'Articles, videos, and study tips',
          () => Navigator.pushNamed(context, '/student-resources'),
        ),
      ],
    );
  }

  Widget _buildTeacherSections(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          context,
          'Create Lesson',
          Icons.create,
          'Create and share new lessons',
          () => Navigator.pushNamed(context, '/create-lesson'),
        ),
        _buildSection(
          context,
          'Create Quiz',
          Icons.quiz,
          'Create new quizzes for students',
          () => Navigator.pushNamed(context, '/create-quiz'),
        ),
        _buildSection(
          context,
          'Question Papers',
          Icons.assignment,
          'Create and manage question papers',
          () => Navigator.pushNamed(context, '/manage-papers'),
        ),
        _buildSection(
          context,
          'Teaching Resources',
          Icons.school,
          'Access teaching materials and tips',
          () => Navigator.pushNamed(context, '/teacher-resources'),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}