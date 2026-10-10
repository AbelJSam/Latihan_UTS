import 'dart:io';

/// LATIHAN LIST DAN MAP: DAFTAR TUGAS HARIAN
///
/// Kasus: buat program sederhana untuk mengelola tugas.
/// Setiap tugas disimpan sebagai Map dengan kunci:
/// - 'judul' (String)
/// - 'prioritas' (String)
/// - 'selesai' (bool)
/// Semua tugas disimpan berurutan dalam sebuah List.
///
/// Petunjuk: selesaikan TODO dari atas ke bawah.
/// Jalankan dengan: dart latihan_list_map_tugas.dart
void main() {
  // TODO 1: Buat List<Map<String, dynamic>> bernama daftarTugas = [].
  // List ini menjadi tempat menyimpan semua Map tugas.

  bool jalan = true;

  // Selama jalan bernilai true, menu akan terus ditampilkan.
  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (1-5): ');

    // TODO 2: Lengkapi setiap case dengan memanggil fungsi yang sesuai.
    switch (pilihan) {
      case 1:
        // TODO: panggil tambahTugas(daftarTugas)
        break;
      case 2:
        // TODO: panggil tampilkanTugas(daftarTugas)
        break;
      case 3:
        // TODO: panggil tandaiTugasSelesai(daftarTugas)
        break;
      case 4:
        // TODO: panggil hapusTugas(daftarTugas)
        break;
      case 5:
        jalan = false;
        print('Program selesai.');
        break;
      default:
        print('Pilihan tidak valid. Masukkan angka 1 sampai 5.');
    }
  }
}

/// Menampilkan pilihan menu kepada pengguna.
void tampilkanMenu() {
  print('\n=== DAFTAR TUGAS HARIAN ===');
  print('1. Tambah tugas');
  print('2. Lihat semua tugas');
  print('3. Tandai tugas selesai');
  print('4. Hapus tugas');
  print('5. Keluar');
}

/// Membaca angka dari terminal; hasilnya null jika input bukan angka.
int? bacaAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync()?.trim() ?? '');
}

// TODO 3: Buat fungsi tambahTugas(List<Map<String, dynamic>> daftarTugas).
// - Minta judul tugas dan pastikan tidak kosong.
// - Minta prioritas: rendah, sedang, atau tinggi.
// - Tambahkan Map ke List, contohnya:
//   {'judul': judul, 'prioritas': prioritas, 'selesai': false}
// - Gunakan daftarTugas.add(...).

// TODO 4: Buat fungsi tampilkanTugas(...).
// - Jika List kosong, tampilkan pesan bahwa belum ada tugas.
// - Jika ada tugas, gunakan for untuk membaca tiap Map.
// - Tampilkan nomor (indeks + 1), judul, prioritas, dan status.
// - Status bisa dibuat dari nilai bool:
//   tugas['selesai'] == true ? 'Selesai' : 'Belum selesai'

// TODO 5: Buat fungsi tandaiTugasSelesai(...).
// - Tampilkan daftar tugas terlebih dahulu.
// - Minta nomor tugas yang ingin ditandai selesai.
// - Validasi nomor agar berada antara 1 dan daftarTugas.length.
// - Ubah nilai pada Map yang dipilih:
//   daftarTugas[nomor - 1]['selesai'] = true;

// TODO 6: Buat fungsi hapusTugas(...).
// - Tampilkan daftar tugas terlebih dahulu.
// - Minta nomor tugas yang akan dihapus dan validasi nomornya.
// - Hapus tugas memakai daftarTugas.removeAt(nomor - 1).
// - Jelaskan pada komentar mengapa nomor dikurangi 1.
