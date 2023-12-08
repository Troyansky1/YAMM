import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_category.dart';

List<TransactionCategory> defaultCategories() {
  return [
    TransactionCategory("Food", const Icon(Icons.shopping_cart), false, true),
    TransactionCategory(
        "Health", const Icon(Icons.local_hospital_outlined), false, true),
    TransactionCategory(
        "Health", const Icon(Icons.local_hospital_outlined), false, true),
    TransactionCategory("Work", const Icon(Icons.badge_outlined), true, false),
    TransactionCategory(
        "Refund/Return",
        const ImageIcon(AssetImage("assets/icons/income.png"), size: 10)
            as Icon,
        true,
        false),
    TransactionCategory(
        "Gift", const Icon(Icons.card_giftcard_outlined), true, true),
    TransactionCategory("Apps/ Softwares",
        const Icon(Icons.app_settings_alt_rounded), false, true),
    TransactionCategory("Electronics",
        const Icon(Icons.electrical_services_outlined), false, true),
    TransactionCategory(
        "Furnitures", const Icon(Icons.table_bar_outlined), false, true),
    TransactionCategory(
        "Furnitures", const Icon(Icons.table_bar_outlined), false, true),
  ];
}
