import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/bloc/sms_summary_bloc/bloc/sms_summary_bloc.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_snackbar.dart';
import 'package:mdabali_report/view/extracted_widgets/custom_text.dart';
import 'package:mdabali_report/view/extracted_widgets/service_error_animation.dart'; // Update with your actual import

class ServiceUnavailablePage extends StatelessWidget {
  const ServiceUnavailablePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<SmsSummaryBloc, SmsSummaryState>(
      listener: (context, state) {
        if (state is SmsSummaryError) {
          CustomSnackbar(
                  title: 'Service unavailable',
                  message: 'Still no Service found',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: colorScheme.surfaceContainer,
                  textColor: colorScheme.secondary)
              .show();
        }
        if (state is SmsSummaryLoaded) {
          Get.back();
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Character holding 503 sign animation
                  Center(
                    child: CharacterErrorAnimation(
                      size: 280,
                      primaryColor: colorScheme.surfaceContainerHighest,
                      secondaryColor: colorScheme.error,
                      characterColor: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // // Title
                  // CustomText(text: 'Service Unavailable',
                  // weight: FontWeight.bold,
                  // color: colorScheme.primary,
                  // textAlign: TextAlign.center,
                  // fontSize: 24,
                  // ),

                  // const SizedBox(height: 16),

                  // Message
                  CustomText(
                    text:
                        'Our servers are currently under maintenance or experiencing high traffic. Please try again later.',
                    textAlign: TextAlign.center,
                    color: colorScheme.onSurface,
                    fontSize: 16,
                  ),

                  const SizedBox(height: 40),

                  // Retry button with animation
                  _AnimatedRetryButton(onPressed: () {
                    context.read<SmsSummaryBloc>().add(FetchSmsSummary());
                  }),

                  const SizedBox(height: 16),

                  // // Contact support button
                  // TextButton.icon(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.support_agent),
                  //     label: CustomText(
                  //       text: 'Contact Support',
                  //       fontSize: 16,
                  //       color: colorScheme.primary,
                  //     )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedRetryButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const _AnimatedRetryButton({this.onPressed});

  @override
  _AnimatedRetryButtonState createState() => _AnimatedRetryButtonState();
}

class _AnimatedRetryButtonState extends State<_AnimatedRetryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool isHovering) {
    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: _isHovering ? 4 : 2,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh),
                  SizedBox(width: 8),
                  Text(
                    'Retry Connection',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
