import 'package:dio/dio.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  
  OrderRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<Order>> getOrders({OrderFilter? filter}) async {
    try {
      if (filter != null) {
        if (filter.userId != null) {
          return await remoteDataSource.getOrdersByUser(filter.userId!);
        }
        if (filter.status != null) {
          return await remoteDataSource.getOrdersByStatus(filter.status!);
        }
        if (filter.fromDate != null || filter.toDate != null) {
          final allOrders = await remoteDataSource.getOrders();
          return _filterByDateRange(allOrders, filter.fromDate, filter.toDate);
        }
      }
      return await remoteDataSource.getOrders();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching orders: $e');
    }
  }
  
  List<Order> _filterByDateRange(List<Order> orders, DateTime? fromDate, DateTime? toDate) {
    return orders.where((order) {
      if (fromDate != null && order.createdAt.isBefore(fromDate)) {
        return false;
      }
      if (toDate != null && order.createdAt.isAfter(toDate)) {
        return false;
      }
      return true;
    }).toList();
  }
  
  @override
  Future<Order> getOrderById(String orderId) async {
    try {
      return await remoteDataSource.getOrderById(orderId);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching order by id: $e');
    }
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    try {
      _validateOrder(order);
      return await remoteDataSource.createOrder(order);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error creating order: $e');
    }
  }
  
  void _validateOrder(Order order) {
    if (order.items.isEmpty) {
      throw OrderValidationException('Order must have at least one item');
    }
    if (order.userId.isEmpty) {
      throw OrderValidationException('Order must have a userId');
    }
    if (order.deliveryAddress.isEmpty) {
      throw OrderValidationException('Order must have a delivery address');
    }
    for (final item in order.items) {
      if (item.quantity <= 0) {
        throw OrderValidationException('Item quantity must be greater than zero');
      }
      if (item.unitPrice <= 0) {
        throw OrderValidationException('Item unit price must be greater than zero');
      }
    }
  }
  
  @override
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      return await remoteDataSource.updateOrderStatus(orderId, newStatus);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error updating order status: $e');
    }
  }
  
  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      await remoteDataSource.deleteOrder(orderId);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error deleting order: $e');
    }
  }
  
  @override
  Future<List<Order>> getOrdersByUser(String userId, {OrderFilter? filter}) async {
    try {
      var orders = await remoteDataSource.getOrdersByUser(userId);
      if (filter?.status != null) {
        orders = orders.where((o) => o.status == filter!.status).toList();
      }
      if (filter?.fromDate != null || filter?.toDate != null) {
        orders = _filterByDateRange(orders, filter?.fromDate, filter?.toDate);
      }
      return orders;
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching orders by user: $e');
    }
  }
  
  @override
  Future<List<Order>> getOrdersByStatus(OrderStatus status, {OrderFilter? filter}) async {
    try {
      var orders = await remoteDataSource.getOrdersByStatus(status);
      if (filter?.fromDate != null || filter?.toDate != null) {
        orders = _filterByDateRange(orders, filter?.fromDate, filter?.toDate);
      }
      return orders;
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching orders by status: $e');
    }
  }
  
  OrderRepositoryException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return OrderRepositoryException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.connectionError:
        return OrderRepositoryException('No internet connection. Please try again later.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return OrderRepositoryException('Order not found.');
        } else if (statusCode == 401) {
          return OrderRepositoryException('Unauthorized. Please log in again.');
        } else if (statusCode == 403) {
          return OrderRepositoryException('Access denied.');
        } else if (statusCode != null && statusCode >= 500) {
          return OrderRepositoryException('Server error. Please try again later.');
        }
        return OrderRepositoryException('Request failed with status: $statusCode');
      case DioExceptionType.cancel:
        return OrderRepositoryException('Request was cancelled.');
      default:
        return OrderRepositoryException('An unexpected error occurred: ${e.message}');
    }
  }
}

class OrderRepositoryException implements Exception {
  final String message;
  OrderRepositoryException(this.message);
  
  @override
  String toString() => message;
}

class OrderValidationException implements Exception {
  final String message;
  OrderValidationException(this.message);
  
  @override
  String toString() => message;
}