//class to contain the details of a user for firebase including the uid of the account

class MyUser {
  final String uid;

  MyUser({required this.uid});
}

class Userdetails {
  final String? uid;
  final String name;
  final int level;
  final int xp;
  final int points;
  final String url;
  final int picnum;
  final petlist = List<bool>.filled(5, false);

  Userdetails({
    required this.uid,
    required this.name,
    required this.level,
    required this.xp,
    required this.points,
    required this.url,
    required this.picnum,
  });
}
