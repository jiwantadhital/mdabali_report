import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdabali_report/bloc/member_limit_bloc/bloc/member_limit_bloc.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/sms_page/sms_page.dart';

class MdabaliPage extends StatefulWidget {
  const MdabaliPage({super.key});

  @override
  State<MdabaliPage> createState() => _MdabaliPageState();
}

class _MdabaliPageState extends State<MdabaliPage> {
  @override
  void initState() {
    context.read<MemberLimitBloc>().add(FetchMemberLimit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        context.read<MemberLimitBloc>().add(FetchMemberLimit());
        return Future.delayed(const Duration(milliseconds: 1200));
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<MemberLimitBloc, MemberLimitState>(
                  builder: (context, state) {
                if (state is MemberLimitLoading) {
                  return ShimmerTopupCard(
                    context: context,
                  );
                } else if (state is MemberLimitLoaded) {
                  final memberData = state.memeberLimitModel.data;
                  final remainingLimit = memberData!.memberLimit! -
                      memberData.verifiedUser!.toInt();
                  return buildMdabaliCard(
                      membersLimit: memberData.memberLimit.toString(),
                      verifiedUser: memberData.verifiedUser.toString(),
                      closedUser: memberData.closedUser.toString(),
                      totalUser: memberData.totalUser.toString(),
                      context: context,
                      remainingLimit: remainingLimit.toString());
                } else if (state is MemberLimitError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                            size: 24),
                        const SizedBox(height: 8),
                        CustomText(
                          text: state.error,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 16,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                            size: 24),
                        const SizedBox(height: 8),
                        CustomText(
                          text:
                              'Failed to load data, Please refresh to load data.',
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 16,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMdabaliCard({
    required String membersLimit,
    required String verifiedUser,
    required String closedUser,
    required String totalUser,
    required String remainingLimit,
    required BuildContext context,
  }) {
    var colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Stack(
        children: [
          // Main Card with Glassmorphism Effect
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  width: 1.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  children: [
                    Column(
                      children: [
                        buildMetricRow(
                          'Members Limit',
                          membersLimit,
                          Icons.card_membership,
                          colorScheme.onSurface,
                          iconBgColor: Colors.red.withValues(alpha: 0.5),
                        ),
                        buildDivider(),
                        buildMetricRow(
                          'Verified Users',
                          verifiedUser,
                          Icons.verified_user_rounded,
                          colorScheme.onSurface,
                          iconBgColor:
                              Colors.greenAccent.withValues(alpha: 0.5),
                        ),
                        buildDivider(),
                        buildMetricRow(
                          'Closed Users',
                          closedUser,
                          Icons.person_off_rounded,
                          colorScheme.onSurface,
                          iconBgColor:
                              Colors.deepOrangeAccent.withValues(alpha: 0.5),
                        ),
                        buildDivider(),
                        buildMetricRow(
                          'Total Users',
                          totalUser,
                          Icons.people_rounded,
                          colorScheme.onSurface,
                          iconBgColor:
                              Colors.amberAccent.withValues(alpha: 0.5),
                          isLast: true,
                        ),
                        buildDivider(),
                        buildMetricRow(
                          'Remaining Limit',
                          remainingLimit,
                          Icons.linear_scale_outlined,
                          colorScheme.onSurface,
                          iconBgColor: Colors.cyan.withValues(alpha: 0.5),
                          isLast: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Decorative bubble circle
          Positioned(
            top: 10,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withValues(alpha: 0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMetricRow(
    String label,
    String value,
    IconData icon,
    Color color, {
    bool isLast = false,
    Color? iconBgColor,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                // Icon with Custom Background
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBgColor ?? Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 14),
                // Label Text
                Expanded(
                  child: CustomText(
                    text: label,
                    fontSize: 15,
                    weight: FontWeight.w500,
                    color: color.withValues(alpha: 0.9),
                  ),
                )
              ],
            ),
          ),
          // Value with Highlight
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: CustomText(
                text: value.toString(),
                fontSize: 16,
                weight: FontWeight.bold,
                color: color,
                letterSpacing: 0.5,
              )),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withValues(alpha: 0),
              Colors.blue.withValues(alpha: 0.5),
              Colors.blue.withValues(alpha: 0),
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
