import 'dart:io';

/// Tarif layanan dalam rupiah per kilogram.
/// Map memudahkan pencarian harga berdasarkan nama layanan.
const Map<String, int> tarifLayanan = {
  'Reguler': 7000,
  'Express': 12000,
};

void main() {
  // Setiap pesanan adalah Map; List menyimpan semua pesanan.
  final List<Map<String, dynamic>> pesanan = [];
  int idBerikutnya = 1;
  bool jalan = true;

  // Menu terus ditampilkan sampai pengguna memilih keluar.
  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (0-5): ');

    switch (pilihan) {
      case 1:
        // Fungsi mengembalikan ID berikutnya agar ID pesanan tetap unik.
        idBerikutnya = tambahPesanan(pesanan, idBerikutnya);
        break;
      case 2:
        lihatPesanan(pesanan);
        break;
      case 3:
        ubahStatus(pesanan);
        break;
      case 4:
        pembayaran(pesanan);
        break;
      case 5:
        hapusPesanan(pesanan);
        break;
      case 0:
        jalan = false;
        print('Terima kasih telah menggunakan layanan laundry.');
        break;
      default:
        print('Pilihan tidak valid. Masukkan angka 0 sampai 5.');
    }
  }
}

/// Menampilkan menu utama.
void tampilkanMenu() {
  print('\n=== SISTEM LAUNDRY ===');
  print('1. Tambah pesanan');
  print('2. Lihat pesanan');
  print('3. Ubah status');
  print('4. Pembayaran');
  print('5. Hapus pesanan');
  print('0. Keluar');
}

/// Membaca teks dan membuang spasi di awal/akhir.
String bacaTeks(String pesan) {
  stdout.write(pesan);
  return stdin.readLineSync()?.trim() ?? '';
}

/// Membaca angka bulat; null berarti input bukan angka.
int? bacaAngka(String pesan) => int.tryParse(bacaTeks(pesan));

/// Membuat pesanan baru dan mengembalikan ID yang akan dipakai berikutnya.
int tambahPesanan(List<Map<String, dynamic>> pesanan, int idBerikutnya) {
  print('\n--- TAMBAH PESANAN ---');
  final String nama = bacaTeks('Nama pelanggan: ');
  if (nama.isEmpty) {
    print('Nama pelanggan tidak boleh kosong.');
    return idBerikutnya;
  }

  final double? berat = double.tryParse(bacaTeks('Berat pakaian (kg): '));
  if (berat == null || !berat.isFinite || berat <= 0) {
    print('Berat harus berupa angka lebih dari 0.');
    return idBerikutnya;
  }

  print('Pilih layanan:');
  print('1. Reguler - Rp ${formatRupiah(tarifLayanan['Reguler']!)} per kg');
  print('2. Express - Rp ${formatRupiah(tarifLayanan['Express']!)} per kg');
  final int? pilihanLayanan = bacaAngka('Pilihan layanan (1/2): ');

  String? layanan;
  if (pilihanLayanan == 1) {
    layanan = 'Reguler';
  } else if (pilihanLayanan == 2) {
    layanan = 'Express';
  } else {
    print('Pilihan layanan tidak valid.');
    return idBerikutnya;
  }

  final int hargaPerKg = tarifLayanan[layanan]!;
  final int total = (berat * hargaPerKg).round();

  // Map menyimpan rincian satu pesanan dengan kunci yang mudah dikenali.
  pesanan.add({
    'id': idBerikutnya,
    'nama': nama,
    'layanan': layanan,
    'berat': berat,
    'hargaPerKg': hargaPerKg,
    'total': total,
    'status': 'Diproses',
    'dibayar': false,
  });

  print('Pesanan berhasil dibuat dengan ID $idBerikutnya.');
  print('Total biaya: Rp ${formatRupiah(total)}');
  return idBerikutnya + 1;
}

