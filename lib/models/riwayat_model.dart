class Riwayat {
  final String hari;
  final String tanggal;
  final String bulan;
  final String tahun;
  final String statusMasuk;
  final String waktuMasuk;
  final String statusKeluar;
  final String waktuKeluar;

  Riwayat({
    required this.hari,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
    required this.statusMasuk,
    required this.waktuMasuk,
    required this.statusKeluar,
    required this.waktuKeluar,
  });

  factory Riwayat.fromJson(Map<String, dynamic> json) {
    return Riwayat(
      hari: json['hari'],
      tanggal: json['tanggal'],
      bulan: json['bulan'],
      tahun: json['tahun'],
      statusMasuk: json['status_masuk'],
      waktuMasuk: json['waktu_masuk'],
      statusKeluar: json['status_keluar'],
      waktuKeluar: json['waktu_keluar'],
    );
  }
}