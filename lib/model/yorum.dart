import 'package:cloud_firestore/cloud_firestore.dart';

class Yorum {
  String id;
  String userID;
  String mekanID;
  String ad;
  String yorum;
  int begenmeSayisi;
  Timestamp date;

  Yorum(
      {this.userID,
      this.mekanID,
      this.ad,
      this.yorum,
      this.begenmeSayisi,
      this.date});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'mekanID': mekanID,
      'ad': ad,
      'yorum': yorum,
      'begenmeSayisi': begenmeSayisi ?? 0,
      'date': date ?? FieldValue.serverTimestamp(),
    };
  }

  Yorum.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        mekanID = map['mekanID'],
        ad = map['ad'],
        yorum = map['yorum'],
        begenmeSayisi = map['begenmeSayisi'],
        date = map['date'];

  @override
  String toString() {
    return 'Mesaj{userID: $userID, mekanID: $mekanID, ad: $ad, yorum: $yorum, begenmeSayisi: $begenmeSayisi, date: $date}';
  }
}
