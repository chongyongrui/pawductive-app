//user data class to contain the data of a specific user for the app data on firebase

class UserData {
  final String? name;
  final int? points;
  final int? level;
  final String? url;
  final int? picnum;


  UserData({required this.name, required this.points, required this.level, required this.url, required this.picnum});
}