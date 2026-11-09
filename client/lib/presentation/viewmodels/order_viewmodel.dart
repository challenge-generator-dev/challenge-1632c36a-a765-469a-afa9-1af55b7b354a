import 'package:flutter/foundation.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/get_orders.dart';

class OrderViewModel extends ChangeNotifier {
  final GetOrders _getOrdersUseCase;
  final OrderRepository _orderRepository;

  OrderViewModel({
    required GetOrders getOrdersUseCase,
    required OrderRepository orderRepository,
  })  : _getOrdersUseCase = getOrdersUseCase,
        _orderRepository = orderRepository;

  OrderListState _state = const OrderListState();
  OrderListState get state => _state;

  Future<void> loadOrders() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final orders = await _getOrdersUseCase.call();
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al cargar los pedidos',
      );
    }

    notifyListeners();
  }

  Future<void> loadPendingOrders() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final orders = await _getOrdersUseCase.getPendingOrders();
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al cargar los pedidos pendientes',
      );
    }

    notifyListeners();
  }

  Future<void> loadOrdersByUserId(String userId) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final orders = await _getOrdersUseCase.getOrdersByUserId(userId);
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al cargar los pedidos del usuario',
      );
    }

    notifyListeners();
  }

  Future<void> filterByStatus(OrderStatus status) async {
    _state = _state.copyWith(
      isLoading: true,
      error: null,
      filter: OrderFilter(status: status),
    );
    notifyListeners();

    try {
      final orders = await _orderRepository.getOrdersByStatus(status);
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al filtrar los pedidos',
      );
    }

    notifyListeners();
  }

  Future<void> filterByUser(String userId) async {
    _state = _state.copyWith(
      isLoading: true,
      error: null,
      filter: OrderFilter(userId: userId),
    );
    notifyListeners();

    try {
      final orders = await _orderRepository.getOrdersByUser(userId);
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al filtrar los pedidos por usuario',
      );
    }

    notifyListeners();
  }

  void clearFilter() {
    _state = _state.copyWith(filter: null);
    notifyListeners();
    loadOrders();
  }

  Future<void> refreshOrders() async {
    await loadOrders();
  }

  String _mapExceptionToMessage(Exception e) {
    final errorMessage = e.toString().toLowerCase();
    
    if (errorMessage.contains('socketexception') || 
        errorMessage.contains('handshakeexception') ||
        errorMessage.contains('connection')) {
      return 'Error de conexión. Verifica tu conexión a internet.';
    }
    
    if (errorMessage.contains('timeout')) {
      return 'La solicitud ha tardado demasiado. Intenta de nuevo.';
    }
    
    if (errorMessage.contains('unauthorized') || 
        errorMessage.contains('401')) {
      return 'Sesión expirada. Inicia sesión nuevamente.';
    }
    
    if (errorMessage.contains('forbidden') || 
        errorMessage.contains('403')) {
      return 'No tienes permiso para realizar esta acción.';
    }
    
    if (errorMessage.contains('not found') || 
        errorMessage.contains('404')) {
      return 'El recurso solicitado no existe.';
    }
    
    if (errorMessage.contains('server') || 
        errorMessage.contains('500')) {
      return 'Error del servidor. Intenta más tarde.';
    }
    
    return 'Ha ocurrido un error. Por favor, intenta de nuevo.';
  }
}

class OrderListState {
  final bool isLoading;
  final List<Order> orders;
  final String? error;
  final OrderFilter? filter;

  const OrderListState({
    this.isLoading = false,
    this.orders = const [],
    this.error,
    this.filter,
  });

  OrderListState copyWith({
    bool? isLoading,
    List<Order>? orders,
    String? error,
    OrderFilter? filter,
    bool clearError = false,
    bool clearFilter = false,
  }) {
    return OrderListState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: clearError ? null : (error ?? this.error),
      filter: clearFilter ? null : (filter ?? this.filter),
    );
  }
}