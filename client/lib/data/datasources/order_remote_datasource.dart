import 'package:dio/dio.dart';
import '../../domain/entities/order.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/constants.dart';

abstract class OrderRemoteDataSource {
  Future<List<Order>> getOrders();
  Future<Order> getOrderById(String orderId);
  Future<Order> createOrder(Order order);
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus);
  Future<void> deleteOrder(String orderId);
  Future<List<Order>> getOrdersByUser(String userId);
  Future<List<Order>> getOrdersByStatus(OrderStatus status);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient apiClient;
  
  static const String _ordersEndpoint = '/orders';
  static const String _usersEndpoint = '/users';
  
  OrderRemoteDataSourceImpl({required this.apiClient});
  
  Map<String, dynamic> _orderToJson(Order order) {
    return {
      'id': order.id,
      'userId': order.userId,
      'items': order.items.map((item) => {
        'productId': item.productId,
        'productName': item.productName,
        'quantity': item.quantity,
        'unitPrice': item.unitPrice,
      }).toList(),
      'createdAt': order.createdAt.toIso8601String(),
      'status': order.status.name,
      'totalAmount': order.totalAmount,
      'deliveryAddress': order.deliveryAddress,
      'paymentMethod': order.paymentMethod,
    };
  }
  
  Order _parseOrderFromJson(Map<String, dynamic> json) {
    return Order.fromJson(json);
  }
  
  List<Order> _parseOrderList(List<dynamic> jsonList) {
    return jsonList.map((json) => _parseOrderFromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<List<Order>> getOrders() async {
    try {
      final response = await apiClient.get(_ordersEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return _parseOrderList(data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching orders: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _ordersEndpoint),
        message: 'Unexpected error fetching orders: $e',
      );
    }
  }
  
  @override
  Future<Order> getOrderById(String orderId) async {
    try {
      final response = await apiClient.get('$_ordersEndpoint/$orderId');
      if (response.statusCode == 200) {
        return _parseOrderFromJson(response.data as Map<String, dynamic>);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching order $orderId: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$_ordersEndpoint/$orderId'),
        message: 'Unexpected error fetching order: $e',
      );
    }
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    try {
      final response = await apiClient.post(
        _ordersEndpoint,
        data: _orderToJson(order),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _parseOrderFromJson(response.data as Map<String, dynamic>);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error creating order: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _ordersEndpoint),
        message: 'Unexpected error creating order: $e',
      );
    }
  }
  
  @override
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      final response = await apiClient.patch(
        '$_ordersEndpoint/$orderId',
        data: {'status': newStatus.name},
      );
      if (response.statusCode == 200) {
        return _parseOrderFromJson(response.data as Map<String, dynamic>);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error updating order status: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$_ordersEndpoint/$orderId'),
        message: 'Unexpected error updating order status: $e',
      );
    }
  }
  
  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      final response = await apiClient.delete('$_ordersEndpoint/$orderId');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Error deleting order: ${response.statusCode}',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$_ordersEndpoint/$orderId'),
        message: 'Unexpected error deleting order: $e',
      );
    }
  }
  
  @override
  Future<List<Order>> getOrdersByUser(String userId) async {
    try {
      final response = await apiClient.get(
        _usersEndpoint,
        queryParameters: {'userId': userId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return _parseOrderList(data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching orders by user: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _usersEndpoint),
        message: 'Unexpected error fetching orders by user: $e',
      );
    }
  }
  
  @override
  Future<List<Order>> getOrdersByStatus(OrderStatus status) async {
    try {
      final response = await apiClient.get(
        _ordersEndpoint,
        queryParameters: {'status': status.name},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return _parseOrderList(data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching orders by status: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _ordersEndpoint),
        message: 'Unexpected error fetching orders by status: $e',
      );
    }
  }
}