class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.ordersapp.com/v1';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  static const String ordersEndpoint = '/orders';
  static const String usersEndpoint = '/users';
  static const String productsEndpoint = '/products';
  static const String authEndpoint = '/auth';
  static const String paymentsEndpoint = '/payments';

  static const int maxRetries = 3;
  static const int retryDelayMs = 1000;
}

class AppConstants {
  AppConstants._();

  static const String appName = 'Order App';
  static const String appVersion = '1.0.0';

  static const int pageSize = 20;
  static const int maxPageSize = 100;

  static const int cacheExpirationMinutes = 30;
  static const int maxCacheSize = 50;
}

class StorageKeys {
  StorageKeys._();

  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String lastSyncTimestamp = 'last_sync_timestamp';
  static const String onboardingCompleted = 'onboarding_completed';
}

class ErrorCodes {
  ErrorCodes._();

  static const String networkError = 'NETWORK_ERROR';
  static const String serverError = 'SERVER_ERROR';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String forbidden = 'FORBIDDEN';
  static const String notFound = 'NOT_FOUND';
  static const String validationError = 'VALIDATION_ERROR';
  static const String unknownError = 'UNKNOWN_ERROR';
}

class HttpStatusCodes {
  HttpStatusCodes._();

  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;
  static const int serviceUnavailable = 503;
}