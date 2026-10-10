import 'dart:io';

/// LATIHAN LIST DAN MAP: PESANAN RESTORAN
///
/// Satu item pesanan adalah Map dengan kunci:
/// 'menu' (String), 'jumlah' (int), 'hargaSatuan' (int), dan 'subtotal' (int).
/// List menyimpan semua item pesanan pelanggan.
///
/// Selesaikan TODO dan gunakan fungsi hitungSubtotal untuk menghitung harga.
void main() {
  // TODO 1: Buat List<Map<String, dynamic>> bernama pesanan = [].
  final List<Map<String, dynamic>> pesanan = [];
  bool jalan = true;

  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (1-6): ');

    switch (pilihan) {
      case 1:
        // TODO 2: panggil tambahPesanan(pesanan)
        break;
      case 2:
        // TODO 3: panggil tampilkanPesanan(pesanan)
        break;
      case 3:
        // TODO 4: panggil ubahJumlah(pesanan)
        break;
      case 4:
        // TODO 5: panggil hapusItem(pesanan)
        break;
      case 5:
        // TODO 6: panggil tampilkanTotal(pesanan)
        break;
      case 6:
        jalan = false;
        print('Program selesai.');
        break;
      default:
        print('Pilihan tidak valid. Masukkan angka 1 sampai 6.');
    }
  }
}

void tampilkanMenu() {
  print('\n=== PESANAN RESTORAN ===');
  print('1. Tambah item pesanan');
  print('2. Lihat pesanan');
  print('3. Ubah jumlah item');
  print('4. Hapus item');
  print('5. Lihat total tagihan');
  print('6. Keluar');
}

/// Mengembalikan null jika input bukan angka bulat.
int? bacaAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync()?.trim() ?? '');
}

/// Menghitung harga satu item berdasarkan jumlah dan harga satuan.
int hitungSubtotal(int jumlah, int hargaSatuan) => jumlah * hargaSatuan;

// TODO 7: Buat tambahPesanan(List<Map<String, dynamic>> pesanan).
// - Minta nama menu, jumlah, dan harga satuan.
// - Pastikan nama tidak kosong dan angka lebih dari 0.
// - Hitung subtotal dengan hitungSubtotal(jumlah, hargaSatuan).
// - Tambahkan Map seperti:
//   {'menu': namaMenu, 'jumlah': jumlah, 'hargaSatuan': hargaSatuan,
//    'subtotal': subtotal}
// - Gunakan pesanan.add(...).

// TODO 8: Buat tampilkanPesanan(...).
// - Jika List kosong, tampilkan pesan.
// - Jika berisi item, gunakan for untuk menampilkan nomor, menu, jumlah,
//   harga satuan, dan subtotal dari setiap Map.

// TODO 9: Buat ubahJumlah(...).
// - Tampilkan daftar item dan minta nomor item serta jumlah baru.
// - Validasi nomor dan jumlah baru (harus lebih dari 0).
// - Perbarui 'jumlah' pada Map dan hitung ulang 'subtotal'.

// TODO 10: Buat hapusItem(...).
// - Minta nomor item, validasi, lalu hapus dengan removeAt(nomor - 1).
// - Ingat nomor daftar dimulai dari 1, sedangkan indeks List dari 0.

// TODO 11: Buat tampilkanTotal(...).
// - Jumlahkan subtotal semua item dengan perulangan.
// - Tampilkan total tagihan; jika List kosong, totalnya Rp 0.
