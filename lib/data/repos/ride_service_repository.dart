import 'package:customer_hailing/data/models/ride_requests/confirm_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/driver_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/rate_trip_response.dart';
import 'package:customer_hailing/data/models/ride_requests/scheduled_trip_details_response.dart';
import 'package:customer_hailing/data/models/ride_requests/scheduled_trips_response.dart';
import 'package:customer_hailing/data/models/ride_requests/search_locations_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_details_response.dart';
import 'package:customer_hailing/data/models/ride_requests/trip_history_response.dart';

import '../api/api_client.dart';
import '../models/ride_requests/schedule_trip_response.dart';
import '../models/ride_requests/trip_history_details_response.dart';

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

  Future<TripDetailsResponse> getTripDetails(
      {
        Map<String, String> headers = const {},
        required String requestId}) async {
    return _apiClient.getTripDetails(
      headers: headers, requestId: requestId,);
  }

  Future<TripHistoryResponse> tripHistory(
      {
        Map<String, String> headers = const {},
        required String customerId}) async {
    return _apiClient.tripHistory(
      headers: headers, customerId: customerId,);
  }

  Future<TripHistoryDetailsResponse> tripHistoryDetails(
      {
        Map<String, String> headers = const {},
        required String tripId}) async {
    return _apiClient.tripHistoryDetails(
      headers: headers,tripId: tripId,);
  }

  Future<RateTripResponse> rateTrip(
      {
        required Map<String, String> headers,
        required Map<String, dynamic> requestData,
      }) async {
    return await _apiClient.rateTrip(headers: headers, requestData: requestData);
  }

  Future<ScheduleTripResponse> scheduleTrip({
    required Map<String, String> headers,
    required Map<String, dynamic> requestData,
  }) async {
    return await _apiClient.scheduleTrip(headers: headers, requestData: requestData);
  }

  Future<List<ScheduledTripsResponse>> scheduledTrips({
    required Map<String, String> headers,
    required String customerId,
  }) async {
    return _apiClient.scheduledTrips(
      headers: headers,
      customerId: customerId,
    );
  }

  Future<ScheduledTripDetailsResponse> scheduledTripDetails(
      {
        Map<String, String> headers = const {},
        required String tripId}) async {
    return _apiClient.scheduledTripDetails(
      headers: headers,tripId: tripId,);
  }



}