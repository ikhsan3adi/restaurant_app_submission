enum MyWorkmanager {
  oneOff('task-identifier', 'task-identifier'),
  periodic('daily_reminder_task', 'show_daily_reminder');

  final String uniqueName;
  final String taskName;

  const MyWorkmanager(this.uniqueName, this.taskName);
}
