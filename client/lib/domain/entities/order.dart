part of 'order.dart';

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final DateTime createdAt;
  final OrderStatus status;
  final double totalAmount;
  final String deliveryAddress;
  final String paymentMethod;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.status,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.paymentMethod,
  }) {
    if (id.isEmpty) throw ArgumentError('Order ID cannot be empty');
    if (userId.isEmpty) throw ArgumentError('User ID cannot be empty');
    if (items.isEmpty) throw ArgumentError('Order must contain at least one item');
    if (totalAmount <= 0) throw ArgumentError('Total amount must be positive');
    if (deliveryAddress.isEmpty) throw ArgumentError('Delivery address cannot be empty');
    if (paymentMethod.isEmpty) throw ArgumentError('Payment method cannot be empty');
  }

  Order copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    DateTime? createdAt,
    OrderStatus? status,
    double? totalAmount,
    String? deliveryAddress,
    String? paymentMethod,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      deliveryAddress: json['deliveryAddress'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  }) {
    if (productId.isEmpty) throw ArgumentError('Product ID cannot be empty');
    if (productName.isEmpty) throw ArgumentError('Product name cannot be empty');
    if (quantity <= 0) throw ArgumentError('Quantity must be positive');
    if (unitPrice <= 0) throw ArgumentError('Unit price must be positive');
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
    );
  }
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}