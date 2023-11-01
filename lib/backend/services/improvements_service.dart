// Backend imports
import 'package:mindwaves/backend/services/tracker_service.dart';

class ImprovementsService {
  // Getting the data from the Tracker Service
  Map dataMap = TrackerService().getData();

  Map getWeeklyData() {
    Map factoryMap = {};

    // Looping through each value of the data
    dataMap.forEach((key, value) {
      DateTime dataDay = DateTime.parse(key);

      // Adding the data to the factory map only if it's in the last week
      if (dataDay.isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
        factoryMap[key] = value;
      }
    });

    return factoryMap;
  }

  String getImprovements() {
    Map weeklyData = getWeeklyData(); // Getting the data
    String improvements = ""; // Creating a string that stores improvements

    weeklyData.forEach((key, value) {
      improvements += "\n• $key";
    });

    return improvements;
  }
}
