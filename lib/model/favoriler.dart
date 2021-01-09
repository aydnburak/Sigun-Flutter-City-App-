

class Favoriler {
  final String userID;
  String mekanID;

  Favoriler({this.userID, this.mekanID});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'mekanID': mekanID,
    };
  }

  Favoriler.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        mekanID = map['mekanID'];

  @override
  String toString() {
    return 'Favoriler{userID: $userID, mekanID: $mekanID}';
  }
}
