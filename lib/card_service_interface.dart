import 'card_model.dart';
import 'pagination_model.dart';

abstract class CardServiceInterface {
  Future<List<CardModel>> fetchCards(PaginationModel paginate);
}
