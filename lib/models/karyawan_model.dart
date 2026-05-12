class Karyawan {
  final int idKaryawan;
  final int idUser;
  final String idPerusahaan;
  String namaLengkap;
  String email;
  String noTlp;
  int idDivisi;
  String namaDivisi;
  String fotoProfil;
  String dataWajah;

  Karyawan({
    required this.idKaryawan,
    required this.idUser,
    required this.idPerusahaan,
    required this.namaLengkap,
    required this.email,
    required this.noTlp,
    required this.idDivisi,
    required this.namaDivisi,
    required this.dataWajah,
    this.fotoProfil = '',
  });

  factory Karyawan.fromJson(Map<String, dynamic> json) {
    return Karyawan(
      idKaryawan: json['id_karyawan'],
      idUser: json['id_user'],
      idPerusahaan: json['id_perusahaan'],
      namaLengkap: json['nama_lengkap'],
      email: json['email'],
      noTlp: json['no_tlp'],
      idDivisi: json['id_divisi'],
      namaDivisi: json['nama_divisi'],
      fotoProfil: json['foto_profil'] == null || json['foto_profil'] == 'null' || json['foto_profil'] == '' ? '' : json['foto_profil'],
      dataWajah: json['data_wajah'],
    );
  }
}