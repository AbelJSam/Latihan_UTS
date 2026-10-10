import 'dart:io';

/// LATIHAN LIST DAN MAP: PEMESANAN TIKET BIOSKOP
///
/// Satu pemesanan adalah Map dengan kunci:
/// 'film' (String), 'studio' (int), 'jumlahTiket' (int), dan 'totalHarga' (int).
/// List menyimpan semua pemesanan tiket.
///
/// Selesaikan TODO. Gunakan harga tiket tetap Rp 50.000 per tiket.
void main() {
  // TODO 1: Buat List<Map<String, dynamic>> bernama pemesanan = [].
  final List<Map<String, dynamic>> pemesanan = [];
  bool jalan = true;

  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (1-5): ');

    switch (pilihan) {
      case 1:
        // TODO 2: panggil pesanTiket(pemesanan)
        pesanTiket(pemesanan);
        break;
      case 2:
        // TODO 3: panggil tampilkanPemesanan(pemesanan)
        tampilkanPesanan(pemesanan);
        break;
      case 3:
        // TODO 4: panggil batalkanPemesanan(pemesanan)
        batalkanPemesanan(pemesanan);
        break;
      case 4:
        // TODO 5: panggil tampilkanTotalTiket(pemesanan)
        tampilkanTotalTiket(pemesanan);
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

void tampilkanMenu() {
  print('\n=== BIOSKOP LAYAR CERIA ===');
  print('1. Pesan tiket');
  print('2. Lihat semua pemesanan');
  print('3. Batalkan pemesanan');
  print('4. Lihat jumlah tiket terjual');
  print('5. Keluar');
}

/// Mengembalikan null jika input bukan angka bulat.
int? bacaAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync()?.trim() ?? '');
}

// TODO 6: Buat pesanTiket(List<Map<String, dynamic>> pemesanan).
// - Minta nama film, nomor studio, dan jumlah tiket.
// - Pastikan nama film tidak kosong dan angka lebih dari 0.
// - Hitung total harga = jumlah tiket * 50000.
// - Tambahkan Map seperti:
//   {'film': film, 'studio': studio, 'jumlahTiket': jumlah,
//    'totalHarga': totalHarga}
// - Gunakan pemesanan.add(...).
void pesanTiket(List<Map<String, dynamic>> pemesanan) {
  int hargaTiket = 50000;
  
  stdout.write('Nama Film : ');
  final String nama = (stdin.readLineSync() ?? '').trim();

  if (nama.isEmpty) {
    print('Nama film tidak boleh kosong');
    return;
  }

  print('Pilih nomor studio : 1. XXI | 2. IMAX | 3. ABCD ');
  final int? pilihan = bacaAngka('Pilihan (1-3) :');

  if (pilihan == null || pilihan < 1 || pilihan > 3) {
    print("Pilhan tidak valid. masukan angka 1, 2, dan 3");
    return;
  }

  final String studio = switch (pilihan) {
    1 => 'XXI',
    2 => 'IMAX',
    3 => 'ABCD',
    _ => 'XXI',
  };

  final int? jumlahTiket = bacaAngka('Masukan Jumlah Tiket :');

  if (jumlahTiket == null || jumlahTiket < 1) {
    print('Jumlah Tiket tidak boleh kosong');
    return;
  }

  pemesanan.add({
    'judulFilm': nama,
    'studio': studio,
    'jumlahTiket': jumlahTiket,
    'harga': jumlahTiket * hargaTiket
  });
  print('Nama Film "$nama" berhasil dipesan');

}

// TODO 7: Buat tampilkanPemesanan(...).
// - Tangani List kosong dengan pesan yang sesuai.
// - Gunakan perulangan for untuk menampilkan setiap Map.
// - Tampilkan nomor (i + 1), film, studio, jumlah tiket, dan total harga.
// - Perhatikan: indeks List mulai dari 0, nomor tampilan mulai dari 1.
void tampilkanPesanan(List<Map<String, dynamic>> pemesanan) {
  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan tiket');
    return;
  }

  print('\n ---- Daftar Pemesanan ----');
  for(int i = 0; i < pemesanan.length; i++) {
    final Map<String, dynamic> pesanan = pemesanan[i];

    print(
      '${i + 1}. ${pesanan['judulFilm']} | '
      'Studio : ${pesanan['studio']} | Jumlah Tiket : ${pesanan['jumlahTiket']} | Total Harga : ${pesanan['harga']}',
    );
  }
}

// TODO 8: Buat batalkanPemesanan(...).
// - Tampilkan pemesanan, minta nomor yang akan dibatalkan, lalu validasi.
// - Hapus dengan pemesanan.removeAt(nomor - 1).
// - Tampilkan nama film dari Map yang berhasil dihapus.
void batalkanPemesanan (List<Map<String, dynamic>> pemesanan) {
  if (pemesanan.isEmpty) {
    print('Belum Ada Pemesanan.');
    return;
  }

  tampilkanPesanan(pemesanan);
  final int? nomorpesanan = bacaAngka('Nomor pemesanan yang ingin di hapus : ');

  if (nomorpesanan == null || nomorpesanan < 1 || nomorpesanan > pemesanan.length) {
    print('Nomor tidak valid. Pilih nomor yang ada di daftar');
    return;
  }

  final Map<String, dynamic> hapusPesanan = pemesanan.removeAt(nomorpesanan - 1);
  print('Pesanan "${hapusPesanan['judulFilm']}" berhasil dibatalkan');
}

// TODO 9: Buat tampilkanTotalTiket(...).
// - Jumlahkan nilai 'jumlahTiket' dari semua Map di List.
// - Tampilkan total tiket. Jika List kosong, totalnya 0.
void tampilkanTotalTiket (List<Map<String, dynamic>> pemesanan) {
  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan tiket');
    return;
  }

  int total = 0;
  for(final tiket in pemesanan) {
    total += tiket['jumlahTiket'] as int;
  }

  print('\n Total tiket yang terjual : $total');

}
