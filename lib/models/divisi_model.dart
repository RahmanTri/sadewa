class Divisi {
  final int id;
  String namaDivisi;
  String waktuMasuk;
  String waktuKeluar;
  int toleransiWaktu;
  double latitude;
  double longitude;
  int toleransiArea;
  String alamat;
  String kantor;


  Divisi({
    required this.id,
    required this.namaDivisi,
    this.waktuMasuk = '09:00',
    this.waktuKeluar = '17:00',
    this.toleransiWaktu = 15,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.toleransiArea = 0,
    this.alamat = '',
    this.kantor = 'Kantor Utama',
  });

  factory Divisi.fromJson(Map<String, dynamic> json) => Divisi(
    id: json['id_divisi'],
    namaDivisi: json['nama_divisi'],
    waktuMasuk: json['waktu_checkin'],
    waktuKeluar: json['waktu_checkout'],
    toleransiWaktu: json['toleransi_waktu'],
    latitude: json['latitude'] ?? 0.0,
    longitude: json['longitude'] ?? 0.0,
    toleransiArea: json['toleransi_radius'],
    // alamat: json['alamat'],
  );

}