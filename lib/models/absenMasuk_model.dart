class AbsenMasuk {
  final int id;
  String companyId;
  String namaLengkap;
  String divisi;
  DateTime rawDate;
  String stringDate;
  String status;

  AbsenMasuk({
    required this.id,
    required this.companyId,
    required this.namaLengkap,
    required this.divisi,
    required this.rawDate,
    required this.stringDate,
    required this.status,
  });

  factory AbsenMasuk.fromJson(Map<String, dynamic> json) {
    return AbsenMasuk(
      id: json['id'],
      companyId: json['kode_karyawan'],
      namaLengkap: json['nama_karyawan'],
      divisi: json['divisi'],
      rawDate: DateTime.parse(json['waktu_masuk']),
      stringDate: json['waktu_masuk'].toString(),
      status: json['status'] == 'late'
          ? json['status'] = 'Telat'
          : json['status'] == 'on_time'
          ? json['status'] = 'Tepat Waktu'
          : json['status'] = 'Tidak Hadir',
    );
  }
}
