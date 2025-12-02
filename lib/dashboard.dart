// ...existing code...

import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF004D40); // tema sesuai main.dart

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORATORIO'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'History',
            onPressed: () => Navigator.pushNamed(context, '/history'),
            icon: const Icon(Icons.history),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'login') Navigator.pushNamed(context, '/login');
              if (value == 'register') Navigator.pushNamed(context, '/register');
              if (value == 'logout') Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'login', child: Text('Login')),
              PopupMenuItem(value: 'register', child: Text('Register')),
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          )
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: DashboardMobileBody(),
        ),
      ),
    );
  }
}

class DashboardMobileBody extends StatelessWidget {
  const DashboardMobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HeroSection(),
        SizedBox(height: 16),
        FavoriteDestinationsSection(),
        SizedBox(height: 24),
        ArTorioSection(),
        SizedBox(height: 24),
        VRTorioSection(),
        SizedBox(height: 40),
        FooterSection(),
        SizedBox(height: 20),
      ],
    );
  }
}

/* ---------------- HERO ---------------- */

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/hero-bg2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.35),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Jelajahi Bersama Oratorio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Hidupkan Kembali Sejarah. Jelajahi Budaya Indonesia di Mana Saja.',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const _SearchBar(),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextField(
        onSubmitted: (q) {
          // placeholder - bisa diganti navigasi ke hasil pencarian
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cari: $q')));
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, color: kPrimaryColor),
          hintText: 'Cari destinasi, AR atau VR...',
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

/* -------------- FAVORITE DESTINATIONS -------------- */

class FavoriteDestinationsSection extends StatelessWidget {
  const FavoriteDestinationsSection({super.key});

  static const List<Map<String, String>> _items = [
    {'name': 'Monumen Kresek', 'image': 'assets/images/fav-dest-section-monumen-kresek.jpg'},
    {'name': 'Monas', 'image': 'assets/images/fav-dest-section-tugu-monas.jpg'},
    {'name': 'Tugu Yogyakarta', 'image': 'assets/images/fav-dest-section-tugu-jogja.jpg'},
    {'name': 'Jam Gadang', 'image': 'assets/images/fav-dest-section-jam-gadang.jpg'},
    {'name': 'Candi Borobudur', 'image': 'assets/images/fav-dest-section-candi-borobudur.jpg'},
    {'name': 'Candi Prambanan', 'image': 'assets/images/fav-dest-section-candi-prambanan.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = MediaQuery.of(context).size.width > 420 ? 3 : 2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Destinasi Favorit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (_, idx) {
              final item = _items[idx];
              return DestinationCard(name: item['name']!, imagePath: item['image']!);
            },
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String name;
  final String imagePath;
  const DestinationCard({required this.name, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // bisa diarahkan ke detail
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(name)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: Colors.grey[300]),
              ),
            ),
            Container(color: Colors.black38),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Text(
                name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- AR TORIO ---------------- */

class ArTorioSection extends StatelessWidget {
  const ArTorioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'AR TORIO'),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              SizedBox(width: 4),
              ArCard(title: 'Candi Borobudur', imagePath: 'assets/images/fav-dest-section-candi-borobudur.jpg'),
              SizedBox(width: 12),
              ArCard(title: 'Monas', imagePath: 'assets/images/fav-dest-section-tugu-monas.jpg'),
              SizedBox(width: 12),
              ArCard(title: 'Tugu Jogja', imagePath: 'assets/images/fav-dest-section-tugu-jogja.jpg'),
              SizedBox(width: 12),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/gallery'),
          child: const Text('Lihat Semua Koleksi AR', style: TextStyle(color: kPrimaryColor)),
        ),
      ],
    );
  }
}

class ArCard extends StatelessWidget {
  final String title;
  final String imagePath;
  const ArCard({required this.title, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[300])),
            Container(color: Colors.black26),
            Positioned(
              left: 10,
              bottom: 10,
              child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- VR TORIO ---------------- */

class VRTorioSection extends StatelessWidget {
  const VRTorioSection({super.key});

  static const List<Map<String, String>> _vrItems = [
    {'slug': 'candi-borobudur', 'title': 'Candi Borobudur', 'image': 'assets/images/fav-dest-section-candi-borobudur.jpg', 'location': 'Magelang, Jawa Tengah'},
    {'slug': 'monumen-nasional', 'title': 'Monumen Nasional', 'image': 'assets/images/fav-dest-section-tugu-monas.jpg', 'location': 'Jakarta'},
    {'slug': 'tugu-jogja', 'title': 'Tugu Jogja', 'image': 'assets/images/fav-dest-section-tugu-jogja.jpg', 'location': 'Yogyakarta'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'VR TORIO'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _vrItems.map((it) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/vr/${it['slug']}'),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  height: 110,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(it['image']!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.grey[300])),
                      Container(color: Colors.black38),
                      Positioned(
                        left: 12,
                        top: 14,
                        child: Text(it['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Positioned(
                        left: 12,
                        bottom: 12,
                        child: Text(it['location']!, style: const TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
        ],
      ),
    );
  }
}

/* ---------------- FOOTER ---------------- */

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.facebook, size: 18),
              SizedBox(width: 12),
              Icon(Icons.pinterest, size: 18),
              SizedBox(width: 12),
              Icon(Icons.youtube_searched_for, size: 18),
              SizedBox(width: 12),
              Icon(Icons.camera_alt, size: 18),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: const [
              Text('Help Center'),
              Text('FAQ'),
              Text('About Oratorio'),
              Text('Destinasi'),
              Text('AR Interface'),
              Text('VR Interface'),
            ],
          ),
          const SizedBox(height: 12),
          const Text('© 2025 Oratorio, Inc.', style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}

// ...existing code...