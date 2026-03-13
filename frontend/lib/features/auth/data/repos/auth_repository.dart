import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository(this._dioClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dioClient.dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Erreur de connexion');
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String fullName,
    String role,
  ) async {
    try {
      final response = await _dioClient.dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'fullName': fullName,
        'initialRole': role,
      });
      return response.data;
    } on DioException catch (e) {
      // ✅ AFFICHER LE VRAI MESSAGE D'ERREUR POUR LE DEBUG
      print('❌ REGISTER ERROR: ${e}');
      throw Exception(e.response?.data['message'] ?? 'Erreur: ${e.message}');
    } catch (e) {
      print('❌ UNKNOWN ERROR: $e');
      throw Exception('Erreur inconnue: $e');
    }
  }
}