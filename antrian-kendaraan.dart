import 'dart:io';

void main() {
  // ==============================
  // WAITING LIST / ANTRIAN
  // ==============================
  List<Map<String, String>> waitingList = [];

  // ==============================
  // POS 1, POS 2, POS 3
  // ==============================
  Map<String, String>? pos1;
  Map<String, String>? pos2;
  Map<String, String>? pos3;

  bool jalan = true;

  // ==============================
  // PROGRAM UTAMA
  // ==============================
  while (jalan == true) {
    print("\n====================================");
    print("         CUCI KENDARAAN WD");
    print("====================================");
    print("1. Tambah kendaraan");
    print("2. Lihat antrian");
    print("3. Lihat Pos");
    print("4. Selesaikan posisi");
    print("5. Exit");
    print("====================================");

    //  stdout.write("Pilih menu: ");

    // String? input = stdin.readLineSync();
    // int? pilihan = int.tryParse(input ?? "");

    int? pilihan;

while (pilihan == null) {
  stdout.write('Pilih menu (1-5) : ');
  pilihan = int.tryParse(stdin.readLineSync() ?? '');

  if (pilihan == null || pilihan < 1 || pilihan > 5) {
    print('Masukkan angka 1 sampai 5.');
    pilihan = null;
  }
}

    switch (pilihan) {

      // ==========================================
      // 1. TAMBAH KENDARAAN
      // ==========================================
      case 1:
        stdout.write("Masukkan plat nomor: ");
        String plat = stdin.readLineSync() ?? "";

          RegExp formatPlat = RegExp(
          r'^[A-Za-z]{1,2} [0-9]{1,4}( [A-Za-z]{1,3})?$'
        );

        // if (plat.isEmpty) {
        //   print("\nPlat nomor tidak boleh kosong.");
        // }
        if (!formatPlat.hasMatch(plat)) {
          print("\n ERROR : Format plat tidak valid!");
          print("Contoh: KB 1000 AA, B 1234 CD, atau KB 1234");
        }

        // Jika Pos 1 kosong
        else if (pos1 == null) {
          pos1 = {
            "Plat": plat
          };

          print("\nKendaraan langsung masuk ke Pos 1.");
          print("Plat : $plat");
        }

        // Jika Pos 1 terisi, tetapi Pos 2 kosong
        else if (pos2 == null) {
          pos2 = {
            "Plat": plat
          };

          print("\nKendaraan langsung masuk ke Pos 2.");
          print("Plat : $plat");
        }

        // Jika Pos 1 dan Pos 2 terisi,
        // tetapi Pos 3 kosong
        else if (pos3 == null) {
          pos3 = {
            "Plat": plat
          };

          print("\nKendaraan langsung masuk ke Pos 3.");
          print("Plat : $plat");
        }

        // Jika semua Pos penuh
        // else {
        //   waitingList.add({
        //     "Plat": plat
        //   });
         else {
          waitingList.add({
            "Plat": plat.toUpperCase()
          });

          print("\nSemua Pos sedang penuh.");
          print("Kendaraan masuk ke dalam antrian.");
          print("Plat : $plat");
        }

        break;

      // ==========================================
      // 2. LIHAT ANTRIAN
      // ==========================================
      case 2:
       print("\n========== DAFTAR ANTRIAN ==========");

        if (waitingList.isEmpty) {
          print("Antrian kosong.");
        } else {
          for (int i = 0; i < waitingList.length; i++) {
            print(
              "${i + 1}. ${waitingList[i]["Plat"]}"
            );
          }
        }

        break;
      // ==========================================
      // 3. LIHAT POSISI
      // ==========================================
      case 3:
        print("\n=============== POS ===============");

        if (pos1 == null) {
          print("Pos 1 : kosong");
        } else {
          print("Pos 1 : ${pos1["Plat"]}");
        }

        if (pos2 == null) {
          print("Pos 2 : kosong");
        } else {
          print("Pos 2 : ${pos2["Plat"]}");
        }

        if (pos3 == null) {
          print("Pos 3 : kosong");
        } else {
          print("Pos 3 : ${pos3["Plat"]}");
        }

        break;

      // ==========================================
      // 4. SELESAIKAN POSISI
      // ==========================================
      case 4:
        print("\n========== SELESAIKAN POS ==========");
        print("1. Pos 1");
        print("2. Pos 2");
        print("3. Pos 3");

        stdout.write("Pilih pos: ");

        String? inputPos = stdin.readLineSync();
        int? pilihanPos = int.tryParse(inputPos ?? "");

        switch (pilihanPos) {

          // ======================================
          // SELESAIKAN POS 1
          // ======================================
          case 1:
            if (pos1 == null) {
              print("Pos 1 masih kosong.");
            } else {
              print(
                "Pos 1 - ${pos1["Plat"]} telah selesai."
              );

              pos1 = null;

              // Jika ada kendaraan dalam antrian,
              // masukkan kendaraan pertama ke Pos 1
              if (waitingList.isNotEmpty) {
                pos1 = waitingList.removeAt(0);

                print(
                  "Kendaraan ${pos1["Plat"]} "
                  "masuk ke Pos 1 dari antrian."
                );
              }
            }

            break;

          // ======================================
          // SELESAIKAN POS 2
          // ======================================
          case 2:
            if (pos2 == null) {
              print("Pos 2 masih kosong.");
            } else {
              print(
                "Pos 2 - ${pos2["Plat"]} telah selesai."
              );

              pos2 = null;

              // Jika ada kendaraan dalam antrian,
              // masukkan kendaraan pertama ke Pos 2
              if (waitingList.isNotEmpty) {
                pos2 = waitingList.removeAt(0);

                print(
                  "Kendaraan ${pos2["Plat"]} "
                  "masuk ke Pos 2 dari antrian."
                );
              }
            }

            break;

          // ======================================
          // SELESAIKAN POS 3
          // ======================================
          case 3:
            if (pos3 == null) {
              print("Pos 3 masih kosong.");
            } else {
              print(
                "Pos 3 - ${pos3["Plat"]} telah selesai."
              );

              pos3 = null;

              // Jika ada kendaraan dalam antrian,
              // masukkan kendaraan pertama ke Pos 3
              if (waitingList.isNotEmpty) {
                pos3 = waitingList.removeAt(0);

                print(
                  "Kendaraan ${pos3["Plat"]} "
                  "masuk ke Pos 3 dari antrian."
                );
              }
            }

            break;

          default:
            print("Pilihan pos tidak tersedia.");
        }

        break;

      // ==========================================
      // 5. EXIT
      // ==========================================
      case 5:
        jalan = false;

        print("\nProgram selesai.");
        break;

      // ==========================================
      // PILIHAN TIDAK VALID
      // ==========================================
      default:
        print("\nPilihan menu tidak tersedia.");
    }
  }
}