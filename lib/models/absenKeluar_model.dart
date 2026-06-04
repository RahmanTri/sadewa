class AbsenKeluar {
  final int id;
  String companyId;
  String namaLengkap;
  String divisi;
  String waktuKeluar;
  String status;

  AbsenKeluar({
    required this.id,
    required this.companyId,
    required this.namaLengkap,
    required this.divisi,
    required this.waktuKeluar,
    required this.status,
  });

  factory AbsenKeluar.fromJson(Map<String, dynamic> json) {
    return AbsenKeluar(
      id: json['id'],
      companyId: json['kode_karyawan'],
      namaLengkap: json['nama_karyawan'],
      divisi: json['divisi'],
      waktuKeluar: json['waktu_keluar'].toString(),
      status: json['status'] == 'late'
          ? json['status'] = 'Telat'
          : json['status'] == 'on_time'
          ? json['status'] = 'Tepat Waktu'
          : json['status'] == 'early'
          ? json['status'] = 'Terlalu Dini'
          : json['status'] = 'Tidak Hadir',
    );
  }
}
