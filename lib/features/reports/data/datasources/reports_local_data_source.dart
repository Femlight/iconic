import 'package:shared_preferences/shared_preferences.dart';
import '../models/report_model.dart';
import 'dart:convert';

abstract class ReportsLocalDataSource {
  Future<List<ReportModel>> getReports();
  Future<ReportModel> createReport({
    required String title,
    required String description,
    required String category,
    required String location,
    double? latitude,
    double? longitude,
    required List<String> mediaUrls,
  });
}

class ReportsLocalDataSourceImpl implements ReportsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ReportsLocalDataSourceImpl({required this.sharedPreferences});

  static const String REPORTS_KEY = 'CACHED_REPORTS';

  @override
  Future<List<ReportModel>> getReports() async {
    final reportsString = sharedPreferences.getString(REPORTS_KEY);
    if (reportsString != null) {
      final List<dynamic> jsonList = json.decode(reportsString);
      return jsonList.map((json) => ReportModel.fromJson(json)).toList();
    }
    return [];
  }

  @override
  Future<ReportModel> createReport({
    required String title,
    required String description,
    required String category,
    required String location,
    double? latitude,
    double? longitude,
    required List<String> mediaUrls,
  }) async {
    final report = ReportModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category,
      location: location,
      latitude: latitude,
      longitude: longitude,
      mediaUrls: mediaUrls,
      createdAt: DateTime.now(),
      userId: 'current_user_id', // In real app, get from auth
    );

    final reports = await getReports();
    reports.insert(0, report);

    final jsonList = reports.map((report) => report.toJson()).toList();
    await sharedPreferences.setString(REPORTS_KEY, json.encode(jsonList));

    return report;
  }
}
