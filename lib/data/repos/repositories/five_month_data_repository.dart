import 'dart:convert';
import 'package:mdabali_report/data/models/five_month_data_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/resources/constants.dart';

class FiveMonthDataRepository {
  final GetRepo getRepo;

  FiveMonthDataRepository({required this.getRepo});

  Future<FiveMonthDataModel> fetchFiveMonthData(
      {required String toDate}) async {
    try {
      final response = await getRepo.getRepository(
        "${ApiClass.pastFiveMonthUrl}?toDate=$toDate",
      );

      if (response.statusCode == 200) {  
        final data = jsonDecode(response.body);
        return FiveMonthDataModel.fromJson(data);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
