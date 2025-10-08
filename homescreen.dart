import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/profile_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  const HomeScreen({
    super.key,
    required this.onToggleTheme,
    required this.themeMode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final List<Project> projects;
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    projects = [
      Project(
        title: 'Clinic Appointment Management System',
        description:
            'A system built using Java and Firebase that enables patients to schedule appointments and doctors to manage their schedules. It simplifies the booking process and reduces manual errors in record keeping.',
        githubUrl: 'https://github.com/yourusername/language-learning',
      ),
      Project(
        title: 'Inventory Tracking System',
        description:
            'A database-driven project made with C# and SQL Server for managing product inventory, stock levels, and supplier details. It ensures accurate tracking and real-time updates for efficient business operations.',
        githubUrl: 'https://github.com/yourusername/discrete-math',
      ),
      Project(
        title: 'E-Learning Mobile App',
        description:
            ' A cross-platform mobile app built with Flutter and Firebase that provides online lessons, quizzes, and progress tracking for students. It offers a user-friendly design with offline access for continuous learning.',
        githubUrl: 'https://github.com/yourusername/reactjs-presentation',
      ),
    ];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  EdgeInsets contentPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 900)
      return const EdgeInsets.symmetric(horizontal: 80, vertical: 40);
    if (width > 600)
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 30);
    return const EdgeInsets.symmetric(horizontal: 20, vertical: 20);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.themeMode == ThemeMode.dark
                ? [Colors.grey.shade900, Colors.black]
                : [
                    const Color.fromARGB(255, 196, 24, 227),
                    const Color.fromARGB(255, 240, 79, 146),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SingleChildScrollView(
              padding: contentPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // top bar with title and toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Portfolio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            tooltip: 'Toggle theme',
                            onPressed: widget.onToggleTheme,
                            icon: Icon(
                              widget.themeMode == ThemeMode.dark
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Layout: On wide screens show two-column layout; on mobile single column
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final wide = constraints.maxWidth > 900;
                      return wide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // left column (profile + skills)
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      ProfileSection(),
                                      const SizedBox(height: 20),
                                      const AboutSection(),
                                      const SizedBox(height: 20),
                                      const SkillsSection(),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 30),

                                // right column (projects + contact)
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    children: [
                                      ProjectsSection(projects: projects),
                                      const SizedBox(height: 20),
                                      const ContactSection(),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                ProfileSection(),
                                const SizedBox(height: 16),
                                const AboutSection(),
                                const SizedBox(height: 16),
                                const SkillsSection(),
                                const SizedBox(height: 16),
                                ProjectsSection(projects: projects),
                                const SizedBox(height: 16),
                                const ContactSection(),
                              ],
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
