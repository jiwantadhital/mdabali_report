import 'package:flutter/material.dart';
import 'dart:math' as math;

class CharacterErrorAnimation extends StatefulWidget {
  final double size;
  final Color primaryColor;
  final Color secondaryColor;
  final Color characterColor;
  final VoidCallback? onTap;

  const CharacterErrorAnimation({
    Key? key,
    this.size = 220.0,
    this.primaryColor = Colors.blueGrey,
    this.secondaryColor = Colors.red,
    this.characterColor = Colors.blue,
    this.onTap,
  }) : super(key: key);

  @override
  _CharacterErrorAnimationState createState() => _CharacterErrorAnimationState();
}

class _CharacterErrorAnimationState extends State<CharacterErrorAnimation>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late AnimationController _swayController;
  late AnimationController _blinkController;
  late AnimationController _waveController;
  late AnimationController _scaleController;
  late AnimationController _particleController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _swayAnimation;
  late Animation<double> _blinkAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _particleAnimation;

  bool _isSurprised = false;
  bool _isHovering = false;
  double _dragOffset = 0.0;
  bool _isJumping = false;

  @override
  void initState() {
    super.initState();

    // Bounce animation (up and down movement)
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0.0, end: 12.0).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.easeInOutSine,
      ),
    );

    // Sway animation (side to side movement)
    _swayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _swayAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _swayController,
        curve: Curves.easeInOut,
      ),
    );

    // Blinking animation for the character's eyes
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _blinkAnimation = Tween<double>(begin: 1.0, end: 0.1).animate(
      CurvedAnimation(
        parent: _blinkController,
        curve: Curves.easeInOut,
      ),
    );

    // Wave animation for interactive feedback
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _waveController,
        curve: Curves.elasticOut,
      ),
    );

    // Scale animation for hover and jump
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInOut,
      ),
    );

    // Particle animation for tap effect
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _particleController,
        curve: Curves.easeOut,
      ),
    );

    // Set up periodic blinking
    _setupBlinking();
  }

  void _setupBlinking() {
    Future<void> blinkLoop() async {
      while (mounted) {
        await Future.delayed(Duration(milliseconds: 2500 + math.Random().nextInt(500)));
        if (mounted && !_isSurprised) {
          await _blinkController.forward();
          await _blinkController.reverse();
        }
      }
    }
    blinkLoop();
  }

  void _handleTap() {
    setState(() {
      _isSurprised = true;
    });

    _waveController.forward(from: 0.0).then((_) {
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          setState(() {
            _isSurprised = false;
          });
        }
      });
    });

    _particleController.forward(from: 0.0).then((_) => _particleController.reset());

    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _handleDoubleTap() {
    setState(() {
      _isJumping = true;
    });

    _scaleController.forward().then((_) {
      _scaleController.reverse().then((_) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              _isJumping = false;
            });
          }
        });
      });
    });

    _particleController.forward(from: 0.0).then((_) => _particleController.reset());
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
    if (hovering) {
      _scaleController.forward();
    } else {
      _scaleController.reverse();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta.dx;
      _dragOffset = _dragOffset.clamp(-20.0, 20.0);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() {
      _dragOffset = 0.0;
    });
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _swayController.dispose();
    _blinkController.dispose();
    _waveController.dispose();
    _scaleController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onDoubleTap: _handleDoubleTap,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _bounceController,
            _swayController,
            _blinkController,
            _waveController,
            _scaleController,
            _particleController,
          ]),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                _dragOffset + _waveAnimation.value * 6.0 * math.sin(_waveAnimation.value * 12 * math.pi),
                -_bounceAnimation.value - (_waveAnimation.value * 12.0) - (_isJumping ? 20.0 : 0.0),
              ),
              child: Transform.rotate(
                angle: _swayAnimation.value + (_waveAnimation.value * 0.12 * math.sin(_waveAnimation.value * 10)),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SizedBox(
                    height: widget.size,
                    width: widget.size,
                    child: CustomPaint(
                      painter: CharacterPainter(
                        primaryColor: widget.primaryColor,
                        secondaryColor: widget.secondaryColor,
                        characterColor: widget.characterColor,
                        bounceValue: _bounceController.value,
                        swayValue: _swayController.value,
                        blinkValue: _blinkAnimation.value,
                        waveValue: _waveAnimation.value,
                        isWaving: _waveAnimation.value > 0.1,
                        isSurprised: _isSurprised,
                        isJumping: _isJumping,
                        particleValue: _particleAnimation.value,
                        isHovering: _isHovering,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CharacterPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color characterColor;
  final double bounceValue;
  final double swayValue;
  final double blinkValue;
  final double waveValue;
  final bool isWaving;
  final bool isSurprised;
  final bool isJumping;
  final double particleValue;
  final bool isHovering;

  CharacterPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.characterColor,
    required this.bounceValue,
    required this.swayValue,
    required this.blinkValue,
    required this.waveValue,
    this.isWaving = false,
    this.isSurprised = false,
    this.isJumping = false,
    required this.particleValue,
    this.isHovering = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint signPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    final Paint signBorderPaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final Paint characterPaint = Paint()
      ..color = characterColor
      ..style = PaintingStyle.fill;

    final Paint characterOutlinePaint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;


    final Paint facePaint = Paint()
      ..color = const Color(0xFFFEDCBA)
      ..style = PaintingStyle.fill;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final Paint particlePaint = Paint()
      ..color = Colors.yellow.withOpacity(1.0 - particleValue)
      ..style = PaintingStyle.fill;

    // Calculate dimensions
    final double centerX = size.width / 2;
    final double characterWidth = size.width * 0.4;
    final double signWidth = size.width * 0.7;
    final double signHeight = size.height * 0.35;

    // Draw shadow
    final shadowPath = Path();
    shadowPath.addOval(Rect.fromCircle(
      center: Offset(centerX, size.height * 0.95 + bounceValue * 0.5),
      radius: characterWidth * 0.5 * (1.0 - bounceValue / 30.0),
    ));
    canvas.drawPath(shadowPath, shadowPaint);

    // Draw sign with pulse effect
    final signPulse = 1.0 + 0.05 * math.sin(bounceValue * math.pi * 2);
    final signRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, size.height * 0.35),
        width: signWidth * signPulse,
        height: signHeight * signPulse,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(signRect, signPaint);
    canvas.drawRRect(signRect, signBorderPaint);

    // Draw "503" text on sign
    final textStyle = TextStyle(
      color: secondaryColor,
      fontSize: signHeight * 0.6,
      fontWeight: FontWeight.bold,
    );

    final textSpan = TextSpan(
      text: '503',
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: signWidth,
    );

    textPainter.paint(
      canvas,
      Offset(
        centerX - textPainter.width / 2,
        size.height * 0.35 - textPainter.height / 2,
      ),
    );

    // Draw character body
    final bodyPath = Path();

    // Calculate positions with bounce and jump
    final double headCenterY = size.height * (0.65 - 0.03 * math.sin(bounceValue * math.pi));
    final double armSway = 0.15 * math.sin(swayValue * math.pi * 2 + (isWaving ? waveValue * 2 : 0));

    // Head
    final double headRadius = characterWidth * 0.35;
    final Offset headCenter = Offset(centerX, headCenterY);
    bodyPath.addOval(Rect.fromCircle(center: headCenter, radius: headRadius));
    canvas.drawPath(bodyPath, characterPaint);
    canvas.drawPath(bodyPath, characterOutlinePaint);

    // Face
    final facePath = Path();
    facePath.addOval(
      Rect.fromCircle(
        center: headCenter,
        radius: headRadius * 0.9,
      ),
    );
    canvas.drawPath(facePath, facePaint);

    // Eyes
    final double eyeRadius = headRadius * 0.15;
    final double eyeY = headCenterY - headRadius * 0.1;
    final double eyeDistance = headRadius * 0.4;

    // Left eye
    final leftEyePath = Path();
    leftEyePath.addOval(
      Rect.fromCircle(
        center: Offset(centerX - eyeDistance, eyeY),
        radius: eyeRadius,
      ),
    );
    canvas.drawPath(leftEyePath, Paint()..color = Colors.white);

    // Right eye
    final rightEyePath = Path();
    rightEyePath.addOval(
      Rect.fromCircle(
        center: Offset(centerX + eyeDistance, eyeY),
        radius: eyeRadius,
      ),
    );
    canvas.drawPath(rightEyePath, Paint()..color = Colors.white);

    // Eyelids for blink
    if (blinkValue < 0.9) {
      final eyelidPaint = Paint()..color = facePaint.color;
      final leftEyelidPath = Path();
      leftEyelidPath.addArc(
        Rect.fromCircle(center: Offset(centerX - eyeDistance, eyeY), radius: eyeRadius),
        math.pi,
        math.pi * (1.0 - blinkValue),
      );
      canvas.drawPath(leftEyelidPath, eyelidPaint);

      final rightEyelidPath = Path();
      rightEyelidPath.addArc(
        Rect.fromCircle(center: Offset(centerX + eyeDistance, eyeY), radius: eyeRadius),
        math.pi,
        math.pi * (1.0 - blinkValue),
      );
      canvas.drawPath(rightEyelidPath, eyelidPaint);
    }

    // Pupils
    final double pupilRadius = isSurprised
        ? eyeRadius * 0.7
        : eyeRadius * 0.6 * (blinkValue > 0.9 ? 1.0 : 0.0);
    final double pupilOffsetY = isSurprised ? -eyeRadius * 0.2 : 0;

    canvas.drawCircle(
      Offset(centerX - eyeDistance, eyeY + pupilOffsetY),
      pupilRadius,
      Paint()..color = Colors.black87,
    );
    canvas.drawCircle(
      Offset(centerX + eyeDistance, eyeY + pupilOffsetY),
      pupilRadius,
      Paint()..color = Colors.black87,
    );

    // Expression
    final double expressionAlpha = isSurprised ? 1.0 : (isWaving ? waveValue : 0.0);
    if (isSurprised || isWaving) {
      final mouthPath = Path();
      final double mouthSize = headRadius * 0.25;
      final double mouthY = headCenterY + headRadius * 0.3;
      mouthPath.addOval(
        Rect.fromCircle(
          center: Offset(centerX, mouthY),
          radius: mouthSize,
        ),
      );
      canvas.drawPath(
        mouthPath,
        Paint()
          ..color = Colors.black87.withOpacity(expressionAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );

      final eyebrowPath = Path();
      final double eyebrowY = eyeY - eyeRadius * 1.2;
      eyebrowPath.moveTo(centerX - eyeDistance - eyeRadius * 0.8, eyebrowY);
      eyebrowPath.lineTo(centerX - eyeDistance + eyeRadius * 0.8, eyebrowY - eyeRadius * 0.4);
      eyebrowPath.moveTo(centerX + eyeDistance - eyeRadius * 0.8, eyebrowY - eyeRadius * 0.4);
      eyebrowPath.lineTo(centerX + eyeDistance + eyeRadius * 0.8, eyebrowY);
      canvas.drawPath(
        eyebrowPath,
        Paint()
          ..color = Colors.black87.withOpacity(expressionAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );
    }

    if (!isSurprised || !isWaving) {
      final smilePath = Path();
      final double smileWidth = headRadius * 0.8;
      final double smileY = headCenterY + headRadius * 0.3;
      smilePath.moveTo(centerX - smileWidth / 2, smileY);
      smilePath.quadraticBezierTo(
        centerX,
        smileY + headRadius * 0.25,
        centerX + smileWidth / 2,
        smileY,
      );
      canvas.drawPath(
        smilePath,
        Paint()
          ..color = Colors.black87.withOpacity(1.0 - expressionAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );
    }

    // Arms
    final double shoulderY = headCenterY + headRadius * 1.1;
    final double handY = size.height * 0.4;

    final leftArmPath = Path();
    leftArmPath.moveTo(centerX - characterWidth * 0.3, shoulderY);
    leftArmPath.quadraticBezierTo(
      centerX - characterWidth * (0.4 + armSway),
      (shoulderY + handY) / 2,
      centerX - signWidth * 0.4,
      handY,
    );
    canvas.drawPath(
      leftArmPath,
      Paint()
        ..color = characterColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = characterWidth * 0.12,
    );
    canvas.drawPath(leftArmPath, characterOutlinePaint);

    final rightArmPath = Path();
    rightArmPath.moveTo(centerX + characterWidth * 0.3, shoulderY);
    rightArmPath.quadraticBezierTo(
      centerX + characterWidth * (0.4 - armSway + (isWaving ? waveValue * 0.2 : 0)),
      (shoulderY + handY) / 2,
      centerX + signWidth * 0.4,
      handY,
    );
    canvas.drawPath(
      rightArmPath,
      Paint()
        ..color = characterColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = characterWidth * 0.12,
    );
    canvas.drawPath(rightArmPath, characterOutlinePaint);

    // Body
    final bodyBottomPath = Path();
    bodyBottomPath.moveTo(centerX - characterWidth * 0.3, shoulderY);
    bodyBottomPath.lineTo(centerX + characterWidth * 0.3, shoulderY);
    bodyBottomPath.lineTo(centerX + characterWidth * 0.2, size.height * 0.9);
    bodyBottomPath.lineTo(centerX - characterWidth * 0.2, size.height * 0.9);
    bodyBottomPath.close();
    canvas.drawPath(bodyBottomPath, characterPaint);
    canvas.drawPath(bodyBottomPath, characterOutlinePaint);

    // Particles
    if (particleValue > 0) {
      final random = math.Random();
      for (int i = 0; i < 8; i++) {
        final double angle = random.nextDouble() * 2 * math.pi;
        final double distance = particleValue * random.nextDouble() * headRadius * 1.5;
        final particleSize = 2.0 + random.nextDouble() * 3.0;
        canvas.drawCircle(
          Offset(
            centerX + math.cos(angle) * distance,
            headCenterY + math.sin(angle) * distance,
          ),
          particleSize * (1.0 - particleValue),
          particlePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CharacterPainter oldDelegate) {
    return oldDelegate.bounceValue != bounceValue ||
        oldDelegate.swayValue != swayValue ||
        oldDelegate.blinkValue != blinkValue ||
        oldDelegate.waveValue != waveValue ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.characterColor != characterColor ||
        oldDelegate.isWaving != isWaving ||
        oldDelegate.isSurprised != isSurprised ||
        oldDelegate.isJumping != isJumping ||
        oldDelegate.particleValue != particleValue ||
        oldDelegate.isHovering != isHovering;
  }
}