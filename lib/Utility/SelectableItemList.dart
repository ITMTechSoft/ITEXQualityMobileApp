import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/Themes/SystemTheme.dart';

class SelectableItemList<T> extends StatelessWidget {
  final Future<List<T>?> future;
  final String title;
  final T? selectedItem;
  final String Function(T) getTitle;
  final bool Function(T) isSelected;
  final void Function(T) onItemSelected;

  const SelectableItemList({
    super.key,
    required this.future,
    required this.title,
    required this.selectedItem,
    required this.getTitle,
    required this.isSelected,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>?>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Text("Error loading data");
        }

        final list = snapshot.data;

        if (list == null || list.isEmpty) {
          return const Text("No items available");
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade900,
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                final selected = isSelected(item);

                return Card(
                  shadowColor: ArgonColors.black,
                  elevation: selected ? 12 : 6,
                  child: ListTile(
                    onTap: () => onItemSelected(item),
                    title: Text(
                      getTitle(item),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: selected,
                    selectedTileColor: Colors.blue.shade50,
                    selectedColor: Colors.blue.shade900,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
