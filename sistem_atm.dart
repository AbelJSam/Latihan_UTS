import 'dart:io';

void main() {
  // Saldo awal ATM.
  // Jika saldo awal pada ATM Anda berbeda, ubah angka ini.
  int saldo = 500000;

  // PIN yang digunakan untuk masuk ke ATM.
  const String pinBenar = '1234';

  // =============================
  // LOGIN PIN
  // =============================
  print('\n====================================');
  print('          BANK ABEL');
  print('====================================');

  stdout.write('Masukan Pin Anda : ');
  String pin = stdin.readLineSync() ?? '';

  if (pin != pinBenar) {
    print('\nPin Anda Salah');
    return;
  }

  bool jalan = true;

  // =============================
  // MENU UTAMA
  // =============================
  while (jalan) {
    tampilMenu();

    stdout.write('Pilih Menu (1/2/3/4) : ');
    String input = stdin.readLineSync() ?? '';
    int? pilihan = int.tryParse(input);

    switch (pilihan) {
      case 1:
        cekSaldo(saldo);
        break;

      case 2:
        saldo = setorTunai(saldo);
        break;

      case 3:
        saldo = tarikTunai(saldo);
        break;
      case 4:
        jalan = false;

        print("\nProgram selesai.");
        break;
      default:
        print('\nPilihan menu tidak tersedia.');
    }

    // ATM pada atm.exe kembali ke menu setelah transaksi.
    // Tekan ENTER agar hasil transaksi dapat dibaca terlebih dahulu.
    // stdout.write('\nTekan ENTER untuk kembali ke menu...');
    // stdin.readLineSync();
  }
}

// =============================
// TAMPIL MENU
// =============================
void tampilMenu() {
  print('\n====================================');
  print('          BANK SERBA ADA');
  print('====================================');
  print('1. Cek Saldo');
  print('2. Setor Tunai');
  print('3. Tarik Tunai');
  print('4. Exit');
  print('====================================');
}

// =============================
// CEK SALDO
// =============================
void cekSaldo(int saldo) {
  print('\n=========== SALDO SAAT INI ==========');
  print('SALDO ANDA : Rp. ${formatRupiah(saldo)}');
}

// =============================
// SETOR TUNAI
// =============================
int setorTunai(int saldo) {
  stdout.write('Jumlah yang disetor : ');
  String input = stdin.readLineSync() ?? '';
  int? jumlah = int.tryParse(input);

  if (jumlah == null || jumlah <= 0) {
    print('Nominal setor tidak valid.');
    return saldo;
  }

  saldo += jumlah;

  print('Setor tunai berhasil.');
  print('Jumlah yang disetor : Rp. ${formatRupiah(jumlah)}');
  print('Saldo Anda sekarang : Rp. ${formatRupiah(saldo)}');

  return saldo;
}

// =============================
// TARIK TUNAI
// =============================
int tarikTunai(int saldo) {
  stdout.write('Jumlah yang ditarik : ');
  String input = stdin.readLineSync() ?? '';
  int? jumlah = int.tryParse(input);

  if (jumlah == null || jumlah <= 0) {
    print('Nominal penarikan tidak valid.');
    return saldo;
  }

  // Sesuai alur atm.exe, penarikan menggunakan pecahan
  // Rp50.000 dan Rp100.000.
  if (jumlah % 50000 != 0) {
    print('Nominal harus merupakan kelipatan Rp. 50.000.');
    return saldo;
  }

  if (jumlah > saldo) {
    print('Maaf, Saldo anda tidak cukup');
    return saldo;
  }

  stdout.write('Pilih pecahan :\n');
  print('1. pecahan 50.000');
  print('2. pecahan 100.000');
  stdout.write('Pilih pecahan (1/2) : ');
  String pilihan = stdin.readLineSync() ?? '';

  int pecahan;

  if (pilihan == '1') {
    pecahan = 50000;
  } else if (pilihan == '2') {
    pecahan = 100000;
  } else {
    print('Pilihan pecahan tidak tersedia.');
    return saldo;
  }

  // Jumlah harus dapat dibentuk oleh pecahan yang dipilih.
  if (jumlah % pecahan != 0) {
    print('Jumlah tidak dapat dikeluarkan dengan pecahan tersebut.');
    return saldo;
  }

  saldo -= jumlah;

  int lembar = jumlah ~/ pecahan;

  print('\nPenarikan berhasil.');
  print('Rp. ${formatRupiah(pecahan)} x $lembar');
  print('Jumlah yang ditarik : Rp. ${formatRupiah(jumlah)}');
  print('Saldo Anda sekarang : Rp. ${formatRupiah(saldo)}');

  return saldo;
}

// =============================
// FORMAT RUPIAH
// =============================
String formatRupiah(int angka) {
  String nilai = angka.toString();
  String hasil = '';
  int hitung = 0;

  for (int i = nilai.length - 1; i >= 0; i--) {
    hasil = nilai[i] + hasil;
    hitung++;

    if (hitung == 3 && i != 0) {
      hasil = '.$hasil';
      hitung = 0;
    }
  }

  return hasil;
}