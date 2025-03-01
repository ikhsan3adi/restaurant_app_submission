class Setting {
  final bool darkModeEnable;

  const Setting({
    required this.darkModeEnable,
  });

  Setting copyWith({bool? darkModeEnable}) {
    return Setting(
      darkModeEnable: darkModeEnable ?? this.darkModeEnable,
    );
  }
}
