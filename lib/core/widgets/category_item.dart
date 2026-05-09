import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final String icon;
  final String colorHex;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.name,
    required this.icon,
    required this.colorHex,
    this.isSelected = false,
    required this.onTap,
  });

  Color _parseColor() {
    final hex = colorHex.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final color = _parseColor();
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.15) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: color, width: 1.5) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _categoryIcon(name),
                color: color,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
                color: isSelected ? color : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _categoryIcon(String name) {
    switch (name.toLowerCase()) {
      case 'groceries':
        return Icons.shopping_basket;
      case 'household':
        return Icons.cleaning_services;
      case 'fast food':
        return Icons.fastfood;
      case 'gas refill':
        return Icons.local_gas_station;
      case 'water refill':
        return Icons.water_drop;
      default:
        return Icons.category;
    }
  }
}
