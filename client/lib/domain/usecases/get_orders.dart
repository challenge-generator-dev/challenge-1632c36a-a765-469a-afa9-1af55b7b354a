import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders({required this.repository});

  Future<List<Order>> call({OrderFilter? filter}) async {
    try {
      if (filter == null) {
        return await repository.getOrders();
      }

      if (filter.userId != null && filter.status != null) {
        return await repository.getOrdersByUser(filter.userId!, status: filter.status);
      } else if (filter.userId != null) {
        return await repository.getOrdersByUser(filter.userId!);
      } else if (filter.status != null) {
        return await repository.getOrdersByStatus(filter.status!);
      } else {
        return await repository.getOrders();
      }
    } on Exception catch (e) {
      throw Exception('Failed to fetch orders: ${e.toString()}');
    }
  }

  Future<List<Order>> getPendingOrders() async {
    try {
      return await repository.getOrders(status: OrderStatus.pending);
    } on Exception catch (e) {
      throw Exception('Failed to fetch pending orders: ${e.toString()}');
    }
  }

  Future<List<Order>> getOrdersByUserId(String userId) async {
    try {
      return await repository.getOrders(userId: userId);
    } on Exception catch (e) {
      throw Exception('Failed to fetch orders for user $userId: ${e.toString()}');
    }
  }
}