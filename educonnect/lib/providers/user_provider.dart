import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updatePoints(int points) {
    if (_user != null) {
      _user = User(
        id: _user!.id,
        username: _user!.username,
        email: _user!.email,
        points: _user!.points + points,
        badges: _user!.badges,
        completedLessons: _user!.completedLessons,
        role: _user!.role
      );
      notifyListeners();
    }
  }

  void addBadge(String badge) {
    if (_user != null && !_user!.badges.contains(badge)) {
      _user = User(
        id: _user!.id,
        username: _user!.username,
        email: _user!.email,
        points: _user!.points,
        badges: [..._user!.badges, badge],
        completedLessons: _user!.completedLessons,
        role: _user!.role
      );
      notifyListeners();
    }
  }
}