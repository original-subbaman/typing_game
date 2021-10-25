import 'package:flutter/material.dart';
import 'dart:math' as math;
class ExpandableFab extends StatefulWidget {
  final bool initialOpen;
  final double distance;
  final List<Widget> children;

  ExpandableFab(
      {@required this.initialOpen,
      @required this.distance,
      @required this.children});

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin{
   AnimationController _controller;
   Animation<double> _expandAnimation;
  bool _open = false;
  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
        ),
      ),
    );
  }
  List<Widget> _buildExpandingActionButtons() {
     final List<Widget> children = [];
     final count = widget.children.length;
     final step = 90.0 / (count - 1);
     for (var i = 0, angleInDegrees = 0.0; i < count; i++, angleInDegrees += step) {
       children.add(
         _ExpandingActionButton(
           directionInDegrees: angleInDegrees,
           maxDistance: widget.distance,
           progress: _expandAnimation,
           child: widget.children[i],
         ),
       );
     }
     return children;
   }
  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {


  final VoidCallback onPressed;
  final Widget icon;


  ActionButton({@required this.onPressed, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      elevation: 4.0,
      child: IconTheme.merge(
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {



  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }

  _ExpandingActionButton(
      {this.directionInDegrees, this.maxDistance, this.progress, this.child});
}

