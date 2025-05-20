import 'dart:convert';

import 'package:mdabali_report/data/models/monthly_aggregate_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/resources/constants.dart';

class MonthlyAggregateRepository {
  final GetRepo getRepo;

  MonthlyAggregateRepository({required this.getRepo});

  Future<MonthlyAggregateModel> fetchMonthlyAggregate() async {
    try {
      final response = await getRepo.getRepository(
        ApiClass.monthlyAggerateUrl,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return MonthlyAggregateModel.fromJson(data);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? 'Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
