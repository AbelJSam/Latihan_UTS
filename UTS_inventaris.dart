import 'dart:io';

void main () {
  final List<Map<String, String>> inventaris = [];

  bool jalan = true;

  while (jalan) {
    tampilkanMenu();
    final int? pilihan = bacaAngka('Pilih menu (1-4): ');

    // switch mengarahkan pilihan pengguna ke fitur yang sesuai.
    switch (pilihan) {
      case 1:
        tambahBarang(inventaris);
        break;
      case 2:
        tampilkanInventaris(inventaris);
        break;
      case 3:
        hapusBarang(inventaris);
        break;
      case 4:
        jalan = false;
        print('Program selesai.');
        break;
      default:
        // Termasuk input kosong, bukan angka, atau angka di luar 1-6.
        print('Pilihan tidak valid. Masukkan angka 1 sampai 4.');
    }
  }
}

/// Menampilkan pilihan fitur yang bisa digunakan.
void tampilkanMenu() {
  print('\n====== INVENTARIS  ======');
  print('1. Tambah barang');
  print('2. Lihat Penyimpanan');
  print('3. Hapus Penyimpanan');
  print('4. Exit');
  print('============================');
}

/// Membaca input angka.
/// int.tryParse mengembalikan null jika teks yang dimasukkan bukan angka.
int? bacaAngka(String pesan) {
  stdout.write(pesan);
  return int.tryParse(stdin.readLineSync()?.trim() ?? '');
}

//===========================================
//            tambah barang
//===========================================
void tambahBarang(List<Map<String, String>> inventaris) {
  stdout.write('Pilih Gedung Penyimpanan (A / B / C / D : ');
  String? gedung = (stdin.readLineSync() ?? "").trim();

  if (gedung.isEmpty){
    print('Harus pilih gedung');
    return;
  }

  stdout.write('Nama barang: ');
  final String nama = (stdin.readLineSync() ?? '').trim();

  if (nama.isEmpty) {
    print('Nama barang tidak boleh kosong.');
    return;
  }

  stdout.write('Harga barang : ');
  String? harga = (stdin.readLineSync() ?? "" );
  if (harga.isEmpty) {
    print('Harga harus berupa angka bulat dan tidak boleh negatif.');
    return;
  }

  stdout.write('Stok barang : ');
  String? stok = (stdin.readLineSync() ?? "" );
  if (stok.isEmpty) {
    print('Harga harus berupa angka bulat dan tidak boleh negatif.');
    return;
  }


  // Satu Map mewakili satu barang; add menaruhnya di akhir List.
  inventaris.add({
    'gedung': gedung,
    'nama': nama,
    'harga': harga, 
    'stok': stok
    
    });
  print('Barang "$nama" berhasil ditambahkan.');
}

//===========================================
//            Tampilkan barang
//===========================================
void tampilkanInventaris(List<Map<String, String>> inventaris) {
    stdout.write('Pilih Gedung Penyimpanan (A / B / C / D : ');
    String? gedung = (stdin.readLineSync() ?? "").trim();
  if (gedung.isEmpty) {
    print('Pilih Gedung Terlebih Dahulu.');
    return;
  }

  print('\n--- DAFTAR BARANG ---');
  for (int i = 0; i < inventaris.length; i++) {
    final Map<String, dynamic> gedungPenyimpanan = inventaris[i];
    if ((gedungPenyimpanan['gedung'] as String).toLowerCase() == gedung.toLowerCase()){
      print('Barang ditemukan');
      print(
        '${i + 1}. ${gedungPenyimpanan['nama']} | ${gedungPenyimpanan['harga']} | ${gedungPenyimpanan['stok']}'
      );
    }

  }
}

//===========================================
//            Hapus barang
//===========================================
void hapusBarang(List<Map<String, String>> inventaris) {
  tampilkanInventaris(inventaris);
    if(inventaris.isEmpty) {
    print('Gudang Kosong');
    return;
  }
  final int? nomor = bacaAngka('Masukkan nomor barang yang ingin dihapus: ');

  // Nomor tampilan dimulai dari 1, sedangkan indeks List dimulai dari 0.
  if (nomor == null || nomor < 1 || nomor > inventaris.length) {
    print('Nomor tidak valid. Pilih nomor yang ada pada daftar.');
    return;
  }

  final Map<String, String> barangDihapus = inventaris.removeAt(nomor - 1);
  print('Barang "${barangDihapus['nama']}" berhasil dihapus.');
}


