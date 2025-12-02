// lib/widgets/icon_button_scale.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtonScale extends StatefulWidget {
  final String assetPath; // cale către asset (poate fi .svg sau .png/.jpg)
  final VoidCallback? onTap;
  final double size;
  final Color? svgColor; // opțional: culoare pentru SVG (dacă vrei să o suprascrii)

  const IconButtonScale({
    Key? key,
    required this.assetPath,
    this.onTap,
    this.size = 32,
    this.svgColor,
  }) : super(key: key);

  @override
  State<IconButtonScale> createState() => _IconButtonScaleState();
}

class _IconButtonScaleState extends State<IconButtonScale> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) => setState(() => _scale = 0.92);

  // apelăm onTap aici — dar evităm dubluri (în InkWell păstrăm onTap null)
  void _onTapUp(TapUpDetails _) {
    setState(() => _scale = 1.0);
    // rulează callback după animație scurtă pentru UX mai bun
    Future.delayed(const Duration(milliseconds: 60), () {
      widget.onTap?.call();
    });
  }

  void _onTapCancel() => setState(() => _scale = 1.0);

  bool get _isSvg =>
      widget.assetPath.toLowerCase().endsWith('.svg');

  Widget _buildImage() {
    final double s = widget.size;
    final border = BorderRadius.circular(8);

    if (_isSvg) {
      return ClipRRect(
        borderRadius: border,
        child: SizedBox(
          width: s,
          height: s,
          child: SvgPicture.asset(
            widget.assetPath,
            width: s,
            height: s,
            fit: BoxFit.cover,
            color: widget.svgColor,
            placeholderBuilder: (context) => Container(
              width: s,
              height: s,
              color: Colors.grey.shade300,
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: border,
        child: SizedBox(
          width: s,
          height: s,
          child: Image.asset(
            widget.assetPath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: s,
                height: s,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: border,
                ),
                child: const Icon(Icons.error, color: Colors.redAccent),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        // nu apela widget.onTap direct aici (apelăm în _onTapUp)
        onTap: null,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        splashFactory: InkRipple.splashFactory,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: _buildImage(),
        ),
      ),
    );
  }
}
