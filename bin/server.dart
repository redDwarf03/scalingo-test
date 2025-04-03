import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main() async {
  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // Start the server:
  // - Listens on all available IPv4 addresses (0.0.0.0)
  // - Uses PORT from environment variable or defaults to 3000
  // - await waits for server to start successfully
  final server = await serve(
    handler,
    InternetAddress.anyIPv4,
    int.fromEnvironment('PORT', defaultValue: 3000),
  );

  // Print server information
  print('Server running at http://${server.address.host}:${server.port}');
}

/// Main request router
///
/// [request] - The incoming HTTP request
/// Returns a Response object
Response _router(Request request) {
  // Handle root path request
  if (request.url.path == '/') {
    return Response.ok('Hello World!');
  }

  // Return 404 for all other paths
  return Response.notFound('Page not found');
}
