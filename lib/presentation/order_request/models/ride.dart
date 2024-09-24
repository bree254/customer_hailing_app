class RideRequest {
  final String ridetype;
  final String timeEstimate;
  final String imageUrl;
  final double discountedPrice;
  final double originalprice;

  RideRequest(
  {
    required this.ridetype,
    required this.timeEstimate,
    required this.imageUrl,
    required this.discountedPrice,
    required this.originalprice,
  });
}