import 'dart:convert';
import 'package:mdabali_report/data/models/summary_report_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';

class SummaryReportRepository {
  final GetRepo getRepo;

  SummaryReportRepository({required this.getRepo});

  Future<SummaryReportModel> fetchSummaryReport(
      {required String dateFrom, required String dateTo,required String clientId}) async {
    try {
      final response = await getRepo.getRepository(
        "/gateway/reportingApi/summary-report?fromDate=$dateFrom&toDate=$dateTo&clientId=$clientId",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SummaryReportModel.fromJson(data);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
