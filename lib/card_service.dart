import 'package:dio/dio.dart';
import 'package:infinite_scroll/card_model.dart';
import 'package:infinite_scroll/card_service_interface.dart';
import 'package:infinite_scroll/pagination_model.dart';

class CardService extends CardServiceInterface {
  Dio _dio;
  CardService() {
    _dio = Dio();
  }

  @override
  Future<List<CardModel>> fetchCards(PaginationModel paginate) async {
    var queryParameters = {"page": paginate.page, "limit": paginate.limit};
    try {
      var response = await _dio.get(
        'https://picsum.photos/v2/list',
        queryParameters: queryParameters,
      );

      return response.data.map((e) => CardModel.fromJson(e)).toList().cast<CardModel>() as List<CardModel>;
    } catch (e) {
      return [];
    }
  }
}
