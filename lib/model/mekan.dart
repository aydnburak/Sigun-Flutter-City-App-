class Mekan {
  String id;
  String ad;
  String aciklama;
  String adres;
  String foto1;
  String foto2;
  String foto3;
  int begeniSayisi;
  String konum;
  String sehir;
  String tur;

  Mekan(this.begeniSayisi, this.konum, this.sehir, this.tur,
      {this.ad, this.aciklama, this.adres, this.foto1, this.foto2, this.foto3});

  Map<String, dynamic> toMap() {
    return {
      'ad': ad,
      'aciklama': aciklama,
      'adres': adres,
      'foto1': foto1,
      'foto2': foto2,
      'foto3': foto3,
      'begeniSayisi': begeniSayisi,
      'konum': konum,
      'sehir': sehir,
      'tur': tur,
    };
  }

  Mekan.fromMap(Map<String, dynamic> map)
      : ad = map['ad'],
        aciklama = map['aciklama'],
        adres = map['adres'],
        foto1 = map['foto1'],
        foto2 = map['foto2'],
        foto3 = map['foto3'],
        begeniSayisi = map['begeniSayisi'],
        konum = map['konum'],
        sehir = map['sehir'],
        tur = map['tur'];

  @override
  String toString() {
    return 'Mekan{ad: $ad, aciklama: $aciklama, adres: $adres, foto1: $foto1, foto2: $foto2, foto3: $foto3, begeniSayisi: $begeniSayisi, konum: $konum, sehir: $sehir, tur: $tur}';
  }
}
