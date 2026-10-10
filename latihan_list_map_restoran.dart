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
        tambahPesanan(pesanan);
        break;
      case 2:
        // TODO 3: panggil tampilkanPesanan(pesanan)
        tampilkanPesanan(pesanan);
        break;
      case 3:
        // TODO 4: panggil ubahJumlah(pesanan)
        ubahJumlah(pesanan);
        break;
      case 4:
        // TODO 5: panggil hapusItem(pesanan)
        hapusPesanan(pesanan);
        break;
      case 5:
        // TODO 6: panggil tampilkanTotal(pesanan)
        tampilkanTotal(pesanan);
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
void tambahPesanan(List<Map<String, dynamic>> pesanan) {
  stdout.write('Nama Menu : ');
  final String nama = (stdin.readLineSync() ?? '').trim();

  if (nama.isEmpty) {
    print('Nama Tidak Boleh Kosong');
    return;
  }

  final int? jumlah = bacaAngka('Masukan Jumalh :');
  if (jumlah == null || jumlah <= 0) {
    print('Tidak Valid');
    return;
  }

    final int? hargaSatuan = bacaAngka('Masukan Harga :');
  if (hargaSatuan == null || hargaSatuan <= 0) {
    print('Tidak Valid');
    return;
  }

  pesanan.add({
    'menu': nama,
    'jumlah': jumlah,
    'hargaSatuan': hargaSatuan,
    'subtotal': hitungSubtotal(jumlah, hargaSatuan)
  });

  print('Pesanan "$nama" berhasil dipesan');
}

// TODO 8: Buat tampilkanPesanan(...).
// - Jika List kosong, tampilkan pesan.
// - Jika berisi item, gunakan for untuk menampilkan nomor, menu, jumlah,
//   harga satuan, dan subtotal dari setiap Map.
void tampilkanPesanan(List<Map<String, dynamic>> pesanan) {
  if (pesanan.isEmpty) {
    print('Belum ada Pesanan');
    return;
  }

  print('\n ---- Daftar Pesanan ----');
  for(int i = 0; i < pesanan.length; i++) {
    final Map<String,dynamic> daftar = pesanan[i];

    print(
      '${i + 1}. ${daftar['menu']} | '
      'Jumlah : ${daftar['jumlah']} | Harga Satuan : ${daftar['hargaSatuan']} | Subtotal: Rp ${formatRupiah(daftar['subtotal'] as int)}',
    );
  }
}

// TODO 9: Buat ubahJumlah(...).
// - Tampilkan daftar item dan minta nomor item serta jumlah baru.
// - Validasi nomor dan jumlah baru (harus lebih dari 0).
// - Perbarui 'jumlah' pada Map dan hitung ulang 'subtotal'.
void ubahJumlah (List<Map<String, dynamic>> pesanan) {
    if (pesanan.isEmpty) {
    print('Belum ada Pesanan');
    return;
  }

  tampilkanPesanan(pesanan);
  final int? nomorpesanan = bacaAngka('Pesanan yang mau diuabh jumlah : ');
    if (nomorpesanan == null || nomorpesanan < 1 || nomorpesanan > pesanan.length) {
    print('Nomor tidak valid. Pilih nomor yang ada di daftar');
    return;
  }

  final int? jumlahBaru = bacaAngka('Masukan Jumlah Baru : ');
 if (jumlahBaru == null || jumlahBaru <= 0) {
  print('Jumlah harus lebih dari 0.');
  return;
}
  final Map<String, dynamic> item = pesanan[nomorpesanan - 1];
item['jumlah'] = jumlahBaru;
item['subtotal'] = hitungSubtotal(
  jumlahBaru,
  item['hargaSatuan'] as int,
);
print('Jumlah ${item['menu']} berhasil diubah menjadi $jumlahBaru.');

}


// TODO 10: Buat hapusItem(...).
// - Minta nomor item, validasi, lalu hapus dengan removeAt(nomor - 1).
// - Ingat nomor daftar dimulai dari 1, sedangkan indeks List dari 0.
void hapusPesanan (List<Map<String, dynamic>> pesanan) {
  if (pesanan.isEmpty) {
    print('Belum Ada Pesanan.');
    return;
  }

  tampilkanPesanan(pesanan);
  final int? nomorpesanan = bacaAngka('Nomor pemesanan yang ingin di hapus : ');

  if (nomorpesanan == null || nomorpesanan < 1 || nomorpesanan > pesanan.length) {
    print('Nomor tidak valid. Pilih nomor yang ada di daftar');
    return;
  }

  final Map<String, dynamic> hapusPesanan = pesanan.removeAt(nomorpesanan - 1);
  print('Pesanan "${hapusPesanan['menu']}" berhasil dihapus.');
}



// TODO 11: Buat tampilkanTotal(...).
// - Jumlahkan subtotal semua item dengan perulangan.
// - Tampilkan total tagihan; jika List kosong, totalnya Rp 0.
void tampilkanTotal (List<Map<String, dynamic>> pesanan) {
  if (pesanan.isEmpty) {
    print('\n--- Total Tagihan ---');
    print('Total: Rp 0');
    return;
  }

  tampilkanPesanan(pesanan);
  print('\n--- Total Tagihan ---');
  int total = 0;
for (final Map<String, dynamic> item in pesanan) {
  total += item['subtotal'] as int;
}

print('Total: Rp ${formatRupiah(total)}');

}

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
