import 'package:flutter/material.dart';
import 'package:qr_scanner/ui/qr_generator_screen.dart'; // Import halaman untuk QR Generator
import 'package:qr_scanner/ui/qr_scanner_screen.dart'; // Import halaman untuk QR Scanner
import 'dart:developer'; // Import library untuk logging/debugging

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Mengatur warna latar belakang menjadi putih
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Memberikan padding di seluruh sisi
        child: Column(
          children: [
            const SizedBox(height: 50), // Memberikan jarak vertikal di bagian atas
            Image.asset(
              'assets/images/logo_splashh.png', // Menampilkan logo aplikasi
              height: 80, // Mengatur tinggi gambar
            ),
            const SizedBox(height: 10), // Memberikan jarak vertikal setelah logo
            const SizedBox(height: 20), // Memberikan jarak tambahan
            const Text(
              'Welcome to BeamScan!', // Teks selamat datang
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Gaya teks (besar dan tebal)
              textAlign: TextAlign.center, // Teks rata tengah
            ),
            const SizedBox(height: 10), // Jarak setelah teks utama
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30), // Margin horizontal teks deskripsi
              child: Text(
                'With this app, you can scan QR codes and get information easily. Click the button below to start scanning.',
                textAlign: TextAlign.center, // Teks rata tengah
                style: TextStyle(fontSize: 14), // Ukuran teks deskripsi
              ),
            ),
            const SizedBox(height: 30), // Jarak sebelum bagian grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Membuat grid dengan 2 kolom
                crossAxisSpacing: 16, // Jarak antar kolom
                mainAxisSpacing: 16, // Jarak antar baris
                padding: const EdgeInsets.all(10), // Padding keseluruhan grid
                children: [
                  _buildCard(
                    context,
                    icon: Icons.qr_code_scanner, // Ikon QR Scanner
                    color: Colors.redAccent, // Warna merah pada ikon
                    label: 'Scan QR', // Label untuk tombol
                    onTap: () {
                      // Navigasi ke halaman QR Scanner
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  QrScannerScreen(),
                      ));
                      log('Scan QR tapped'); // Logging untuk debug
                    },
                  ),
                  _buildCard(
                    context,
                    icon: Icons.add_circle_outline, // Ikon untuk membuat QR
                    color: Colors.blueAccent, // Warna biru pada ikon
                    label: 'Create', // Label untuk tombol
                    onTap: () {
                      // Navigasi ke halaman QR Generator
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QrGeneratorScreen(),
                      ));
                      log('Create tapped'); // Logging untuk debug
                    },
                  ),
                  _buildCard(
                    context,
                    icon: Icons.print, // Ikon untuk Print
                    color: Colors.green, // Warna hijau pada ikon
                    label: 'Print', // Label untuk tombol
                    onTap: () {
                      log('Print tapped'); // Logging untuk debug
                    },
                  ),
                  _buildCard(
                    context,
                    icon: Icons.send, // Ikon untuk Send
                    color: Colors.orange, // Warna oranye pada ikon
                    label: 'Send', // Label untuk tombol
                    onTap: () {
                      log('Send tapped'); // Logging untuk debug
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol "History" ditekan
                log('History button tapped'); // Logging untuk debug
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, // Warna tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Membuat tombol dengan sudut melengkung
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Padding teks tombol
                child: Text(
                  'HISTORY', // Teks tombol
                  style: TextStyle(fontSize: 16, color: Colors.white), // Gaya teks tombol
                ),
              ),
            ),
            const SizedBox(height: 20), // Jarak tambahan di bagian bawah
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membangun kartu dalam grid
  Widget _buildCard(BuildContext context,
      {required IconData icon, // Ikon kartu
      required Color color, // Warna ikon
      required String label, // Label teks kartu
      required VoidCallback onTap}) { // Fungsi ketika kartu ditekan
    return GestureDetector(
      onTap: onTap, // Menangani aksi ketika kartu ditekan
      child: Card(
        elevation: 4, // Tinggi bayangan pada kartu
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Membuat kartu dengan sudut melengkung
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Konten dalam kartu rata tengah secara vertikal
          children: [
            CircleAvatar(
              radius: 30, // Ukuran lingkaran
              backgroundColor: color.withOpacity(0.2), // Warna latar belakang ikon dengan transparansi
              child: Icon(icon, size: 30, color: color), // Ikon di tengah lingkaran
            ),
            const SizedBox(height: 10), // Jarak antara ikon dan label
            Text(
              label, // Label teks pada kartu
              style: const TextStyle(
                fontSize: 14, // Ukuran teks label
                fontWeight: FontWeight.bold, // Teks label tebal
              ),
            ),
          ],
        ),
      ),
    );
  }
}
