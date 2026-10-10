import 'dart:io';
/// LATIHAN LIST DAN MAP: DAFTAR TUGAS HARIAN
///
/// Setiap tugas disimpan sebagai Map dengan kunci:
/// - 'judul' (String)
/// - 'prioritas' (String)
/// - 'selesai' (bool)
///
/// List menyimpan banyak Map tugas secara berurutan.
void main() {
  // final menjaga variabel daftarTugas tetap menunjuk ke List ini.
  // Isi List tetap boleh ditambah, diubah, dan dihapus.
  final List<Map<String, dynamic>> daftarTugas = [];
  bool jalan = true;

  // Menu diulang sampai pengguna memilih pilihan 5.
  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (1-5): ');

    // switch memilih fitur yang dijalankan berdasarkan input pengguna.
    switch (pilihan) {
      case 1:
        tambahTugas(daftarTugas);
        break;
      case 2:
        tampilTugas(daftarTugas);
        break;
      case 3:
        tugasSelesai(daftarTugas);
        break;
      case 4:
        hapusTugas(daftarTugas);
        break;
      case 5:
        jalan = false;
        print('Program selesai.');
        break;
      default:
        // Juga menangani input yang bukan angka karena pilihan akan null.
        print('Pilihan tidak valid. Masukkan angka 1 sampai 5.');
    }
  }
}

/// Menampilkan semua pilihan yang tersedia.
void tampilkanMenu() {
  print('\n=== DAFTAR TUGAS HARIAN ===');
  print('1. Tambah tugas');
  print('2. Lihat semua tugas');
  print('3. Tandai tugas selesai');
  print('4. Hapus tugas');
  print('5. Keluar');
}

/// Membaca angka dari terminal; mengembalikan null jika input bukan angka.
int? bacaAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync()?.trim() ?? '');
}

/// Meminta detail tugas dan menambahkan satu Map ke dalam List.
void tambahTugas(List<Map<String, dynamic>> daftarTugas) {
  stdout.write('Masukkan judul tugas: ');
  final String judul = (stdin.readLineSync() ?? '').trim();

  if (judul.isEmpty) {
    print('Judul tugas tidak boleh kosong.');
    return;
  }

  // Hindari tugas dengan judul sama, tanpa membedakan kapitalisasi.
  final bool sudahAda = daftarTugas.any(
    (tugas) => (tugas['judul'] as String).toLowerCase() == judul.toLowerCase(),
  );
  if (sudahAda) {
    print('Tugas dengan judul tersebut sudah ada.');
    return;
  }

  print('Pilih prioritas: 1. Rendah | 2. Sedang | 3. Tinggi');
  final int? pilihanPrioritas = bacaAngka('Prioritas (1-3): ');

  if (pilihanPrioritas == null || pilihanPrioritas < 1 || pilihanPrioritas > 3) {
    print('Prioritas tidak valid. Masukkan angka 1, 2, atau 3.');
    return;
  }

  // Simpan label prioritas sebagai teks agar mudah dibaca saat ditampilkan.
  final String prioritas = switch (pilihanPrioritas) {
    1 => 'Rendah',
    2 => 'Sedang',
    3 => 'Tinggi',
    _ => 'Rendah', // Tidak tercapai karena input sudah divalidasi.
  };

  // Satu Map menyimpan tiga informasi untuk satu tugas.
  daftarTugas.add({
    'judul': judul,
    'prioritas': prioritas,
    'selesai': false,
  });

  print('Tugas "$judul" berhasil ditambahkan.');
}

/// Menampilkan tugas dengan nomor urut yang dimulai dari 1.
void tampilTugas(List<Map<String, dynamic>> daftarTugas) {
  if (daftarTugas.isEmpty) {
    print('Belum ada tugas dalam daftar.');
    return;
  }

  print('\n--- DAFTAR TUGAS ---');
  for (int i = 0; i < daftarTugas.length; i++) {
    final Map<String, dynamic> tugas = daftarTugas[i];
    // Nilai bool pada Map diubah menjadi status yang mudah dibaca.
    final String status = tugas['selesai'] == true ? 'Selesai' : 'Belum selesai';

    // Indeks List dimulai dari 0, jadi nomor tampilan menggunakan i + 1.
    print(
      '${i + 1}. ${tugas['judul']} | '
      'Prioritas: ${tugas['prioritas']} | Status: $status',
    );
  }
}

/// Mengubah status tugas yang dipilih menjadi selesai.
void tugasSelesai(List<Map<String, dynamic>> daftarTugas) {
  if (daftarTugas.isEmpty) {
    print('Belum ada tugas yang bisa ditandai selesai.');
    return;
  }

  tampilTugas(daftarTugas);
  final int? nomor = bacaAngka('Nomor tugas yang sudah selesai: ');

  if (nomor == null || nomor < 1 || nomor > daftarTugas.length) {
    print('Nomor tidak valid. Pilih nomor yang ada pada daftar.');
    return;
  }

  // Kurangi 1 karena nomor untuk pengguna mulai dari 1, indeks List dari 0.
  final Map<String, dynamic> tugas = daftarTugas[nomor - 1];
  if (tugas['selesai'] == true) {
    print('Tugas "${tugas['judul']}" memang sudah berstatus selesai.');
    return;
  }

  tugas['selesai'] = true;
  print('Tugas "${tugas['judul']}" ditandai selesai.');
}

/// Menghapus tugas berdasarkan nomor yang ditampilkan.
void hapusTugas(List<Map<String, dynamic>> daftarTugas) {
  if (daftarTugas.isEmpty) {
    print('Belum ada tugas yang bisa dihapus.');
    return;
  }

  tampilTugas(daftarTugas);
  final int? nomor = bacaAngka('Nomor tugas yang ingin dihapus: ');

  if (nomor == null || nomor < 1 || nomor > daftarTugas.length) {
    print('Nomor tidak valid. Pilih nomor yang ada pada daftar.');
    return;
  }

  // removeAt menerima indeks mulai dari 0, maka nomor dikurangi 1.
  final Map<String, dynamic> tugasDihapus = daftarTugas.removeAt(nomor - 1);
  print('Tugas "${tugasDihapus['judul']}" berhasil dihapus.');
}
