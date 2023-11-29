enum Currency {
  ils(
      name: "Israely new Shekel",
      symbolPath: 'assets/icons/shekel_currency_symbol.png'),
  eu(name: "Euro", symbolPath: 'assets/icons/euro_currency_symbol.png'),
  usd(name: "Dollar", symbolPath: 'assets/icons/dollar_currency_symbol.png');

  const Currency({required this.name, required this.symbolPath});

  final String name;
  final String symbolPath;
}
