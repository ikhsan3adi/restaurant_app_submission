class Setting {
  final bool darkModeEnable;
  final bool dailyReminderEnable;

  const Setting({
    required this.darkModeEnable,
    required this.dailyReminderEnable,
  });

  Setting copyWith({
    bool? darkModeEnable,
    bool? dailyReminderEnable,
  }) {
    return Setting(
      darkModeEnable: darkModeEnable ?? this.darkModeEnable,
      dailyReminderEnable: darkModeEnable ?? this.dailyReminderEnable,
    );
  }
}
