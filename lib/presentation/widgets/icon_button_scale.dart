import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtonScale extends StatefulWidget {
  final String assetPath;
  final VoidCallback? onTap;
  final double size;      // Dimensiunea totală a butonului (containerul)
  final double iconSize;  // Dimensiunea iconiței din interior
  final Color? svgColor;

  const IconButtonScale({
    Key? key,
    required this.assetPath,
    this.onTap,
    this.size = 44,       // Standardul pentru touch targets e ~44px
    this.iconSize = 24,   // Iconita standard e 24px
    this.svgColor,
  }) : super(key: key);

  @override
  State<IconButtonScale> createState() => _IconButtonScaleState();
}

class _IconButtonScaleState extends State<IconButtonScale> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) => setState(() => _scale = 0.90);

  void _onTapUp(TapUpDetails _) {
    setState(() => _scale = 1.0);
    Future.delayed(const Duration(milliseconds: 80), () {
      widget.onTap?.call();
    });
  }

  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    // Verificăm dacă e SVG
    final bool isSvg = widget.assetPath.toLowerCase().endsWith('.svg');
    final borderRadius = BorderRadius.circular(12); // Rotunjire ca în Figma

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: Colors.white, // Fundal alb
            borderRadius: borderRadius,
            border: Border.all(
              color: const Color(0xFFE5E5E5), // Griul deschis din Figma
              width: 1.5, // Grosimea liniei
            ),
            // Opțional: o mică umbră fină dacă vrei să iasă în evidență
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.05),
            //     blurRadius: 4,
            //     offset: const Offset(0, 2),
            //   )
            // ],
          ),
          // Centram si redimensionam iconita corect
          child: Center(
            child: isSvg
                ? SvgPicture.asset(
              widget.assetPath,
              width: widget.iconSize,
              height: widget.iconSize,
              // Folosim scaleDown ca să nu se deformeze
              fit: BoxFit.scaleDown,
              color: widget.svgColor ?? const Color(0xFF191919),
            )
                : Image.asset(
              widget.assetPath,
              width: widget.iconSize,
              height: widget.iconSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}