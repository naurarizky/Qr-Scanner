import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  late MobileScannerController cameraController;
  bool isScanning = true; // Status apakah scanner sedang aktif

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );
  }

  void toggleScanning() {
    setState(() {
      isScanning = !isScanning;
    });
    if (isScanning) {
      cameraController.start();
    } else {
      cameraController.stop();
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scan QR Code!",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Kamera untuk scanner
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (!isScanning) return; // Skip scanning if stopped
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  debugPrint('QR Code Data: ${barcode.rawValue}');
                  // Tambahkan logika untuk menggunakan data QR di sini
                  // Misalnya, tampilkan dialog atau navigasi
                }
              }
            },
          ),
          // Overlay dengan kotak panduan
          Center(
            child: Container(
              width: 250, // Lebar kotak
              height: 250, // Tinggi kotak
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white, // Warna kotak
                  width: 3, // Ketebalan garis
                ),
                borderRadius: BorderRadius.circular(8), // Kotak dengan sudut melengkung
              ),
            ),
          ),
          // Overlay hitam di luar kotak (opsional)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                color: Colors.black.withOpacity(0.5), // Efek gelap di luar kotak
              ),
            ),
          ),
          // Tombol Scan
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 75, // Center tombol
            child: ElevatedButton.icon(
              onPressed: toggleScanning,
              icon: Icon(isScanning ? Icons.stop : Icons.play_arrow),
              label: Text(isScanning ? "Stop Scan" : "Start Scan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Warna latar belakang tombol
                minimumSize: const Size(150, 50), // Ukuran tombol
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QrScannerScreen(),
  ));
}
