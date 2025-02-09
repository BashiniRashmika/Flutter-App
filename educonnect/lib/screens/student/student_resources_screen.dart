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
          title: const Text('Learning Resources'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Articles'),
              Tab(text: 'Videos'),
              Tab(text: 'Tips'),
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
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(resource.title),
            subtitle: Text(resource.description),
            trailing: Icon(_getIconForType(resource.type)),
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