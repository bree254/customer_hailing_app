import 'package:customer_hailing/data/models/ride_requests/search_locations_response.dart';

import '../api/api_client.dart';

class RideServiceRepository {
  final _apiClient = ApiClient();

  Future<SearchLocationsResponse> uploadCustomerLocation(
      {
        required Map<String, String> headers,
        required Map<String, dynamic> requestData,
      }) async {
    return await _apiClient.uploadLocation(headers: headers, requestData: requestData);
  }
}