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
        if (user == null)
          return const Center(child: CircularProgressIndicator());

        return Scaffold(
          appBar: AppBar(
            title: Text(
              user.role == UserRole.student
                  ? 'Student Dashboard'
                  : 'Teacher Dashboard',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 65, 112, 195),
            actions: [
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/profile'),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz),
                label: 'Quizzes',
              ),
              BottomNavigationBarItem(
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
                    user.role == UserRole.student
                        ? '/student-resources'
                        : '/teacher-resources',
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      color: const Color.fromARGB(255, 59, 100, 171),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              user.username,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            if (user.role == UserRole.student)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('Points', user.points.toString(), Icons.star),
                  _buildStat('Badges', user.badges.length.toString(),
                      Icons.emoji_events),
                  _buildStat(
                      'Completed',
                      user.completedLessons.length.toString(),
                      Icons.check_circle),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildStudentSections(BuildContext context) {
    return Column(
      children: [
        _buildSection(context, 'Lessons', Icons.book,
            'Access your learning materials', '/lessons'),
        _buildSection(context, 'Question Papers', Icons.assignment,
            'Practice with previous papers', '/question-papers'),
        _buildSection(context, 'Learning Resources', Icons.library_books,
            'Articles, videos, and study tips', '/student-resources'),
      ],
    );
  }

  Widget _buildTeacherSections(BuildContext context) {
    return Column(
      children: [
        _buildSection(context, 'Create Lesson', Icons.create,
            'Create and share new lessons', '/create-lesson'),
        _buildSection(context, 'Create Quiz', Icons.quiz,
            'Create new quizzes for students', '/create-quiz'),
        _buildSection(context, 'Manage Papers', Icons.assignment,
            'Create and manage question papers', '/manage-papers'),
        _buildSection(context, 'Teaching Resources', Icons.school,
            'Access teaching materials and tips', '/teacher-resources'),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, IconData icon,
      String description, String route) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 44, 100, 196),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
