import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'theme.dart';

const _shortDescription =
    'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros '
    'laoreet quam sollicitudin. Duis non eu habitant id vel nisi eget amet '
    'tellus... ';

const _fullDescription =
    'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros '
    'laoreet quam sollicitudin. Duis non eu habitant id vel nisi eget amet '
    'tellus. Viverra mauris in aliquam sem fringilla ut morbi tincidunt. '
    'Egestas integer eget aliquet nibh praesent tristique magna sit amet. ';

class GymDetailsScreen extends StatefulWidget {
  const GymDetailsScreen({super.key});

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen> {
  bool expanded = false;

  void reserve() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Reservation confirmed')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/gym.jpg',
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                  cacheWidth: 1200,
                ),
                Positioned(
                  top: topInset + 16,
                  left: 24,
                  right: 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0x80FFFFFF),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/arrow_left.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/dots_vertical.svg',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 14),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star_filled.svg',
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '4.5 ',
                                    style: textStyle(
                                        14, FontWeight.w600, AppColors.dark),
                                  ),
                                  TextSpan(
                                    text: '(1,232 reviews)',
                                    style: textStyle(
                                        14, FontWeight.w400, AppColors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mid City Gym Training',
                          style: textStyle(24, FontWeight.w700, AppColors.dark,
                              height: 1.5, spacing: 0),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'California, New York',
                          style: textStyle(14, FontWeight.w400, AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () => setState(() => expanded = !expanded),
                    child: Text.rich(
                      TextSpan(
                        style: textStyle(14, FontWeight.w400, AppColors.grey),
                        children: [
                          TextSpan(
                            text: expanded
                                ? _fullDescription
                                : _shortDescription,
                          ),
                          TextSpan(
                            text: expanded ? 'Read less' : 'Read more',
                            style: textStyle(
                                14, FontWeight.w500, AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Amenities',
                    style: textStyle(18, FontWeight.w600, AppColors.dark,
                        spacing: 0),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: _Amenity(icon: 'ironing_steam', label: 'Showers'),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _Amenity(icon: 'layout_list', label: 'Lockers'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: _Amenity(icon: 'wifi', label: 'Free Wi-fi'),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _Amenity(icon: 'wifi', label: 'Free Wi-fi'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(25, 16, 25, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, -10),
                blurRadius: 50,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total',
                        style: textStyle(14, FontWeight.w500, AppColors.grey),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: r'$69.00 ',
                              style: textStyle(
                                  18, FontWeight.w700, AppColors.dark,
                                  height: 1.4, spacing: 0),
                            ),
                            TextSpan(
                              text: '/week',
                              style: textStyle(
                                  14, FontWeight.w500, AppColors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: reserve,
                    child: Container(
                      height: 52,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0F0D0D12),
                            offset: Offset(0, 1),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        'Reserve',
                        style: textStyle(16, FontWeight.w600, Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Amenity extends StatelessWidget {
  const _Amenity({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/$icon.svg', width: 20, height: 20),
          const SizedBox(width: 8),
          Text(label, style: textStyle(14, FontWeight.w400, AppColors.grey)),
        ],
      ),
    );
  }
}
