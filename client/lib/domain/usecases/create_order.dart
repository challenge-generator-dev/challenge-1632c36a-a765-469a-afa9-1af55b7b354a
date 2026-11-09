import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder({required this.repository});

  Future<Order> call(Order order) async {
    if (order == null) {
      throw ArgumentError('Order cannot be null');
    }
    if (order.items == null || order.items.isEmpty) {
      throw ArgumentError('Order must have at least one item');
    }
    if (order.userId == null || order.userId.isEmpty) {
      throw ArgumentError('Order must have a userId');
    }
    if (order.deliveryAddress == null || order.deliveryAddress.isEmpty) {
      throw ArgumentError('Order must have a delivery address');
    }
    if (order.paymentMethod == null || order.paymentMethod.isEmpty) {
      throw ArgumentError('Order must have a payment method');
    }

    final orderWithDefaults = _applyDefaults(order);
    return await repository.createOrder(orderWithDefaults);
  }

  Order _applyDefaults(Order order) {
    final now = DateTime.now();
    final calculatedTotal = _calculateTotal(order.items);
    
    return Order(
      id: order.id.isEmpty ? _generateOrderId() : order.id,
      userId: order.userId,
      items: order.items,
      createdAt: order.createdAt ?? now,
      status: order.status ?? OrderStatus.pending,
      totalAmount: calculatedTotal,
      deliveryAddress: order.deliveryAddress,
      paymentMethod: order.paymentMethod,
    );
  }

  double _calculateTotal(List<OrderItem> items) {
    return items.fold(0.0, (sum, item) => sum + (item.unitPrice * item.quantity));
  }

  String _generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'ORD-${timestamp.toString().substring(5)}';
  }
}