/// Menampilkan semua Map pesanan yang tersimpan di dalam List.
void lihatPesanan(List<Map<String, dynamic>> pesanan) {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan.');
    return;
  }

  print('\n--- DAFTAR PESANAN ---');
  for (final Map<String, dynamic> item in pesanan) {
    final String statusBayar = item['dibayar'] == true ? 'Lunas' : 'Belum dibayar';
    print(
      'ID ${item['id']} | ${item['nama']} | ${item['layanan']} | '
      '${item['berat']} kg | Rp ${formatRupiah(item['total'] as int)} | '
      '${item['status']} | $statusBayar',
    );
  }
}

/// Mengubah status proses berdasarkan ID pesanan.
void ubahStatus(List<Map<String, dynamic>> pesanan) {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan yang bisa diperbarui.');
    return;
  }

  final int? id = bacaAngka('Masukkan ID pesanan: ');
  if (id == null) {
    print('ID harus berupa angka.');
    return;
  }

  final int index = pesanan.indexWhere((item) => item['id'] == id);
  if (index == -1) {
    print('Pesanan dengan ID $id tidak ditemukan.');
    return;
  }

  print('Pilih status baru:');
  print('1. Diproses');
  print('2. Siap diambil');
  print('3. Selesai');
  final int? pilihanStatus = bacaAngka('Status (1-3): ');

  String? statusBaru;
  if (pilihanStatus == 1) {
    statusBaru = 'Diproses';
  } else if (pilihanStatus == 2) {
    statusBaru = 'Siap diambil';
  } else if (pilihanStatus == 3) {
    statusBaru = 'Selesai';
  } else {
    print('Pilihan status tidak valid.');
    return;
  }

  // Perbarui nilai Map pada posisi pesanan yang ditemukan.
  pesanan[index]['status'] = statusBaru;
  print('Status pesanan ID $id berhasil diubah menjadi "$statusBaru".');
}

/// Mencatat pembayaran untuk pesanan berdasarkan ID.
void pembayaran(List<Map<String, dynamic>> pesanan) {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan untuk dibayar.');
    return;
  }

  final int? id = bacaAngka('Masukkan ID pesanan: ');
  if (id == null) {
    print('ID harus berupa angka.');
    return;
  }

  final int index = pesanan.indexWhere((item) => item['id'] == id);
  if (index == -1) {
    print('Pesanan dengan ID $id tidak ditemukan.');
    return;
  }

  final Map<String, dynamic> item = pesanan[index];
  if (item['dibayar'] == true) {
    print('Pesanan tersebut sudah dibayar.');
    return;
  }

  final int total = item['total'] as int;
  final int? uangBayar = bacaAngka(
    'Total Rp ${formatRupiah(total)}. Uang pembayaran: Rp ',
  );

  if (uangBayar == null || uangBayar <= 0) {
    print('Nominal pembayaran tidak valid.');
    return;
  }
  if (uangBayar < total) {
    print('Uang pembayaran tidak cukup.');
    return;
  }

  item['dibayar'] = true;
  print('Pembayaran berhasil. Kembalian: Rp ${formatRupiah(uangBayar - total)}');
}

/// Menghapus pesanan dari List berdasarkan ID uniknya.
void hapusPesanan(List<Map<String, dynamic>> pesanan) {
  if (pesanan.isEmpty) {
    print('Belum ada pesanan yang bisa dihapus.');
    return;
  }

  lihatPesanan(pesanan);
  final int? id = bacaAngka('Masukkan ID pesanan yang akan dihapus: ');
  if (id == null) {
    print('ID harus berupa angka.');
    return;
  }

  final int index = pesanan.indexWhere((item) => item['id'] == id);
  if (index == -1) {
    print('Pesanan dengan ID $id tidak ditemukan.');
    return;
  }

  final Map<String, dynamic> itemDihapus = pesanan.removeAt(index);
  print('Pesanan ID $id milik ${itemDihapus['nama']} berhasil dihapus.');
}

/// Memformat angka rupiah dengan titik sebagai pemisah ribuan.
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
