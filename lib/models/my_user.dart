class myUser {
  final String? uid;

  myUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
