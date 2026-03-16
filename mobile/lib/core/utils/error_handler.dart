import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Hết thời gian kết nối. Vui lòng kiểm tra kết nối mạng.';
        case DioExceptionType.sendTimeout:
          return 'Hết thời gian gửi dữ liệu. Vui lòng thử lại.';
        case DioExceptionType.receiveTimeout:
          return 'Hết thời gian nhận dữ liệu. Vui lòng thử lại.';
        case DioExceptionType.badResponse:
          return _getResponseErrorMessage(error);
        case DioExceptionType.cancel:
          return 'Yêu cầu đã bị hủy.';
        case DioExceptionType.unknown:
          return 'Lỗi mạng: ${error.message}';
        default:
          return 'Có lỗi xảy ra. Vui lòng thử lại.';
      }
    } else if (error is SocketException) {
      return 'Không thể kết nối tới server. Vui lòng kiểm tra kết nối mạng.';
    } else {
      return error.toString();
    }
  }

  static String _getResponseErrorMessage(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    switch (statusCode) {
      case 400:
        if (responseData is Map && responseData.containsKey('message')) {
          return responseData['message'] as String;
        }
        return 'Yêu cầu không hợp lệ.';
      case 401:
        return 'Đăng nhập hết hạn. Vui lòng đăng nhập lại.';
      case 403:
        return 'Bạn không có quyền thực hiện hành động này.';
      case 404:
        return 'Dữ liệu không tìm thấy.';
      case 409:
        return 'Dữ liệu đã tồn tại hoặc xung đột. Vui lòng thử lại.';
      case 422:
        return 'Dữ liệu gửi không hợp lệ. Vui lòng kiểm tra lại.';
      case 429:
        return 'Quá nhiều yêu cầu. Vui lòng chờ một lúc.';
      case 500:
        return 'Lỗi server. Vui lòng thử lại sau.';
      case 502:
        return 'Server không khả dụng. Vui lòng thử lại sau.';
      case 503:
        return 'Server đang bảo trì. Vui lòng thử lại sau.';
      default:
        return 'Lỗi ${statusCode}: ${error.message}';
    }
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi', style: TextStyle(color: Colors.red)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Đóng',
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}


