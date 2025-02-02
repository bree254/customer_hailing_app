import 'package:customer_hailing/data/models/ride_requests/confirm_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/driver_locations_response.dart';
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


  Future<ConfirmTripResponse> confirmTrip(
      {
        required Map<String, String> headers,
        required Map<String, dynamic> requestData,
      }) async {
    return await _apiClient.confirmTrip(headers: headers, requestData: requestData);
  }


  Future<List<DriverLocationsResponse>> getDriverLocations({required Map<String, String> headers}) {
    return _apiClient.getDriverLocations(headers: headers);
  }

}