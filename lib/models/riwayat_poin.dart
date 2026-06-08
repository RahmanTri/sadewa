class RiwayatPoin {
  final String hari;
  final String tanggal;
  final String bulan;
  final String tahun;
  final int poinSebelumnya;
  final int poinDidapat;
  String sumber = '';
  String statusLog;

  RiwayatPoin({
    required this.hari,
    required this.tanggal,
    required this.bulan,
    required this.tahun,
    required this.poinSebelumnya,
    required this.poinDidapat,
    required this.statusLog,
    this.sumber = '',
  });

  factory RiwayatPoin.fromJson(Map<String, dynamic> json) => RiwayatPoin(
    hari: json['hari'],
    tanggal: json['tanggal'],
    bulan: json['bulan'],
    tahun: json['tahun'],
    poinSebelumnya: json['point_sebelumnya'],
    poinDidapat: json['point_didapat'],
    sumber: json['sumber'],
    statusLog: json['status'],
  );

  void translateStatus() {
    if (statusLog == 'absent') {
      statusLog = 'Tidak Hadir';
    } else if (statusLog == 'late') {
      statusLog = 'Terlambat';
    } else if (statusLog == 'on_time') {
      statusLog = 'Tepat Waktu';
    } else if (statusLog == 'early') {
      statusLog = 'Lebih Awal';
    } else {
      statusLog = 'Tidak Hadir';
    }
  }
}