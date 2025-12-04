import 'package:flutter/material.dart';

// --- Assets Paths ---
// Ganti placeholder dengan path lokal yang benar sesuai struktur baru
const String assetHero = 'assets/images/hero-bg2.jpg';
const String assetBorobudur = 'assets/images/fav-dest-section-candi-borobudur.jpg';
const String assetMonas = 'assets/images/fav-dest-section-tugu-monas.jpg';
const String assetTugu = 'assets/images/fav-dest-section-tugu-jogja.jpg';
const String assetGadang = 'assets/images/fav-dest-section-jam-gadang.jpg';
const String assetKresek = 'assets/images/fav-dest-section-monumen-kresek.jpg';
const String assetPrambanan = 'assets/images/fav-dest-section-candi-prambanan.jpg';

final List<Map<String, dynamic>> destinationsData = [
  {'name': 'Monumen Kresek', 'image': assetKresek},
  {'name': 'Monas', 'image': assetMonas},
  {'name': 'Tugu Yogyakarta', 'image': assetTugu},
  {'name': 'Jam Gadang', 'image': assetGadang},
  {'name': 'Candi Borobudur', 'image': assetBorobudur},
  {'name': 'Candi Prambanan', 'image': assetPrambanan},
];

final List<Map<String, dynamic>> vrDestinations = [
  {'slug': 'candi-borobudur', 'image': assetBorobudur, 'title': 'Candi Borobudur', 'location': 'Magelang, Jawa Tengah'},
  {'slug': 'monumen-nasional', 'image': assetMonas, 'title': 'Monumen Nasional', 'location': 'Jakarta, DKI Jakarta'},
  {'slug': 'tugu-jogja', 'image': assetTugu, 'title': 'Tugu Jogjakarya', 'location': 'D.I.Yogyakarta'},
  {'slug': 'jam-gadang', 'image': assetGadang, 'title': 'Jam Gadang', 'location': 'Bukit Tinggi, Sumatera'},
];

// --- Dashboard Component Widgets ---

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header / AppBar
          const _CustomHeader(),
          
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _HeroSection(),
                const _FavoriteDestinationsSection(),
                const _ARTorioSection(),
                const _VRTorioSection(),
                const _FooterSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader();

  @override
  Widget build(BuildContext context) {
    // Menggunakan SliverAppBar agar terasa native dan bisa di-scroll
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF004D40),
      elevation: 4.0,
      title: const Text(
        'ORATORIO',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: 24,
        ),
      ),
      actions: [
        // Dummy User/Menu Dropdown for Mobile
        IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () {
            // Aksi Logout atau navigasi ke profile
            // Mengarahkan ke /login dan menghapus rute sebelumnya, seperti fungsionalitas Logout
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          },
        ),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.5, // 50% tinggi layar untuk kesan mobile modern
      decoration: BoxDecoration(
        image: DecorationImage(
          // Menggunakan Image.asset untuk gambar lokal
          image: const AssetImage(assetHero),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        ),
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Jelajahi Bersama Oratorio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Hidupkan Kembali Sejarah. Jelajahi Budaya Indonesia di Mana Saja.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final String imageSrc;
  final String name;

  const _DestinationCard({required this.imageSrc, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Menggunakan Image.asset untuk gambar lokal
            Image.asset(
              imageSrc,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => 
                const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteDestinationsSection extends StatelessWidget {
  const _FavoriteDestinationsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 40, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Destinasi Favorit',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004D40),
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 kolom untuk mobile
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.9, // sedikit lebih tinggi dari lebar
            ),
            itemCount: destinationsData.length,
            itemBuilder: (context, index) {
              final destination = destinationsData[index];
              return _DestinationCard(
                name: destination['name'] as String,
                imageSrc: destination['image'] as String,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ARTorioSection extends StatelessWidget {
  const _ARTorioSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const _SectionTitle(title: 'AR TORIO', color: Color(0xFF004D40)),
          const SizedBox(height: 16),
          const Text(
            'Jelajahi Warisan Budaya dengan Augmented Reality',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'Candi Borobudur',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Logika navigasi ke AR Gallery
                  },
                  icon: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
                  label: const Text('Lihat Semua Koleksi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D40),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  
  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Colors.grey, thickness: 1)),
      ],
    );
  }
}

class _VRTorioSection extends StatelessWidget {
  const _VRTorioSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SectionTitle(title: 'VR TORIO', color: Color(0xFF004D40)),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 kolom untuk mobile
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.8, // Menyesuaikan dengan konten kartu
            ),
            itemCount: vrDestinations.length,
            itemBuilder: (context, index) {
              final item = vrDestinations[index];
              return InkWell(
                onTap: () {
                  // Navigasi ke VR detail page
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: 
                          // Menggunakan Image.asset untuk gambar lokal
                          Image.asset(
                            item['image'] as String,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) => 
                              const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '📍 ${item['title']}, ${item['location']}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
      child: Column(
        children: [
          // Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.facebook, color: Colors.white, size: 28)),
              // FIX: Mengganti Icons.pinterest (yang tidak ada) dengan Icons.share
              IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.white, size: 28)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam, color: Colors.white, size: 28)), // YouTube Placeholder
              IconButton(onPressed: () {}, icon: const Icon(Icons.photo_camera, color: Colors.white, size: 28)), // Instagram Placeholder
            ],
          ),
          const SizedBox(height: 32),
          
          // Footer Links (Dibuat vertikal untuk mobile)
          const _FooterLink(text: 'Help Center'),
          const _FooterLink(text: 'FAQ'),
          const _FooterLink(text: 'About Oratorio'),
          const _FooterLink(text: 'Destinasi'),
          const _FooterLink(text: 'Augmented Reality Interface'),
          const _FooterLink(text: 'Virtual Reality Interface'),
          const _FooterLink(text: 'Kebijakan Privasi'),
          const _FooterLink(text: 'Syarat & Ketentuan'),
          
          const SizedBox(height: 24),
          const Divider(color: Colors.grey, height: 1),
          const SizedBox(height: 16),
          
          // Copyright
          const Text(
            '© 2025 Oratorio, Inc.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;

  const _FooterLink({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}