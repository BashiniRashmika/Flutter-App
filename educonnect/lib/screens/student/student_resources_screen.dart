import 'package:flutter/material.dart';
import '../../models/user.dart';

class StudentResourcesScreen extends StatelessWidget {
  final List<LearningResource> resources = [
    LearningResource(
      id: '1',
      title: 'How to Study Effectively',
      description: 'Learn the best techniques for effective studying',
      content: 'Detailed content about study techniques...',
      type: ResourceType.article,
      url: '',
      authorId: 'teacher1',
      createdAt: DateTime.now(),
      tags: ['study', 'tips'],
      targetAudience: UserRole.student,
    ),
    // Add more sample resources
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Learning Resources',
              style: TextStyle(fontWeight: FontWeight.bold)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 32, 52, 126),
                  Color.fromARGB(255, 75, 102, 159)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.article), text: 'Articles'),
              Tab(icon: Icon(Icons.video_library), text: 'Videos'),
              Tab(icon: Icon(Icons.lightbulb), text: 'Tips'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildResourceList(ResourceType.article),
            _buildResourceList(ResourceType.video),
            _buildResourceList(ResourceType.tip),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceList(ResourceType type) {
    final filteredResources = resources.where((r) => r.type == type).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredResources.length,
      itemBuilder: (context, index) {
        final resource = filteredResources[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 56, 100, 211),
              child: Icon(_getIconForType(resource.type), color: Colors.white),
            ),
            title: Text(resource.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(resource.description),
            trailing: const Icon(Icons.chevron_right,
                color: Color.fromARGB(255, 54, 98, 172)),
            onTap: () {
              // Navigate to resource detail screen
            },
          ),
        );
      },
    );
  }

  IconData _getIconForType(ResourceType type) {
    switch (type) {
      case ResourceType.article:
        return Icons.article;
      case ResourceType.video:
        return Icons.video_library;
      case ResourceType.tip:
        return Icons.lightbulb;
      case ResourceType.questionPaper:
        return Icons.assignment;
    }
  }
}
