//user data class to contain the data of a specific user for the app data on firebase

class UserData {
  final String? name;
  final int? points;
  final int? level;


  UserData({required this.name, required this.points, required this.level});
}