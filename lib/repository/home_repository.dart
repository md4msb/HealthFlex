import 'dart:developer';

import 'package:helthflex_giphy/constants/endpoints.dart';
import 'package:helthflex_giphy/model/giphy_model.dart';
import 'package:helthflex_giphy/service/api_client.dart';

class HomeRepository {

  Future<GiphyModel?> readTrendingGiphy(int limit, int offset) async {
    final queryParameters = {
      'api_key': apiKey,
      "limit": limit,
      'offset': offset,
      'rating': 'g',
      'bundle': 'messaging_non_clips'
    };
    var response = await apiClient.getRequest('$baseUrl$readTrending',
        queryParameters: queryParameters);

    if (response != null) {
      log('[pagination] ${response['pagination']}');
      return GiphyModel.fromJson(response);
    }
    return null;
  }
}
