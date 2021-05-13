class Pelanggan {
  String id;
  String nama;
  String alamat;
  String kodePrduk;
  String photo;

  Pelanggan({
    this.id,
    this.nama,
    this.alamat,
    this.kodePrduk,
    this.photo,
  });

  factory Pelanggan.fromMap(Map<String, dynamic> map) => Pelanggan(
        id: map['id'],
        nama: map['nama'],
        alamat: map['alamat'],
        kodePrduk: map['kodeProduk'],
        photo: map['photo'],
      );

  Map<String, dynamic> toMap() => {
        'id': this.id,
        'nama': this.nama,
        'alamat': this.alamat,
        'kodeProduk': this.kodePrduk,
        'photo': this.photo,
      };
}