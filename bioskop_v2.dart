import 'dart:io';

/// Daftar judul film dan harga tiket per lembar.
/// Map cocok untuk mencari harga berdasarkan judul film.
const Map<String, int> daftarFilm = {
  'Avengers': 40000,
  'Frozen': 35000,
  'Interstellar': 45000,
};

void main() {
  // Setiap Map adalah satu transaksi; List menyimpan banyak transaksi.
  final List<Map<String, dynamic>> pemesanan = [];
  bool jalan = true;

  // Menu berulang sampai pengguna memilih keluar.
  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (1-6): ');

    // switch menghubungkan angka menu dengan fitur program.
    switch (pilihan) {
      case 1:
        tambahPemesanan(pemesanan);
        break;
      case 2:
        tampilkanPemesanan(pemesanan);
        break;
      case 3:
        ubahPembayaran(pemesanan);
        break;
      case 4:
        batalkanPemesanan(pemesanan);
        break;
      case 5:
        tampilkanRingkasan(pemesanan);
        break;
      case 6:
        jalan = false;
        print('Terima kasih telah menggunakan sistem bioskop.');
        break;
      default:
        print('Pilihan tidak valid. Masukkan angka 1 sampai 6.');
    }
  }
}

/// Menampilkan daftar fitur.
void tampilkanMenu() {
  print('\n===== SISTEM BIOSKOP =====');
  print('1. Pesan tiket');
  print('2. Tampilkan pemesanan');
  print('3. Ubah status pembayaran');
  print('4. Batalkan pemesanan');
  print('5. Lihat ringkasan pemesanan');
  print('6. Keluar');
}

/// Membaca teks dari terminal.
String bacaTeks(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync()?.trim() ?? '';
}

/// Membaca angka bulat; hasil null menandakan input bukan angka.
int? bacaAngka(String pesan) {
  return int.tryParse(bacaTeks(pesan));
}

/// Menampilkan film dan membuat Map pemesanan baru di dalam List.
void tambahPemesanan(List<Map<String, dynamic>> pemesanan) {
  print('\n===== PESAN TIKET =====');

  final String nama = bacaTeks('Nama pelanggan: ');
  if (nama.isEmpty) {
    print('Nama pelanggan tidak boleh kosong.');
    return;
  }

  print('\nDaftar film:');
  for (final MapEntry<String, int> film in daftarFilm.entries) {
    print('- ${film.key}: Rp ${formatRupiah(film.value)} per tiket');
  }

  final String judulInput = bacaTeks('Masukkan judul film: ');
  if (judulInput.isEmpty) {
    print('Judul film tidak boleh kosong.');
    return;
  }

  // Cari judul tanpa membedakan huruf besar dan kecil.
  String? judulFilm;
  int? hargaSatuan;
  for (final MapEntry<String, int> film in daftarFilm.entries) {
    if (film.key.toLowerCase() == judulInput.toLowerCase()) {
      judulFilm = film.key;
      hargaSatuan = film.value;
      break;
    }
  }

  if (judulFilm == null || hargaSatuan == null) {
    print('Film tidak tersedia. Periksa judul pada daftar film.');
    return;
  }

  final int? jumlah = bacaAngka('Jumlah tiket: ');
  if (jumlah == null || jumlah <= 0) {
    print('Jumlah tiket harus berupa angka lebih dari 0.');
    return;
  }

  final int total = hargaSatuan * jumlah;

  // Satu Map berisi semua informasi untuk satu transaksi.
  pemesanan.add({
    'nama': nama,
    'film': judulFilm,
    'jumlah': jumlah,
    'hargaSatuan': hargaSatuan,
    'total': total,
    'status': 'Belum dibayar',
  });

  print('Pemesanan berhasil. Total pembayaran: Rp ${formatRupiah(total)}');
}

/// Membaca setiap Map dalam List dan menampilkan rincian transaksi.
void tampilkanPemesanan(List<Map<String, dynamic>> pemesanan) {
  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan.');
    return;
  }

  print('\n===== DAFTAR PEMESANAN =====');
  for (int i = 0; i < pemesanan.length; i++) {
    final Map<String, dynamic> transaksi = pemesanan[i];
    print(
      '${i + 1}. ${transaksi['nama']} | ${transaksi['film']} | '
      '${transaksi['jumlah']} tiket | Total: Rp ${formatRupiah(transaksi['total'] as int)} | '
      'Status: ${transaksi['status']}',
    );
  }
}

/// Mengubah status pembayaran pada Map transaksi yang dipilih.
void ubahPembayaran(List<Map<String, dynamic>> pemesanan) {
  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan yang bisa diperbarui.');
    return;
  }

  tampilkanPemesanan(pemesanan);
  final int? nomor = bacaAngka('Nomor pemesanan yang sudah dibayar: ');
  if (nomor == null || nomor < 1 || nomor > pemesanan.length) {
    print('Nomor pemesanan tidak valid.');
    return;
  }

  final Map<String, dynamic> transaksi = pemesanan[nomor - 1];
  if (transaksi['status'] == 'Sudah dibayar') {
    print('Pemesanan tersebut sudah dibayar.');
    return;
  }

  transaksi['status'] = 'Sudah dibayar';
  print('Status pembayaran berhasil diperbarui.');
}

/// Menghapus transaksi terpilih dari List.
void batalkanPemesanan(List<Map<String, dynamic>> pemesanan) {
  if (pemesanan.isEmpty) {
    print('Belum ada pemesanan yang bisa dibatalkan.');
    return;
  }

  tampilkanPemesanan(pemesanan);
  final int? nomor = bacaAngka('Nomor pemesanan yang dibatalkan: ');
  if (nomor == null || nomor < 1 || nomor > pemesanan.length) {
    print('Nomor pemesanan tidak valid.');
    return;
  }

  // Nomor tampilan mulai dari 1, sedangkan indeks List mulai dari 0.
  final Map<String, dynamic> transaksi = pemesanan.removeAt(nomor - 1);
  print('Pemesanan ${transaksi['film']} atas nama ${transaksi['nama']} dibatalkan.');
}

/// Menghitung jumlah transaksi dan jumlah tiket dari seluruh Map dalam List.
void tampilkanRingkasan(List<Map<String, dynamic>> pemesanan) {
  int totalTiket = 0;
  for (final Map<String, dynamic> transaksi in pemesanan) {
    totalTiket += transaksi['jumlah'] as int;
  }

  print('\n===== RINGKASAN =====');
  print('Jumlah transaksi: ${pemesanan.length}');
  print('Jumlah seluruh tiket: $totalTiket');
}

/// Menambahkan titik pemisah ribuan, misalnya 80000 menjadi 80.000.
String formatRupiah(int angka) {
  final String digit = angka.toString();
  final StringBuffer hasil = StringBuffer();

  for (int i = 0; i < digit.length; i++) {
    if (i > 0 && (digit.length - i) % 3 == 0) {
      hasil.write('.');
    }
    hasil.write(digit[i]);
  }

  return hasil.toString();
}
