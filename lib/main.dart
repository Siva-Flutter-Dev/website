import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const SivaCrafftApp());
}

class SivaCrafftApp extends StatelessWidget {
  const SivaCrafftApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SivaCrafft",
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeKey = GlobalKey();

  final featuresKey = GlobalKey();

  final showcaseKey = GlobalKey();

  final contactKey = GlobalKey();

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            HeaderSection(
              scrollController: scrollController,
              sectionKeys: {
                "home": homeKey,
                "features": featuresKey,
                "showcase": showcaseKey,
                "contact": contactKey,
              },
            ),
            Container(key:homeKey, child: HeroSection()),
            Container(key: featuresKey, child: FeaturesSection()),
            Container(key: showcaseKey, child: ShowcaseSection()),
            Container(
              key: contactKey,
              child: ContactFooterSection(scrollController: scrollController,
                sectionKeys: {
                  "home": homeKey,
                  "features": featuresKey,
                  "showcase": showcaseKey,
                  "contact": contactKey,
                },),
            ), // Footer stays at bottom
          ],
        ),
      ),
    );
  }
}

// ---------------- HEADER ----------------
class HeaderSection extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const HeaderSection({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  // Track hover state for each nav item
  final Map<String, bool> _isHovering = {
    "home": false,
    "features": false,
    "showcase": false,
    "contact": false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(blurRadius: 8, color: Colors.black12),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LOGO
          Row(
            children: [
              const Icon(Icons.flutter_dash_rounded, size: 32, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                "SivaCrafft",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),

          // NAV ITEMS
          Row(
            children: _isHovering.keys.map((section) {
              return _navItem(
                section[0].toUpperCase() + section.substring(1), // Capitalize
                section,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String text, String section) {
    final isHovered = _isHovering[section] ?? false;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering[section] = true),
      onExit: (_) => setState(() => _isHovering[section] = false),
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: () {
            final key = widget.sectionKeys[section];
            if (key != null) {
              Scrollable.ensureVisible(
                key.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isHovered ? Colors.blue.shade600 : Colors.black87,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}



// ---------------- HERO SECTION ----------------

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _rotationAnimation = Tween<double>(begin: -0.1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(-0.2, 0), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff0468d7), Color(0xff009dff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text with slide + fade animation
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MouseRegion(
                    onEnter: (_) => setState(() => _hovered = true),
                    onExit: (_) => setState(() => _hovered = false),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        shadows: _hovered
                            ? [
                          const Shadow(
                              blurRadius: 8,
                              color: Colors.white60,
                              offset: Offset(0, 2))
                        ]
                            : [],
                      ),
                      child: const Text("Build Beautiful Mobile Apps"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "SivaCrafft delivers powerful, fast,\nFlutter-style applications.",
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      const MaterialStatePropertyAll(Colors.white),
                      foregroundColor:
                      const MaterialStatePropertyAll(Color(0xff0468d7)),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                      ),
                      elevation: MaterialStatePropertyAll(8),
                      shadowColor:
                      MaterialStatePropertyAll(Colors.black26),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Animated right side card with flip
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateY(_rotationAnimation.value),
                alignment: Alignment.center,
                child: child,
              );
            },
            child: MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  color: _hovered
                      ? Colors.white.withOpacity(0.3)
                      : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: _hovered
                      ? [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2)
                  ]
                      : [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ---------------- FEATURES ----------------

class FeaturesSection extends StatefulWidget {
  const FeaturesSection({super.key});

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  final PageController _pageController =
  PageController(viewportFraction: 0.33); // Show 3 cards at a time
  int _hoveredIndex = -1;

  final List<Map<String, String>> features = [
    {
      "title": "Flutter",
      "desc": "Powerful cross-platform framework to build beautiful UIs.",
      "logo": "assets/logos/flutter.png"
    },
    {
      "title": "Firebase",
      "desc": "Realtime database, authentication & cloud functions.",
      "logo": "assets/logos/firebase.png"
    },
    {
      "title": "Supabase",
      "desc": "Open-source backend solution for databases & auth.",
      "logo": "assets/logos/supabase.png"
    },
    {
      "title": "Figma",
      "desc": "Design modern, responsive UI/UX before coding.",
      "logo": "assets/logos/figma.png"
    },
    {
      "title": "GitHub",
      "desc": "Version control & collaboration for your projects.",
      "logo": "assets/logos/github.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Our Tools & Features",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),

          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: _pageController,
              itemCount: features.length,
              pageSnapping: true,
              onPageChanged: (index) => setState(() {}),
              itemBuilder: (context, index) {
                final feature = features[index];
                double scale = 0.9;
                if (_pageController.position.haveDimensions) {
                  scale = (_pageController.page! - index).abs() < 1
                      ? 1 - (_pageController.page! - index).abs() * 0.15
                      : 0.9;
                }

                final isHovered = _hoveredIndex == index;

                return MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = -1),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: isHovered ? scale + 0.05 : scale,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: isHovered ? 24 : 16,
                            spreadRadius: isHovered ? 4 : 2,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (feature['logo'] != null)
                            Image.asset(
                              feature['logo']!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.contain,
                            ),
                          const SizedBox(height: 16),
                          Text(
                            feature['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isHovered ? 24 : 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            feature['desc']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// ---------------- SHOWCASE ----------------

class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Column(
        children: [
          const Text(
            "Apps We’ve Built",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 40,
            runSpacing: 40,
            children: const [
              ProjectCard(
                logoPath: "assets/logos/calculator.png",
                title: "Simple Math",
                description:
                "A modern calculator + currency converter + graphing + tags + history + dark/light mode.",
                playStoreUrl:
                "https://play.google.com/store/apps/details?id=io.sivacrafft.calculator",
              ),
              ProjectCard(
                logoPath: "assets/logos/habittracker.png",
                title: "Habit Tracker",
                description:
                "Track daily habits with 7-day statistics, login/signup, and Firebase backend.",
                playStoreUrl:
                "https://play.google.com/store/apps/details?id=io.sivacrafft.habittracker",
              ),
              ProjectCard(
                logoPath: "assets/logos/bonly.png",
                title: "Bonly",
                description:
                "A blog creation app with login/signup, profiles, weekly limits & Supabase backend.",
                playStoreUrl:
                "https://play.google.com/store/apps/details?id=io.sivacrafft.bondly",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String logoPath;
  final String title;
  final String description;
  final String playStoreUrl;

  const ProjectCard({
    super.key,
    required this.logoPath,
    required this.title,
    required this.description,
    required this.playStoreUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isHovered ? 1.05 : 1.0;
    final shadow = _isHovered
        ? [BoxShadow(blurRadius: 20, color: Colors.black26, offset: Offset(0, 10))]
        : [BoxShadow(blurRadius: 16, color: Colors.black12)];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.playStoreUrl)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: shadow,
          ),
          transform: Matrix4.identity()..scale(scale),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.logoPath,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: _isHovered
                    ? (Matrix4.identity()..scale(1.05))
                    : Matrix4.identity(),
                child: ElevatedButton(
                  onPressed: () => launchUrl(Uri.parse(widget.playStoreUrl)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    "View on Play Store",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// ---------------- CONTACT ----------------

class ContactFooterSection extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const ContactFooterSection({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<ContactFooterSection> createState() => _ContactFooterSectionState();
}

class _ContactFooterSectionState extends State<ContactFooterSection>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController =
  TextEditingController(text: "sivacrafft@gmail.com");
  final _messageController = TextEditingController();
  bool _hoverSubmit = false;

  late AnimationController _footerAnimationController;
  late Animation<Offset> _footerOffsetAnimation;
  late Animation<double> _footerFadeAnimation;

  @override
  void initState() {
    super.initState();
    _footerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _footerOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _footerAnimationController,
      curve: Curves.easeOut,
    ));

    _footerFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _footerAnimationController,
        curve: Curves.easeIn,
      ),
    );

    _footerAnimationController.forward();
  }

  @override
  void dispose() {
    _footerAnimationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff0468d7), Color(0xff009dff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // ---------------- CONTACT FORM ----------------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contact Us",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Have a project or just want to say hi? Send us a message!",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Wrap(
                    runSpacing: 20,
                    spacing: 20,
                    children: [
                      _buildTextField("Name", _nameController),
                      _buildTextField("Email", _emailController),
                      _buildTextField("Message", _messageController,
                          maxLines: 5, width: 500),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                MouseRegion(
                  onEnter: (_) => setState(() => _hoverSubmit = true),
                  onExit: (_) => setState(() => _hoverSubmit = false),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    transform: _hoverSubmit
                        ? (Matrix4.identity()..scale(1.05))
                        : Matrix4.identity(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        _hoverSubmit ? Colors.white : Colors.blue.shade100,
                        foregroundColor: _hoverSubmit
                            ? Colors.blue.shade700
                            : Colors.blue.shade900,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 18),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Message sent successfully!"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          _nameController.clear();
                          _messageController.clear();
                        }
                      },
                      child: const Text("Send Message"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---------------- FOOTER ----------------
          SlideTransition(
            position: _footerOffsetAnimation,
            child: FadeTransition(
              opacity: _footerFadeAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900.withOpacity(0.9),
                      Colors.blue.shade800.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TOP ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // LOGO + NAME
                        Row(
                          children: [
                            const Icon(Icons.flutter_dash_rounded,
                                size: 40, color: Colors.white),
                            const SizedBox(width: 12),
                            const Text(
                              "SivaCrafft",
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),

                        // QUICK LINKS
                        Row(
                          children: [
                            _footerLink("Home", "home"),
                            _footerLink("Features", "features"),
                            _footerLink("Showcase", "showcase"),
                            _footerLink("Contact", "contact"),
                          ],
                        ),

                        // SOCIAL ICONS
                        Row(
                          children: [
                            _socialIcon(Icons.link,
                                "https://sivacrafft.io"),
                            _socialIcon(Icons.code,
                                "https://www.linkedin.com/in/siva-crafft-733692391/"),
                            _socialIcon(Icons.android,
                                "https://play.google.com/store/apps/developer?id=SivaCrafft"),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    // COPYRIGHT
                    Divider(color: Colors.white.withOpacity(0.5)),
                    const SizedBox(height: 20),

                    const Text(
                      "© 2025 SivaCrafft. All rights reserved.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, double width = 400}) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (label == "Email" && !value.contains("@")) {
            return 'Enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget _footerLink(String text, String section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: () {
          final key = widget.sectionKeys[section];
          if (key != null) {
            Scrollable.ensureVisible(
              key.currentContext!,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(blurRadius: 6, color: Colors.black12),
            ],
          ),
          child: Icon(icon, size: 22, color: Colors.blue.shade700),
        ),
      ),
    );
  }
}


