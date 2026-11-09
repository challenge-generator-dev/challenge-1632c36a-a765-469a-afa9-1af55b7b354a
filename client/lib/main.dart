import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:order_app/core/network/api_client.dart';
import 'package:order_app/core/utils/constants.dart';
import 'package:order_app/data/datasources/order_remote_datasource.dart';
import 'package:order_app/data/repositories/order_repository_impl.dart';
import 'package:order_app/domain/usecases/create_order.dart';
import 'package:order_app/presentation/screens/order_list_screen.dart';
import 'package:order_app/presentation/viewmodels/order_viewmodel.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Configuración del cliente HTTP
  getIt.registerSingleton<ApiClient>(ApiClient(baseUrl: Constants.apiBaseUrl));

  // Data sources
  getIt.registerSingleton<OrderRemoteDataSource>(
    OrderRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(remoteDataSource: getIt<OrderRemoteDataSource>()),
  );

  // Use cases
  getIt.registerSingleton<CreateOrder>(
    CreateOrder(repository: getIt<OrderRepository>()),
  );

  // ViewModels
  getIt.registerFactory<OrderViewModel>(
    () => OrderViewModel(createOrder: getIt<CreateOrder>()),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const OrderApp());
}

class OrderApp extends StatelessWidget {
  const OrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<OrderViewModel>(),
        child: const OrderListScreen(),
      ),
    );
  }
}