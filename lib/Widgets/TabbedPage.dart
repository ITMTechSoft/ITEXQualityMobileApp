import 'package:flutter/material.dart';

class TabLayout extends StatelessWidget {
  final List<TabElement> elements;
  final int currentIndex;
  final Function(int) onTabTap;

  const TabLayout({
    Key? key,
    required this.elements,
    required this.currentIndex,
    required this.onTabTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < elements.length; i++)
          Expanded(
            child: InkWell(
              onTap: () => onTabTap(i),
              child: Container(
                decoration: BoxDecoration(
                  color: i == currentIndex ? Colors.blue : Colors.transparent,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(elements[i].icon),
                    const SizedBox(width: 8),
                    Text(elements[i].text),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class TabElement {
  final IconData icon;
  final String text;

  const TabElement({
    required this.icon,
    required this.text,
  });
}



/*
how to call

final tabElements = [
  TabElement(icon: Icons.home, text: 'Home'),
  TabElement(icon: Icons.explore, text: 'Explore'),
  TabElement(icon: Icons.settings, text: 'Settings'),
];

int _currentIndex = 0;

void _handleTabTap(int index) {
  setState(() {
    _currentIndex = index;
  });

  // Perform any additional actions here, based on the selected index.
  switch (index) {
    case 0:
    // Do something for the first tab.
      break;
    case 1:
    // Do something for the second tab.
      break;
    case 2:
    // Do something for the third tab.
      break;
  }
}
TabLayout(
elements: tabElements,
currentIndex: _currentIndex,
onTabTap: _handleTabTap,
),
*/