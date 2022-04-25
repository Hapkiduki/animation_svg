import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({
    Key? key,
    required this.items,
    this.color = Colors.white,
  }) : super(key: key);

  /// The 'String' paths from svg images
  final List<String> items;

  /// Optional color to svg's
  final Color color;

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animation;

  @override
  void initState() {
    super.initState();

    final double _base = .5 / widget.items.length;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animation = List.generate(
      widget.items.length,
      (int index) => TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: .0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
      ]).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval((_base * index).clamp(0, .5),
              (0.5 * (index * _base)).clamp(.5, 1),
              curve: Curves.easeInOut),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('Loading Animation'),
      ),
      body: Center(
        child: AnimatedBuilder(
          builder: (context, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              _animation.length,
              (index) => Transform.translate(
                offset: Offset(0, 10 * _animation[index].value),
                child: SvgPicture.asset(
                  widget.items[index],
                  color: widget.color,
                ),
              ),
            ),
          ),
          animation: _controller,
        ),
      ),
    );
  }
}
