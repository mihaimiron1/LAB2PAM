import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gym_details_screen.dart';
import 'theme.dart';

class Program {
  const Program({
    required this.title,
    required this.category,
    required this.image,
    this.imageAlignment = Alignment.center,
    this.isPro = false,
  });

  final String title;
  final String category;
  final String image;
  final Alignment imageAlignment;
  final bool isPro;
}

const categories = ['All Type', 'Pilates', 'Cardio', 'Boxing', 'Yoga'];

const programs = [
  Program(
    title: 'Yoga',
    category: 'Yoga',
    image: 'assets/images/program_yoga.jpg',
  ),
  Program(
    title: 'Arm\nStrengthening',
    category: 'Boxing',
    image: 'assets/images/program_arm.jpg',
    imageAlignment: Alignment(-0.49, 0),
    isPro: true,
  ),
];

const _weekdays = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
];

const _months = [
  'January', 'February', 'March', 'April', 'May', 'June', 'July',
  'August', 'September', 'October', 'November', 'December',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All Type';

  String get todayText {
    final now = DateTime.now();
    return '${_weekdays[now.weekday - 1]}, ${now.day} ${_months[now.month - 1]}';
  }

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 18) return 'Good Afternoon';
    return 'Good Evening';
  }

  void openDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GymDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visiblePrograms = selectedCategory == 'All Type'
        ? programs
        : programs.where((p) => p.category == selectedCategory).toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todayText,
                          style: textStyle(14, FontWeight.w400, AppColors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          greeting,
                          style: textStyle(18, FontWeight.w700, AppColors.dark,
                              height: 1.4, spacing: 0),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/bell_button.svg',
                      width: 48,
                      height: 48,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 29),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _ChallengeCard(),
              ),
              const SizedBox(height: 24),
              const _SectionTitle('Featured Plan'),
              const SizedBox(height: 16),
              SizedBox(
                height: 144,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: 2,
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemBuilder: (_, _) => _FeaturedCard(onStart: openDetails),
                ),
              ),
              const SizedBox(height: 24),
              const _SectionTitle('Workout Programs'),
              const SizedBox(height: 16),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return _CategoryChip(
                      label: category,
                      selected: category == selectedCategory,
                      onTap: () => setState(() => selectedCategory = category),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: visiblePrograms.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'No programs in this category',
                          textAlign: TextAlign.center,
                          style: textStyle(14, FontWeight.w400, AppColors.grey),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 184,
                        ),
                        itemCount: visiblePrograms.length,
                        itemBuilder: (_, index) => _ProgramCard(
                          program: visiblePrograms[index],
                          onTap: openDetails,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              title,
              style: textStyle(18, FontWeight.w600, AppColors.dark, spacing: 0),
            ),
          ),
          Text(
            'See All',
            style: textStyle(14, FontWeight.w600, AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today’s Challenge',
                style: textStyle(14, FontWeight.w400, AppColors.grey300),
              ),
              const SizedBox(height: 4),
              Text(
                'Running',
                style: textStyle(18, FontWeight.w700, Colors.white,
                    height: 1.4, spacing: 0),
              ),
            ],
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/progress_ring.svg',
                  width: 50,
                  height: 50,
                ),
                Text(
                  '15/20',
                  style: textStyle(12, FontWeight.w500, Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final white12 = textStyle(12, FontWeight.w400, Colors.white);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 296,
        height: 144,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imaginea e decupată la fel ca în Figma (115.5% x 158%).
            Positioned(
              left: 0,
              top: 0.5,
              width: 296 * 1.155,
              height: 144 * 1.58,
              child: Image.asset(
                'assets/images/featured.jpg',
                fit: BoxFit.cover,
                cacheWidth: 1200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Massive Upper Body',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle(18, FontWeight.w700, Colors.white,
                            height: 1.4, spacing: 0),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/barbell.svg',
                              width: 16, height: 16),
                          const SizedBox(width: 4),
                          Text('5 week', style: white12),
                          const SizedBox(width: 8),
                          SvgPicture.asset('assets/icons/dot.svg',
                              width: 4, height: 4),
                          const SizedBox(width: 8),
                          Text('4x/week', style: white12),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onStart,
                    child: Container(
                      height: 32,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F0D0D12),
                            offset: Offset(0, 1),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        widthFactor: 1,
                        child: Text(
                          'Start Now',
                          style: textStyle(12, FontWeight.w600, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: textStyle(
            14,
            FontWeight.w500,
            selected ? Colors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  const _ProgramCard({required this.program, required this.onTap});

  final Program program;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              program.image,
              fit: BoxFit.cover,
              alignment: program.imageAlignment,
              cacheWidth: 900,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xCC000000)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (program.isPro)
                    const Align(
                      alignment: Alignment.centerRight,
                      child: _ProBadge(),
                    ),
                  const Spacer(),
                  Text(
                    program.title,
                    style: textStyle(16, FontWeight.w600, Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ProgramStat(icon: 'flame', label: '210 kcl'),
                      _ProgramStat(icon: 'clock', label: '120 min'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/crown.svg', width: 14, height: 14),
          const SizedBox(width: 3),
          Text('Pro', style: textStyle(12, FontWeight.w500, AppColors.primary)),
        ],
      ),
    );
  }
}

class _ProgramStat extends StatelessWidget {
  const _ProgramStat({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset('assets/icons/$icon.svg', width: 12, height: 12),
        const SizedBox(width: 3),
        Text(label, style: textStyle(11, FontWeight.w600, AppColors.grey200)),
      ],
    );
  }
}
