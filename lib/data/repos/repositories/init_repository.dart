import 'dart:convert';
import 'package:mdabali_report/data/models/init_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/resources/constants.dart';

class InitRepository {
  final GetRepo getRepo;

  InitRepository({required this.getRepo});

  Future<InitModel> fetchInitData() async {
    try {
      final response = await getRepo.getRepository(
        ApiClass.initUrl,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return InitModel.fromJson(data);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to load data");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
