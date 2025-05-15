import 'dart:convert';
import 'package:mdabali_report/data/models/member_limit_model.dart';
import 'package:mdabali_report/data/repos/get_repo.dart';
import 'package:mdabali_report/resources/constants.dart';

class MemberLimitRepository {
  final GetRepo getRepo;

  MemberLimitRepository({required this.getRepo});

  Future<MemeberLimitModel> fetchMemberLimitData() async {
    try {
      final response = await getRepo.getRepository(
        ApiClass.memberLimitUrl,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return MemeberLimitModel.fromJson(data);
      } else {
        throw Exception(
            jsonDecode(response.body)['message'] ?? "Failed to load data");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }
}
