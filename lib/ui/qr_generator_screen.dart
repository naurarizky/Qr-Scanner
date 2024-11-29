import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart'; // Bikin QR Code yang estetik
import 'package:share_plus/share_plus.dart'; // Buat fitur share teks atau data

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  String? qrRawValue; // Nyimpen teks atau link yang mau diubah jadi QR Code
  final TextEditingController _controller = TextEditingController(); // Buat ngontrol input user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR Code"), // Judul di header
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generator"); // Pindah ke halaman QR Scanner (kalau ada)
            },
            icon: const Icon(Icons.qr_code_scanner), // Ikon buat pindah
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0), // Spasi biar nggak nempel ke tepi
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ngatur posisi elemen biar rata
          crossAxisAlignment: CrossAxisAlignment.center, // Semuanya di tengah
          children: [
            // TextField buat input teks atau link
            TextField(
              controller: _controller, // Koneksi input user ke controller
              decoration: const InputDecoration(
                hintText: "Enter text or link to generate QR Code", // Petunjuk biar user tahu harus isi apa
              ),
            ),
            // Tombol buat mulai proses bikin QR Code
            ElevatedButton(
              onPressed: () {
                setState(() {
                  qrRawValue = _controller.text; // Ambil teks dari TextField
                });

                // Kalau user nggak isi apa-apa, kasih peringatan
                if (qrRawValue == null || qrRawValue!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Please enter text to generate QR Code.",
                        style: TextStyle(color: Colors.blue), // Warna teks peringatan
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                "Enter",
                style: TextStyle(color: Colors.blue, fontSize: 17), // Gaya teks tombol
              ),
            ),
            // Kalau ada teks yang valid, QR Code-nya muncul
            if (qrRawValue != null && qrRawValue!.isNotEmpty)
              PrettyQrView.data(
                data: qrRawValue!, // Data buat QR Code
                errorCorrectLevel: QrErrorCorrectLevel.M, // Tingkat koreksi kalau ada error
              ),
            // Tombol buat share QR Code
            ElevatedButton(
              onPressed: () {
                // Kalau belum ada QR Code, kasih peringatan
                if (qrRawValue == null || qrRawValue!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please generate a QR Code before sharing."), // Pesan kalau QR Code belum ada
                    ),
                  );
                } else {
                  Share.share(qrRawValue!); // Share data ke aplikasi lain
                }
              },
              child: const Text(
                "Share",
                style: TextStyle(color: Colors.blue), // Gaya teks tombol share
              ),
            ),
          ],
        ),
      ),
    );
  }
}
