class AbsenMasuk {
  final int id;
  String companyId;
  String namaLengkap;
  String divisi;
  String waktuMasuk;
  String status;

  AbsenMasuk({
    required this.id,
    required this.companyId,
    required this.namaLengkap,
    required this.divisi,
    required this.waktuMasuk,
    required this.status,
  });

  factory AbsenMasuk.fromJson(Map<String, dynamic> json) {
    return AbsenMasuk(
      id: json['id'],
      companyId: json['kode_karyawan'],
      namaLengkap: json['nama_karyawan'],
      divisi: json['divisi'],
      waktuMasuk: json['waktu_masuk'].toString(),
      status: json['status'] == 'late'
          ? json['status'] = 'Telat'
          : json['status'] == 'on_time'
          ? json['status'] = 'Tepat Waktu'
          : json['status'] = 'Tidak Hadir',
    );
  }
}
