import "package:http/http.dart" as http;

abstract class IHttpClient {
  Future get(String url, Map<String, String>? config);
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future get(String url, Map<String, String>? config) async {
    return await client.get(Uri.parse(url), headers: config);
  }
}
