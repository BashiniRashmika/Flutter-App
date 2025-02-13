import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 30, 38, 120),
                  Color.fromARGB(255, 83, 92, 146)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final user = userProvider.user;
                if (user == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor:
                                    const Color.fromARGB(255, 108, 166, 217),
                                child: const Icon(Icons.person,
                                    size: 60, color: Colors.white),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                user.username,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                user.email,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoCard('Statistics', [
                        _buildStat(
                            Icons.star, 'Total Points', user.points.toString()),
                        _buildStat(Icons.book, 'Completed Lessons',
                            user.completedLessons.length.toString()),
                      ]),
                      _buildInfoCard('Badges', [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: user.badges.map((badge) {
                            return Chip(
                              label: Text(badge),
                              backgroundColor:
                                  const Color.fromARGB(255, 226, 219, 219),
                            );
                          }).toList(),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 176, 86, 26),
                          foregroundColor:
                              Colors.white, // Text color changed to white
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 110, 188, 252)),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 164, 131, 131)),
          ),
        ],
      ),
    );
  }
}
