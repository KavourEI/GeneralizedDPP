import 'package:flutter/material.dart';
import 'package:generalized_dpp/data/notifiers.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavbarWidget>{
  int _selectedPageIndex = 0;

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.line_style_sharp,
    Icons.settings,
    Icons.person_outline_sharp
  ];

  @override
  Widget build(BuildContext context) {
    double iconWidth = MediaQuery.of(context).size.width / _icons.length;
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: Size(double.infinity, 70),
            painter: NotchedPainter(
              selectedIndex: _selectedPageIndex,
              iconCount: _icons.length,
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_icons.length, (index) {
                bool isSelected = index == _selectedPageIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPageIndex = index;
                    });
                    selectedPageNotifier.value = index;
                  },
                  child: Container(
                    width: iconWidth,
                    height: 70,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Rising green circle when selected
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          top: isSelected ? -20 : 15,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: isSelected ? 50 : 0,
                            height: isSelected ? 90 : 0,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              _icons[index],
                              color: Colors.black,
                            ),
                          ),
                        ),

                        // White icon when not selected
                        if (!isSelected)
                          Icon(
                            _icons[index],
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

        ],
      ),
    );
    
  }
}


class NotchedPainter extends CustomPainter {
  final int selectedIndex;
  final int iconCount;

  NotchedPainter({required this.selectedIndex, required this.iconCount});

  @override
void paint(Canvas canvas, Size size) {
  final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  final path = Path();

  double width = size.width;
  double height = size.height;
  double notchWidth = 100;
  double notchDepth = 40; // how deep the notch is
  double segmentWidth = width / iconCount;
  double centerX = segmentWidth * selectedIndex + segmentWidth / 2;

  path.moveTo(0, 0);

  // Left side before notch
  path.lineTo(centerX - notchWidth / 2, 0);

  // Smooth, deep cubic Bezier notch
  path.cubicTo(
    centerX - notchWidth / 4, 0, // control point 1
    centerX - notchWidth / 4, notchDepth, // control point 2
    centerX, notchDepth, // destination
  );
  path.cubicTo(
    centerX + notchWidth / 4, notchDepth, // control point 1
    centerX + notchWidth / 4, 0, // control point 2
    centerX + notchWidth / 2, 0, // destination
  );

  // Right side
  path.lineTo(width, 0);
  path.lineTo(width, height);
  path.lineTo(0, height);
  path.close();

  canvas.drawPath(path, paint);
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
