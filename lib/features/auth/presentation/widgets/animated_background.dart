import 'package:flutter/material.dart';
import '../../../../core/config/theme_config.dart';

/// Fondo animado moderno con gradientes y formas
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Gradiente base
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ThemeConfig.blanco,
                ThemeConfig.rojo.withValues(alpha: 0.03),
                ThemeConfig.mostaza.withValues(alpha: 0.05),
              ],
            ),
          ),
        ),

        // Círculos animados
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                // Círculo superior derecho
                Positioned(
                  top: -size.height * 0.1 +
                      (20 * _controller.value *
                          (1 + 0.3 * (1 - _controller.value))),
                  right: -size.width * 0.2,
                  child: Container(
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ThemeConfig.rojo.withValues(alpha: 0.08),
                          ThemeConfig.rojo.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),

                // Círculo inferior izquierdo
                Positioned(
                  bottom: -size.height * 0.15 -
                      (30 * _controller.value *
                          (1 + 0.2 * _controller.value)),
                  left: -size.width * 0.15,
                  child: Container(
                    width: size.width * 0.5,
                    height: size.width * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ThemeConfig.mostaza.withValues(alpha: 0.1),
                          ThemeConfig.mostaza.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),

                // Círculo central flotante
                Positioned(
                  top: size.height * 0.4 +
                      (15 * (1 - _controller.value.abs())),
                  left: size.width * 0.2,
                  child: Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ThemeConfig.gris.withValues(alpha: 0.03),
                          ThemeConfig.gris.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
