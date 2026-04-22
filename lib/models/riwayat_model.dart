class Riwayat {
  final String hari;
  final String tanggal;
  final String bulan;
  final String tahun;
  String statusMasuk;
  final String waktuMasuk;
  String statusKeluar;
  final String waktuKeluar;
  bool translated = false;

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

  void transStatusIn() {
    if (statusMasuk == 'on_time') {
      statusMasuk = 'Tepat Waktu';
    } else if (statusMasuk == 'late') {
      statusMasuk = 'Terlambat';
    } else {
      statusMasuk = 'Tidak Hadir';
    }
  }

  void transStatusOut() {
    if (statusKeluar == 'on_time') {
      statusKeluar = 'Tepat Waktu';
    } else if (statusKeluar == 'late') {
      statusKeluar = 'Terlambat';
    } else if (statusKeluar == 'early') {
      statusKeluar = 'Lebih Awal';
    } else {
      statusKeluar = 'Tidak Hadir';
    }
  }

  void translateStatuses() {
    transStatusIn();
    transStatusOut();
    translated = true;
  }

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
