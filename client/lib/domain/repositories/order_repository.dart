import 'package:order_app/domain/entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders({String? userId, OrderStatus? status});
  Future<Order> getOrderById(String orderId);
  Future<Order> createOrder(Order order);
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus);
  Future<void> deleteOrder(String orderId);

  Future<List<Order>> getOrdersByUser(String userId, {OrderStatus? status});
  Future<List<Order>> getOrdersByStatus(OrderStatus status);
}

class OrderFilter {
  final String? userId;
  final OrderStatus? status;
  final DateTime? fromDate;
  final DateTime? toDate;

  OrderFilter({
    this.userId,
    this.status,
    this.fromDate,
    this.toDate,
  });
}