import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../menu/menu_screen.dart';
import '../news_detail/news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  final Color darkBlue = const Color(0xFF06206B);
  final Color red = const Color(0xFFC90000);
  final Color background = Colors.white;

  // ============================================================
  // MOCK NEWS DATA
  // ============================================================

  final List<Map<String, String>> newsItems = [
    {
      'title': 'Birraafi Oromoo!',
      'category': 'Oduu Tibbanaa',
      'date': 'AUG 29, 2026',
      'id': '1',
    },
    {
      'title':
          'Tarsiimoon Barnootaa Bocamee Hojirra Oolaa Jiru Jijjiirama Bu\'uuraa Fidaa Jira.',
      'category': 'Oduu Tibbanaa',
      'date': 'AUG 28, 2026',
      'id': '2',
    },
    {
      'title':
          'Goobeefi Shinooyyee: Faana Ifa Birraa, Calaqqee Nagaafi Bareedina Aadaa Oromoo',
      'category': 'Oduu Tibbanaa',
      'date': 'AUG 27, 2026',
      'id': '3',
    },
    {
      'title':
          'Babalina Dhaabbilee Fayyaa:- Hawaasa Fayya Qabeessa Ta\'e Horachuuf!',
      'category': 'Oduu Tibbanaa',
      'date': 'AUG 26, 2026',
      'id': '4',
    },
    {
      'title': 'Adwaa: Injifannoo Waloo!',
      'category': 'Oduu Tibbanaa',
      'date': 'AUG 25, 2026',
      'id': '5',
    },
  ];

  // ============================================================
  // HERO SLIDER DATA
  // ============================================================

  final List<Map<String, String>> heroSlides = [
    {
      'title': 'Biiroo Kominikeeshinii Oromiyaa irraa odeeffannoo haaraa',
      'category': 'Oduu Tibbanaa',
      'image': 'https://images.unsplash.com/photo-1500534623283-312aade485b7',
    },
    {
      'title': 'Odeeffannoo haaraa Oromiyaa keessatti',
      'category': 'Oduu Tibbanaa 4',
      'image': 'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620',
    },
    {
      'title': 'Meeshaalee kominiikeeshinii haaraa',
      'category': 'Oduu Tibbanaa 5',
      'image': 'https://images.unsplash.com/photo-1516387938699-a93567ec168e',
    },
    {
      'title': 'Tajaajila haaraa Biiroo Kominikeeshinii Oromiyaa',
      'category': 'Oduu Tibbanaa 6',
      'image': 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d',
    },
    {
      'title': 'Misooma Oromiyaa irratti marii',
      'category': 'Oduu Tibbanaa 7',
      'image': 'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4',
    },
    {
      'title': 'Oduu addunyaa Oromiyaa irraa',
      'category': 'Oduu Tibbanaa 8',
      'image': 'https://images.unsplash.com/photo-1522071820081-009f0129c71c',
    },
  ];

  final PageController _heroController = PageController();
  int _currentHeroIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), _autoSlideHero);
  }

  void _autoSlideHero() {
    if (!mounted) return;

    if (_heroController.hasClients) {
      final int nextPage = (_currentHeroIndex + 1) % heroSlides.length;
      _heroController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    Future.delayed(const Duration(seconds: 5), _autoSlideHero);
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar()),
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildHero()),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'Oduu Tibbanaa',
                'Oduu haaraa Biiroo Kominikeeshinii Oromiyaa',
              ),
            ),
            _buildNewsSection(),
            SliverToBoxAdapter(child: _buildOduuDinagdeeSection()),
            SliverToBoxAdapter(child: _buildOduuHawaasummaaSection()),
            SliverToBoxAdapter(child: _buildOduuTeeknoolojiiSection()),
            SliverToBoxAdapter(child: _buildOduuIspoortiiSection()),
            SliverToBoxAdapter(child: _buildOduuNaannooSection()),
            SliverToBoxAdapter(child: _buildOduuAddaaSection()),
            SliverToBoxAdapter(child: _buildVidiyooSection()),
            SliverToBoxAdapter(child: _buildOduuBekamaaSection()),
            SliverToBoxAdapter(child: _buildFooter()),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    final now = DateTime.now();
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    return Container(
      color: darkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${now.day}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '${months[now.month - 1]}\n${now.year}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _socialIcon(Icons.facebook),
                  _socialIcon(Icons.close),
                  _socialIcon(Icons.play_arrow),
                  _socialIcon(Icons.send),
                  _socialIcon(Icons.music_note),
                  _socialIcon(Icons.camera_alt),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Icon(icon, color: Colors.white, size: 21),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 88,
      color: const Color(0xFF171717),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Color(0xFF06206B),
                      size: 35,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'BIIRO KOMINIKEESHINII OROMIYAA\n'
                      'OROMIA COMMUNICATION BUREAU',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _headerButton(Icons.menu, () {
            // Open drawer or navigate to menu
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          }),
          _headerButton(Icons.person_outline, () {
            _showProfile();
          }),
          _headerButton(Icons.search, () {
            _showSearchDialog();
          }),
        ],
      ),
    );
  }

  Widget _headerButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 58,
          height: 88,
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Colors.white12)),
          ),
          child: Icon(icon, color: Colors.white, size: 27),
        ),
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================

  Widget _buildHero() {
    return Container(
      margin: const EdgeInsets.all(12),
      height: 390,
      child: Stack(
        children: [
          PageView.builder(
            controller: _heroController,
            onPageChanged: (index) {
              setState(() {
                _currentHeroIndex = index;
              });
            },
            itemCount: heroSlides.length,
            itemBuilder: (context, index) {
              final slide = heroSlides[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(slide['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          color: red,
                          child: Text(
                            slide['category']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(13),
                          color: Colors.black87,
                          child: Text(
                            slide['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                heroSlides.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentHeroIndex == index ? red : Colors.white54,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 55,
            left: 15,
            child: _heroButton(Icons.chevron_left, () {
              if (_currentHeroIndex > 0) {
                _heroController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }),
          ),
          Positioned(
            bottom: 55,
            left: 78,
            child: _heroButton(Icons.chevron_right, () {
              if (_currentHeroIndex < heroSlides.length - 1) {
                _heroController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _heroButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 50,
        decoration: BoxDecoration(
          color: red,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 25, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NEWS SECTION
  // ============================================================

  Widget _buildNewsSection() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = newsItems[index];
        return _buildNewsCard(item);
      }, childCount: newsItems.length),
    );
  }

  Widget _buildNewsCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(newsId: item['id']!),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 105,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.image, color: Colors.grey, size: 35),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['category']!,
                    style: TextStyle(
                      color: red,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['title']!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 10,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['date']!,
                        style: const TextStyle(color: Colors.grey, fontSize: 9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ODUU DINAGDEE SECTION
  // ============================================================

  Widget _buildOduuDinagdeeSection() {
    final items = [
      {'title': 'Birraafi Oromoo!', 'date': 'HAGAYYA 27, 2018', 'views': '12'},
      {
        'title':
            'Tarsiimoon Barnootaa Bocamee Hojirra Oolaa Jiru Jijjiirama Bu\'uuraa Fidaa Jira.',
        'date': 'HAGAYYA 26, 2018',
        'views': '29',
      },
      {
        'title':
            'Goobeefi Shinooyyee: Faana Ifa Birraa, Calaqqee Nagaafi Bareedina Aadaa Oromoo',
        'date': 'HAGAYYA 25, 2018',
        'views': '480',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Oduu Dinagdee',
            style: TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Oduu Tibbanaa Dinagdee Keenya',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => _buildNewsItemCard(
              item['title']!,
              item['date']!,
              item['views']!,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ODUU HAWAASUMMAA SECTION
  // ============================================================

  Widget _buildOduuHawaasummaaSection() {
    final items = [
      {'title': 'Birraafi Oromoo!', 'date': 'HAGAYYA 27, 2018', 'views': '12'},
      {
        'title':
            'Tarsilimoon Barnootaa Bocamee Hojirra Oolaa Jiru Jijjiirama Bu\'uuraa Fidaa Jira.',
        'date': 'HAGAYYA 26, 2018',
        'views': '29',
      },
      {
        'title':
            'Goobeeff Shinooyyee: Faana Ifa Birraa, Calaqqee Nagaafi Bareedina Aadaa Oromoo',
        'date': 'HAGAYYA 25, 2018',
        'views': '480',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Oduu Hawaasummaa',
            style: TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Oduu Tibbanaa Hawaasummaa Keenya',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => _buildNewsItemCard(
              item['title']!,
              item['date']!,
              item['views']!,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ODUU TEEKNOLOOJII SECTION
  // ============================================================

  Widget _buildOduuTeeknoolojiiSection() {
    final items = [
      {
        'title':
            '"Imalli Dijitaala Itoophiyaa Guddina Damee Dijitaalaa Addunyaan Keessa Jirtuun Dorgomaa Ta\'aa Jira." Obbo Hayiluu Addunyaa.',
        'date': 'BITOOTESSA 17, 2018',
        'views': '672',
      },
      {
        'title':
            'Tajaajilaa Si\'ataafi Ammayya\'aa : Itti Quufinsa Uummataatilif !',
        'date': 'GURAANDHALA 6, 2018',
        'views': '840',
      },
      {
        'title':
            '"Wiirtuun Tajaajila Tokkoffaa (Masob) Qaawwa Mootummaa Fi Ummata Gidduu Jiru Dhiphisuun Itti Quufinsaa Fi Amantaa Ummanni Mootummaa Irraa Qabu Akka Dabalú Gochaa Jira."',
        'date': 'ALA 5, 2018',
        'views': '693',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Oduu Teeknoolojii',
            style: TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Oduu Tibbanaa Teeknoolojii Keenya',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => _buildNewsItemCard(
              item['title']!,
              item['date']!,
              item['views']!,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ODUU ISPOORTII SECTION
  // ============================================================

  Widget _buildOduuIspoortiiSection() {
    final items = [
      {
        'title':
            'Dorgommiin Ispoortii Aadaa Tokkummaa Hawaasaa Cimsuuf Shoora Olaanaa Qaba.',
        'date': 'BITOOTESSA 29, 2018',
        'views': '587',
      },
      {
        'title':
            'Maanchistar Yunaayitid Ammas Injifachuun Leenjisaa Haaraa Maayikeel Kaariik Walitti Aansuun Injifannoo Afur Taasisseera',
        'date': 'AMAJJII 30, 2018',
        'views': '666',
      },
      {
        'title':
            'Arsenaal Daqiqaa 30 Jalqabaa Irratti Goolii Afur Galchuun Wiigan Bira Darbee Waggoota Jaha Booda Yeroo Jalqabaaf Waancaa FA Marsaa Shanaffaa Irra Gaheera.',
        'date': 'AMAJJII 27, 2018',
        'views': '591',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Oduu Ispoortii',
            style: TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Oduu Tibbanaa Ispoortii Keenya',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => _buildNewsItemCard(
              item['title']!,
              item['date']!,
              item['views']!,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ODUU NAANNOO SECTION
  // ============================================================

  Widget _buildOduuNaannooSection() {
    final items = [
      {'title': 'Birraafi Oromoo!', 'date': 'HAGAYYA 27, 2018', 'views': '12'},
      {
        'title':
            'Tarsiimoon Barnootaa Bocamee Hojirra Oolaa Jiru Jijjiirama Bu\'uuraa Fidaa Jira.',
        'date': 'HAGAYYA 26, 2018',
        'views': '29',
      },
      {
        'title':
            'Goobeeff Shinoooyyee: Faana Ifa Birraa, Calaqqee Nagaaifi Bareedina Aadaa Oromoo',
        'date': 'HAGAYYA 25, 2018',
        'views': '480',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Oduu Naannoo',
            style: TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Oduu Tibbanaa Naannoo Keenya',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => _buildNewsItemCard(
              item['title']!,
              item['date']!,
              item['views']!,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ODUU ADDAA SECTION
  // ============================================================

  Widget _buildOduuAddaaSection() {
    final items = [
      {
        'title':
            'Goobeeff Shinooyyee: Faana Ifa Birraa, Calaqqee Nagaafi Bareedina Aadaa Oromoo',
        'date': 'HAGAYYA 25, 2018',
        'views': '480',
      },
      {
        'title':
            'Babalina Dhaabbilee Fayyaa:- Hawaasa Fayya Qabeessa Ta\'e Horachuuf!',
        'date': 'HAGAYYA 21, 2018',
        'views': '1559',
      },
      {
        'title': 'Tajaajilli Lammummaa Humna Misooma Walooti!',
        'date': 'HAGAYYA 15, 2018',
        'views': '84',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Oduu Addaa',
            style: TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Oduu Tibbanaa Addaa Keenya',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => _buildNewsItemCard(
              item['title']!,
              item['date']!,
              item['views']!,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VIDIYOO SECTION
  // ============================================================

  Widget _buildVidiyooSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vidiyoo',
            style: TextStyle(
              color: Color(0xFF55B7F0),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 90, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          _buildVideoItem(
            'Aodooleessa 30, 2018',
            'Haa onu!',
            'Duula dhaabbii Bigiltun Asharaa Magariisaa',
            'Hoggansaafi Hojjettoota EKO.',
          ),
          _buildVideoItem(
            'Aodooleessa 27, 2018',
            '2018 bara ilka ime Riiva konaa',
            '',
            '',
          ),
        ],
      ),
    );
  }

  Widget _buildVideoItem(
    String date,
    String title,
    String subtitle,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(color: Colors.grey[400]),
                const Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ODUU BEKAMAA SECTION
  // ============================================================

  Widget _buildOduuBekamaaSection() {
    final items = [
      {
        'title':
            'Babalina Dhaabbilee Fayyaa:- Hawaasa Fayya Qabeessa Ta\'e Horachuuf!',
        'date': 'HAGAYYA 21, 2018',
        'views': '1559',
      },
      {
        'title': 'Adwaa: Injifannoo Waloo!',
        'date': 'GURAANDHALA 20, 2018',
        'views': '1261',
      },
      {
        'title':
            'Tajaaqilaa Si\'ataafi Ammayya\'aa : Itti Quufinsa Uummataatif !',
        'date': 'GURAANDHALA 6, 2018',
        'views': '840',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ODUU BEKAMAA',
                style: TextStyle(
                  color: Color(0xFF55B7F0),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ODUU HAARAA',
                style: TextStyle(
                  color: red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: Colors.grey[300],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(width: 120, height: 2, color: red),
            ),
          ),
          const SizedBox(height: 15),
          ...items.map(
            (item) => _buildNewsItemCard(
              item['title']!,
              item['date']!,
              item['views']!,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gaazeexaa Torbanii Kallacha Oromiyaa',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.grey, size: 50),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Mallattoo Beekamaa',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildCategoryChip('SIYAASA'),
                    _buildCategoryChip('HAWAASUMMAA'),
                    _buildCategoryChip('DINAGDEE'),
                    _buildCategoryChip('ISPOORTII'),
                    _buildCategoryChip('TEEKNOOLOOJII'),
                    _buildCategoryChip('NAANNOO'),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: red,
                  child: const Center(
                    child: Text(
                      'ODUU ADDAA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NEWS ITEM CARD
  // ============================================================

  Widget _buildNewsItemCard(String title, String date, String views) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, color: Colors.grey, size: 14),
              const SizedBox(width: 4),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
              if (views.isNotEmpty) ...[
                const SizedBox(width: 16),
                const Icon(Icons.remove_red_eye, color: Colors.grey, size: 14),
                const SizedBox(width: 4),
                Text(
                  views,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY CHIP
  // ============================================================

  Widget _buildCategoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE
  // ============================================================

  void _showProfile() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF222222),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person, color: Colors.white, size: 65),
              const SizedBox(height: 15),
              const Text(
                'Baga Nagaan Dhuftan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: red),
                  child: const Text(
                    'SEENI',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'GALMAAI',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D1D1D),
        title: const Text('Search', style: TextStyle(color: Colors.white)),
        content: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search news...',
            hintStyle: const TextStyle(color: Colors.white54),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white24),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF55B7F0)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Handle search
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: red),
            child: const Text('Search', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.only(top: 35),
      padding: const EdgeInsets.fromLTRB(20, 35, 20, 30),
      color: darkBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Biiroo Kominikeeshinii Oromiyaa',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Kominikeeshinii bu\'aa qabeessa fi sirrii Oromiyaa keessatti haa mirkanaa\'u.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 20),
          const Text(
            '📍 Finfinnee, Oromiyaa\n☎ +251 11 555 0000\n✉ info@oromiacommunication.gov.et',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.9),
          ),
          const SizedBox(height: 25),
          const Divider(color: Colors.white24),
          const SizedBox(height: 15),
          const Text(
            '© 2026 Biiroo Kominikeeshinii Oromiyaa',
            style: TextStyle(color: Colors.white60, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
