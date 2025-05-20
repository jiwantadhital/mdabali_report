import 'dart:convert';

import 'package:mdabali_report/data/models/summary_report_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/resources/constants.dart';

class SummaryReportRepository {
  final GetRepo getRepo;

  SummaryReportRepository({required this.getRepo});

  Future<SummaryReportModel> fetchSummaryReport(
      {required String dateFrom,
      required String dateTo,
      required String clientId}) async {
    try {
      final response = await getRepo.getRepository(
        '${ApiClass.summaryReportUrl}fromDate=$dateFrom&toDate=$dateTo&clientId=$clientId',
      );
      final data = jsonDecode(response.body);
      return SummaryReportModel.fromJson(data);
    } catch (e) {
      // For network or parsing errors
      return SummaryReportModel(
        status: false,
        message: e.toString(),
        error: [e.toString()],
      );
    }
  }
}
