import 'dart:convert';
import 'package:mdabali_report/data/models/topup_summary_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/resources/constants.dart';

class TopupSummaryRepository {
  final GetRepo getRepo;

  TopupSummaryRepository({required this.getRepo});

  Future<TopupSummaryModel> fetchTopupSummaryData() async {
    try {
      final response = await getRepo.getRepository(
        ApiClass.topupUrl,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TopupSummaryModel.fromJson(data);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
