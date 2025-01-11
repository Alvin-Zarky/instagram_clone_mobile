import "package:flutter/material.dart";

class BoxBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTapNavigation;
  const BoxBottomNavigationBar(
      {Key? key, required this.currentIndex, required this.onTapNavigation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTapNavigation,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: currentIndex == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: ''),
        BottomNavigationBarItem(
          icon: currentIndex == 1
              ? const Icon(Icons.search)
              : const Icon(Icons.search_outlined),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: currentIndex == 2
                ? const Icon(Icons.add_circle)
                : const Icon(Icons.add_circle_outline),
            label: ''),
        BottomNavigationBarItem(
            icon: currentIndex == 3
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
            label: ''),
        BottomNavigationBarItem(
            icon: currentIndex == 4
                ? const Icon(Icons.account_circle)
                : const Icon(Icons.account_circle_outlined),
            label: '')
      ],
    );
  }
}
