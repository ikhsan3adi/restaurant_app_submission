import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/services/local_notification_service.dart';
import 'package:restaurant_app/static/my_workmanager.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == MyWorkmanager.periodic.taskName) {
      final apiService = ApiServices();
      final notificationService = LocalNotificationService();
      await notificationService.init();
      await notificationService.configureLocalTimeZone();

      try {
        final response = await apiService.getRestaurantList();
        final restaurants = response.restaurants;

        if (restaurants.isNotEmpty) {
          final restaurant = restaurants[Random().nextInt(restaurants.length)];

          await notificationService.scheduleDailyElevenAMNotification(
            id: LocalNotificationService.dailyReminderNotificationId,
            channelId: 'daily_reminder_channel',
            channelName: 'Daily Lunch Reminder',
            title: 'Restaurant Recommendations Today',
            body: 'Let\'s have lunch at ${restaurant.name} 🍽️',
            payload: restaurant.toJson().toString(),
          );
        }
      } catch (e) {
        debugPrint('Error fetching restaurant data: $e');
      }
    }

    return Future.value(true);
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
      : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );
  }

  Future<void> runPeriodicTask({
    required String uniqueName,
    required String taskName,
    Map<String, dynamic>? inputData,
  }) async {
    await _workmanager.registerPeriodicTask(
      uniqueName,
      taskName,
      frequency: const Duration(hours: 24),
      tag: MyWorkmanager.periodic.taskName,
      initialDelay: Duration.zero,
      inputData: inputData,
    );
  }

  Future<void> cancelTask(String tag) async {
    await _workmanager.cancelByTag(tag);
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
