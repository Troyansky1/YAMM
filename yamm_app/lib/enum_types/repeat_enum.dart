enum RepeatOptions {
  noRepeat('Does not repeat'),
  daily('Day'),
  weekly('Week'),
  monthly('Month'),
  yearly('Year');

  const RepeatOptions(this.label);
  final String label;
}
