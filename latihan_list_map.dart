import 'dart:io';

/// Program inventaris alat tulis untuk latihan List, Map, fungsi, dan menu.
///
/// Struktur data yang digunakan:
/// - List menyimpan banyak barang secara berurutan.
/// - Setiap barang berupa Map dengan kunci nama, stok, dan harga.
/// - dynamic dipakai karena tipe nilai Map berbeda: String dan int.
void main() {
  // List kosong untuk menyimpan seluruh barang selama program berjalan.
  final List<Map<String, dynamic>> inventaris = [];
  bool jalan = true;

  // Perulangan menjaga menu tetap muncul sampai pengguna memilih Keluar.
  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (1-6): ');

    // switch mengarahkan pilihan pengguna ke fitur yang sesuai.
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
        // Termasuk input kosong, bukan angka, atau angka di luar 1-6.
        print('Pilihan tidak valid. Masukkan angka 1 sampai 6.');
    }
  }
}

/// Menampilkan pilihan fitur yang bisa digunakan.
void tampilkanMenu() {
  print('\n=== INVENTARIS ALAT TULIS ===');
  print('1. Tambah barang');
  print('2. Lihat semua barang');
  print('3. Cari barang berdasarkan nama');
  print('4. Ubah stok barang');
  print('5. Hapus barang');
  print('6. Keluar');
}

/// Membaca input angka.
/// int.tryParse mengembalikan null jika teks yang dimasukkan bukan angka.
int? bacaAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync()?.trim() ?? '');
}

/// Meminta data barang lalu menyimpannya sebagai Map di dalam List.
void tambahBarang(List<Map<String, dynamic>> inventaris) {
  stdout.write('Masukkan nama barang: ');
  final String nama = (stdin.readLineSync() ?? '').trim();

  if (nama.isEmpty) {
    print('Nama barang tidak boleh kosong.');
    return;
  }

  // Cegah nama barang yang sama agar tidak ada entri duplikat.
  final bool sudahAda = inventaris.any(
    (barang) => (barang['nama'] as String).toLowerCase() == nama.toLowerCase(),
  );
  if (sudahAda) {
    print('Barang dengan nama tersebut sudah ada di inventaris.');
    return;
  }

  final int? stok = bacaAngka('Masukkan stok awal (0 atau lebih): ');
  if (stok == null || stok < 0) {
    print('Stok harus berupa angka bulat dan tidak boleh negatif.');
    return;
  }

  final int? harga = bacaAngka('Masukkan harga (0 atau lebih): ');
  if (harga == null || harga < 0) {
    print('Harga harus berupa angka bulat dan tidak boleh negatif.');
    return;
  }

  // Satu Map mewakili satu barang; add menaruhnya di akhir List.
  inventaris.add({'nama': nama, 'stok': stok, 'harga': harga});
  print('Barang "$nama" berhasil ditambahkan.');
}

/// Menampilkan semua Map barang dalam List beserta nomor urutnya.
void tampilkanInventaris(List<Map<String, dynamic>> inventaris) {
  if (inventaris.isEmpty) {
    print('Inventaris kosong.');
    return;
  }

  print('\n--- DAFTAR BARANG ---');
  for (int i = 0; i < inventaris.length; i++) {
    final Map<String, dynamic> barang = inventaris[i];
    // Indeks List mulai dari 0, sehingga nomor untuk pengguna adalah i + 1.
    print(
      '${i + 1}. ${barang['nama']} | '
      'Stok: ${barang['stok']} | Harga: Rp ${formatRupiah(barang['harga'] as int)}',
    );
  }
}

/// Mencari barang berdasarkan nama, tanpa membedakan huruf besar/kecil.
void cariBarang(List<Map<String, dynamic>> inventaris) {
  if (inventaris.isEmpty) {
    print('Inventaris kosong; belum ada barang yang dapat dicari.');
    return;
  }

  stdout.write('Masukkan nama barang yang dicari: ');
  final String nama = (stdin.readLineSync() ?? '').trim();
  if (nama.isEmpty) {
    print('Nama barang tidak boleh kosong.');
    return;
  }

  // Periksa tiap Map di dalam List sampai menemukan nama yang cocok.
  for (final Map<String, dynamic> barang in inventaris) {
    if ((barang['nama'] as String).toLowerCase() == nama.toLowerCase()) {
      print('Barang ditemukan:');
      print(
        'Nama: ${barang['nama']} | Stok: ${barang['stok']} | '
        'Harga: Rp ${formatRupiah(barang['harga'] as int)}',
      );
      return;
    }
  }

  print('Barang "$nama" tidak ditemukan.');
}

/// Mengubah nilai stok pada Map barang yang namanya cocok.
void ubahStok(List<Map<String, dynamic>> inventaris) {
  if (inventaris.isEmpty) {
    print('Inventaris kosong; belum ada stok yang dapat diubah.');
    return;
  }

  stdout.write('Masukkan nama barang: ');
  final String nama = (stdin.readLineSync() ?? '').trim();
  if (nama.isEmpty) {
    print('Nama barang tidak boleh kosong.');
    return;
  }

  final int? stokBaru = bacaAngka('Masukkan stok baru (0 atau lebih): ');
  if (stokBaru == null || stokBaru < 0) {
    print('Stok harus berupa angka bulat dan tidak boleh negatif.');
    return;
  }

  for (final Map<String, dynamic> barang in inventaris) {
    if ((barang['nama'] as String).toLowerCase() == nama.toLowerCase()) {
      // Map dapat diperbarui menggunakan kunci yang sudah ada.
      barang['stok'] = stokBaru;
      print('Stok ${barang['nama']} berhasil diubah menjadi $stokBaru.');
      return;
    }
  }

  print('Barang "$nama" tidak ditemukan.');
}

/// Menghapus barang berdasarkan nomor yang terlihat pada daftar.
void hapusBarang(List<Map<String, dynamic>> inventaris) {
  if (inventaris.isEmpty) {
    print('Inventaris kosong; tidak ada barang yang dapat dihapus.');
    return;
  }

  tampilkanInventaris(inventaris);
  final int? nomor = bacaAngka('Masukkan nomor barang yang ingin dihapus: ');

  // Nomor tampilan dimulai dari 1, sedangkan indeks List dimulai dari 0.
  if (nomor == null || nomor < 1 || nomor > inventaris.length) {
    print('Nomor tidak valid. Pilih nomor yang ada pada daftar.');
    return;
  }

  final Map<String, dynamic> barangDihapus = inventaris.removeAt(nomor - 1);
  print('Barang "${barangDihapus['nama']}" berhasil dihapus.');
}

/// Mengubah angka menjadi format ribuan Indonesia, misalnya 12500 menjadi 12.500.
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
