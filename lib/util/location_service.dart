import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:skysoft_taxi/util/api_.dart';

/// Yêu cầu quyền truy cập vị trí từ người dùng.
/// Đảm bảo rằng dịch vụ vị trí được bật và quyền đã được cấp.
/// Trả về true nếu quyền được cấp, ngược lại trả về false.
Future<bool> requestLocationPermission() async {
  Location location = Location();
  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  return permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always;
}

/// Lấy vị trí hiện tại của người dùng.
/// Trả về vĩ độ và kinh độ hiện tại dưới dạng đối tượng LatLng.
Future<LatLng> getCurrentLocation() async {
  LocationData locationData = await Location().getLocation();
  return LatLng(locationData.latitude!, locationData.longitude!);
}

/// Lấy các gợi ý vị trí dựa trên vĩ độ và kinh độ đã cung cấp.
/// Sử dụng dịch vụ API để lấy gợi ý vị trí.
/// Trả về danh sách các chuỗi vị trí được gợi ý.
Future<List<String>> fetchLocationSuggestions(
    double latitude, double longitude) async {
  try {
    AutocompleteService apiService = AutocompleteService();
    var suggestions = await apiService.getSuggestions('$latitude,$longitude');
    return suggestions;
  } catch (e) {
    // log('Lỗi khi lấy gợi ý vị trí: $e');
    return [];
  }
}

/// Lấy thông tin chi tiết về vị trí dựa trên vĩ độ và kinh độ đã cung cấp.
/// Sử dụng dịch vụ API để lấy chi tiết vị trí.
/// Trả về thông tin chi tiết vị trí đầu tiên dưới dạng chuỗi, hoặc thông báo lỗi nếu không tìm thấy chi tiết nào.
Future<String> fetchLocationDetails(double latitude, double longitude) async {
  try {
    AutocompleteService apiService = AutocompleteService();
    var suggestions = await apiService.getSuggestions('$latitude,$longitude');
    return suggestions.isNotEmpty
        ? suggestions.first
        : 'Không tìm thấy chi tiết nào';
  } catch (e) {
    // log('Lỗi khi lấy chi tiết vị trí: $e');
    return 'Lỗi khi lấy chi tiết vị trí';
  }
}

/// Tìm kiếm các vị trí dựa trên chuỗi truy vấn.
/// Sử dụng dịch vụ API để lấy gợi ý vị trí.
/// Trả về danh sách các chuỗi vị trí được gợi ý.
Future<List<String>> searchLocation(String query) async {
  if (query.isEmpty) return [];

  try {
    AutocompleteService apiService = AutocompleteService();
    var suggestions = await apiService.getSuggestions(query);
    return suggestions;
  } catch (e) {
    // log('Lỗi khi lấy gợi ý vị trí: $e');
    return [];
  }
}
