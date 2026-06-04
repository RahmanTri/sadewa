import 'package:get/get.dart';

class HelpCenterController extends GetxController {
  
  final List<Map<String, String>> allFaqData = const [
    {
      'category': 'Absensi',
      'q': 'Bagaimana cara melakukan presensi',
      'a': 'Di halaman Beranda, klik tombol belum absen di bagian atas atau icon wajah di menu utama Pastikan wajah Anda terlihat jelas pada kamera dan berada di area dengan pencahayaan yang cukup.'
    },
    {
      'category': 'Absensi',
      'q': 'Mengapa muncul pesan "tidak mendeteksi wajah"?',
      'a': 'Pastikan kamera tidak buram. Posisikan wajah tegak lurus di tengah frame kamera, bersihkan lensa kamera depan, dan hindari ruangan yang terlalu gelap.'
    },
    {
      'category': 'Absensi',
      'q': 'Mengapa muncul peringatan "Lokasi Anda Tidak Sesuai"?',
      'a': 'Sistem mendeteksi posisi Anda berada di luar radius kantor. Pastikan GPS HP Anda aktif dengan akurasi tinggi dan Anda telah memberikan izin lokasi untuk Sadewa App.'
    },
    {
      'category': 'Absensi',
      'q': 'Bagaimana cara melihat total keterlambatan dalam satu bulan?',
      'a': 'Sistem mendeteksi posisi Anda berada di luar radius kantor. Pastikan GPS HP Anda aktif dengan akurasi tinggi dan Anda telah memberikan izin lokasi untuk Sadewa App.'
    },
    {
      'category': 'Poin & Bonus',
      'q': 'Apa yang dimaksud dengan "Poin Saya" di halaman Beranda?',
      'a': 'Setiap kehadiran yang tercatat "Hadir | Tepat Waktu" akan otomatis menambahkan +2 Poin. Jagalah performa kedisiplinan Anda agar nilai poin tetap tinggi.'
    },
    {
      'category': 'Poin & Bonus',
      'q': 'Apa pengaruh nilai "Poin Saya" terhadap Benefit bulanan?',
      'a': 'Nilai poin memengaruhi pemenuhan syarat pencairan bonus. Pada halaman Poin Saya, Anda bisa melihat status klaim seperti Bonus Bulanan, Bonus Mingguan, dan Bonus Uang Lembur. Jika poin Anda tinggi, indikator benefit akan tercentang hijau aktif.'
    },
    {
      'category': 'Poin & Bonus',
      'q': 'Apa fungsi dari indikator Benefit di menu Poin Saya?',
      'a': 'Indikator tersebut menampilkan bonus yang berhak Anda dapatkan. Poin di atas batas minimal akan mengaktifkan centang hijau pada Bonus Bulanan, Mingguan, atau Uang Lembur.'
    },
    {
      'category': 'Poin & Bonus',
      'q': 'Mengapa indikator Benefit Bonus Bulanan saya tercentang hijau?',
      'a': 'Selamat! Centang hijau berarti poin kedisiplinan Anda saat ini (misalnya di atas 80 Poin) sudah mencukupi syarat minimal untuk mencairkan Bonus Rp200.000 di akhir bulan nanti.'
    },
    {
      'category': 'Poin & Bonus',
      'q': 'Apa yang terjadi jika Poin Saya terus menurun?',
      'a': 'Jika poin turun drastis, klaim benefit lain seperti Bonus Mingguan dan Bonus Uang Lembur akan otomatis terkunci atau dinonaktifkan sementara oleh sistem.'
    },
    {
      'category': 'Poin & Bonus',
      'q': 'Apa itu peringkat kar',
      'a': 'Peringatan ini otomatis muncul jika akumulasi poin kedisiplinan Anda turun di bawah batas minimum akibat sering terlambat atau tidak masuk kerja.'
    },
    {
      'category': 'Peringatan',
      'q': 'Mengapa saya mendapatkan "Peringatan Poin Rendah"?',
      'a': 'Peringatan ini otomatis muncul jika akumulasi poin kedisiplinan Anda turun di bawah batas minimum akibat sering terlambat atau tidak masuk kerja.'
    },
    {
      'category': 'Peringatan',
      'q': 'Apa dampak jika saya mengabaikan surat peringatan tersebut?',
      'a': 'Sesuai kebijakan, poin yang terlalu rendah dapat menangguhkan bonus mingguan/bulanan serta benefit uang lembur Anda hingga tingkat kedisiplinan Anda membaik kembali.'
    },
    {
      'category': 'Akun & Keamanan',
      'q': 'Bagaimana jika saya lupa kata sandi akun?',
      'a': 'Pada halaman Login, klik tombol "Lupa Password?" di pojok kiri bawah, masukkan email terdaftar, dan ikuti instruksi verifikasi 4 digit kode OTP untuk mereset kata sandi Anda.'
    },
    {
      'category': 'Akun & Keamanan',
      'q': 'Bagaimana jika saya lupa kata sandi akun?',
      'a': 'Pada halaman Login dan Change Password, klik tombol "Lupa Password?" di pojok kiri bawah, masukkan email yang terdaftar, dan ikuti instruksi verifikasi 4 digit kode OTP untuk mereset kata sandi Anda.'
    },
    {
      'category': 'Akun & Keamanan',
      'q': 'Mengapa kode OTP tidak terkirim di email?',
      'a': 'Pastikan email yang Anda masukkan sudah benar dan terdaftar. Periksa juga folder Spam atau Promosi di email Anda jika kode tidak muncul di kotak masuk utama dalam 2 menit.'
    },
    {
      'category': 'Akun & Keamanan',
      'q': 'Berapa lama masa berlaku kode OTP yang dikirimkan?',
      'a': 'Kode OTP hanya berlaku selama 2 menit demi keamanan akun Anda. Jika waktu habis, Anda dapat menekan tombol Resend untuk mengirim ulang kode baru.'
    },
    {
      'category': 'Akun & Keamanan',
      'q': 'Apa fungsi dari fitur "Ingat Saya" di halaman Login?',
      'a': 'Fitur ini berfungsi untuk menyimpan sesi masuk Anda, sehingga Anda tidak perlu mengetik ulang email dan kata sandi setiap kali membuka aplikasi.'
    },
    {
      'category': 'Pengaturan Profil',
      'q': 'Mengapa tidak bisa mengubah kolom "Division" saat edit profil?',
      'a': 'Kolom Divisi dikunci secara otomatis demi keamanan data internal. Perubahan divisi hanya bisa dilakukan secara resmi melalui sistem oleh pihak Admin atau HRD perusahaan.'
    },
    {
      'category': 'Pengaturan Profil',
      'q': 'Bagaimana cara mengubah dan menghapus foto profil?',
      'a': 'Pada menu Ubah Profil, klik icon kamera pada foto profil. Pilih foto baru dari galeri atau ambil foto langsung dan klik icon tempat sampah untuk menghapus foto profil.'
    },
  ];

  // Kategori FAQ
  final List<String> categories = ['Semua', 'Absensi', 'Poin & Bonus', 'Peringatan', 'Akun & Keamanan', 'Pengaturan Profil'];

  var selectedCategory = 'Semua'.obs;
  var searchQuery = ''.obs;

  List<Map<String, String>> get filteredFaq {
    return allFaqData.where((faq) {
      // Filter berdasarkan kategori
      bool matchCategory = selectedCategory.value == 'Semua' || faq['category'] == selectedCategory.value;

      // Filter berdasarkan kata kunci
      bool matchQuery = faq['q']!.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
                        faq['a']!.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      return matchCategory && matchQuery;
    }).toList();
  }
}
