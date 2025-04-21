import 'dart:convert';
import 'package:mdabali_report/data/models/sms_summary_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/resources/constants.dart';

class SmsSummaryRepository {
  final GetRepo getRepo;

  SmsSummaryRepository({required this.getRepo});

  Future<SmsSummaryModel> fetchSmsSummaryData() async {
    try {
      final response = await getRepo.getRepository(
        ApiClass.smsUrl,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SmsSummaryModel.fromJson(data);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
