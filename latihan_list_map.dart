import 'dart:io';

/// LATIHAN LIST DAN MAP: INVENTARIS ALAT TULIS
///
/// Petunjuk:
/// 1. Selesaikan TODO satu per satu.
/// 2. Satu barang disimpan sebagai Map dengan kunci:
///    'nama' (String), 'stok' (int), dan 'harga' (int).
/// 3. Semua barang disimpan berurutan dalam List `inventaris`.
/// 4. Jalankan program dengan: dart latihan_list_map.dart

void main() {
  List<Map<String, dynamic>> inventaris = [];
  bool jalan = true;

  while (jalan) {
    tampilkanMenu();
    int? pilihan = bacaAngka('Pilih menu (1-6): ');

    switch (pilihan) {
      case 1:
        tambahBarang(inventaris);
        break;
      case 2:
        tampilkanInventaris(inventaris);
        break;
      case 3:
        cariBarang(inventaris);
        break;
      case 4:
        ubahStok(inventaris);
        break;
      case 5:
        hapusBarang(inventaris);
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
  print('\n=== INVENTARIS ALAT TULIS ===');
  print('1. Tambah barang');
  print('2. Lihat semua barang');
  print('3. Cari barang berdasarkan nama');
  print('4. Ubah stok barang');
  print('5. Hapus barang');
  print('6. Keluar');
}

/// Membaca angka dari terminal. Mengembalikan null jika input bukan angka.
int? bacaAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync() ?? '');
}

void tambahBarang(List<Map<String, dynamic>> inventaris) {
  stdout.write('Masukkan nama barang: ');
  String nama = (stdin.readLineSync() ?? '').trim();

  if (nama.isEmpty) {
    print('Nama barang tidak boleh kosong.');
    return;
  }

  stdout.write('Masukkan stok awal: ');
  int? stok = int.tryParse(stdin.readLineSync() ?? '');
  if (stok == null) {
    print('Stok tidak valid.');
    return;
  }

  stdout.write('Masukkan harga barang: ');
  int? harga = int.tryParse(stdin.readLineSync() ?? '');
  if (harga == null) {
    print('Harga tidak valid.');
    return;
  }

  for (var barang in inventaris) {
    if ((barang['nama'] as String).toLowerCase() == nama.toLowerCase()) {
      print('Barang sudah ada di inventaris.');
      return;
    }
  }

  inventaris.add({'nama': nama, 'stok': stok, 'harga': harga});
  print('Barang berhasil ditambahkan.');
}

void tampilkanInventaris(List<Map<String, dynamic>> inventaris) {
  if (inventaris.isEmpty) {
    print('Inventaris kosong.');
    return;
  }

  for (int i = 0; i < inventaris.length; i++) {
    var barang = inventaris[i];
    print(
      '${i + 1}. ${barang['nama']} | Stok: ${barang['stok']} | Harga: ${barang['harga']}',
    );
  }
}

void cariBarang(List<Map<String, dynamic>> inventaris) {
  stdout.write('Masukkan nama barang yang dicari: ');
  String nama = (stdin.readLineSync() ?? '').trim();

  if (nama.isEmpty) {
    print('Nama barang tidak boleh kosong.');
    return;
  }

  for (var barang in inventaris) {
    if ((barang['nama'] as String).toLowerCase() == nama.toLowerCase()) {
      print('Barang ditemukan:');
      print(
        'Nama: ${barang['nama']} | Stok: ${barang['stok']} | Harga: ${barang['harga']}',
      );
      return;
    }
  }

  print('Barang tidak ditemukan.');
}

void ubahStok(List<Map<String, dynamic>> inventaris) {
  stdout.write('Masukkan nama barang: ');
  String nama = (stdin.readLineSync() ?? '').trim();

  if (nama.isEmpty) {
    print('Nama barang tidak boleh kosong.');
    return;
  }

  stdout.write('Masukkan stok baru: ');
  int? stokBaru = int.tryParse(stdin.readLineSync() ?? '');
  if (stokBaru == null) {
    print('Stok baru tidak valid.');
    return;
  }

  for (int i = 0; i < inventaris.length; i++) {
    if ((inventaris[i]['nama'] as String).toLowerCase() == nama.toLowerCase()) {
      inventaris[i]['stok'] = stokBaru;
      print('Stok barang berhasil diubah.');
      return;
    }
  }

  print('Barang tidak ditemukan.');
}

void hapusBarang(List<Map<String, dynamic>> inventaris) {
  if (inventaris.isEmpty) {
    print('Inventaris kosong.');
    return;
  }

  tampilkanInventaris(inventaris);
  stdout.write('Masukkan nomor barang yang ingin dihapus: ');
  int? nomor = int.tryParse(stdin.readLineSync() ?? '');

  if (nomor == null || nomor < 1 || nomor > inventaris.length) {
    print('Nomor tidak valid.');
    return;
  }

  inventaris.removeAt(nomor - 1);
  print('Barang berhasil dihapus.');
}
