/// List of Iraqi governorates with Arabic and English names.
class IraqGovernorate {
  const IraqGovernorate({required this.ar, required this.en});

  final String ar;
  final String en;

  @override
  String toString() => ar;

  static const List<IraqGovernorate> all = [
    IraqGovernorate(ar: 'بغداد', en: 'Baghdad'),
    IraqGovernorate(ar: 'أربيل', en: 'Erbil'),
    IraqGovernorate(ar: 'البصرة', en: 'Basra'),
    IraqGovernorate(ar: 'النجف', en: 'Najaf'),
    IraqGovernorate(ar: 'كربلاء', en: 'Karbala'),
    IraqGovernorate(ar: 'نينوى', en: 'Nineveh'),
    IraqGovernorate(ar: 'السليمانية', en: 'Sulaymaniyah'),
    IraqGovernorate(ar: 'دهوك', en: 'Duhok'),
    IraqGovernorate(ar: 'كركوك', en: 'Kirkuk'),
    IraqGovernorate(ar: 'بابل', en: 'Babil'),
    IraqGovernorate(ar: 'ديالى', en: 'Diyala'),
    IraqGovernorate(ar: 'الأنبار', en: 'Anbar'),
    IraqGovernorate(ar: 'واسط', en: 'Wasit'),
    IraqGovernorate(ar: 'صلاح الدين', en: 'Salah al-Din'),
    IraqGovernorate(ar: 'ميسان', en: 'Maysan'),
    IraqGovernorate(ar: 'ذي قار', en: 'Dhi Qar'),
    IraqGovernorate(ar: 'المثنى', en: 'Muthanna'),
    IraqGovernorate(ar: 'القادسية', en: 'Al-Qadisiyyah'),
  ];

  /// Find a governorate by its Arabic name (for backward compatibility).
  static IraqGovernorate? findByAr(String? name) {
    if (name == null || name.trim().isEmpty) return null;
    final trimmed = name.trim();
    for (final gov in all) {
      if (gov.ar == trimmed) return gov;
    }
    return null;
  }
}
