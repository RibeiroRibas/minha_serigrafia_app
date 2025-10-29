import 'package:dio/dio.dart';
import 'package:minhaserigrafia/infra/http/dio/dio_http_client.dart';
import 'package:minhaserigrafia/modules/core/service/current_auth_user_service.dart';
import 'package:minhaserigrafia/modules/frame/exceptions/frame_exception.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_material_enum.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_model.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_resumed_model.dart';
import 'package:minhaserigrafia/settings.dart';

const String urlFrames = "api/app/v1/frames";

class FrameRepository {
  FrameRepository(this._httpClient, this._currentAuthUserService);

  final DioHttpClient _httpClient;
  final CurrentAuthUserService _currentAuthUserService;

  Future<void> createFrame({
    required String identifier,
    required String size,
    required String lines,
    FrameMaterial material = FrameMaterial.wood,
    required String lastUsageAt,
    List<int> printsIds = const [],
  }) async {
    final url = '${Settings.apiUrl}/$urlFrames';
    final data = {
      'identifier': int.parse(identifier),
      'material': material.label,
      'prints_id': printsIds,
    };
    if (size.isNotEmpty) {
      data['size'] = size;
    }
    if (lines.isNotEmpty) {
      data['lines'] = int.parse(lines);
    }
    if (lastUsageAt.isNotEmpty) {
      data['last_usage_at'] = lastUsageAt;
    }
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.post(url, data: data, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw FrameException(code);
    } catch (e) {
      throw Exception('Error during create frame: ${e.toString()}');
    }
  }

  Future<List<FrameResumedModel>> getFrames({
    String? inputFilter,
    String? lastUsageOrderFilter,
  }) async {
    final url = '${Settings.apiUrl}/$urlFrames';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    final queryParameters = <String, dynamic>{};
    if (inputFilter != null && inputFilter.isNotEmpty) {
      queryParameters['filter_value'] = inputFilter;
    }
    if (lastUsageOrderFilter != null && lastUsageOrderFilter.isNotEmpty) {
      queryParameters['last_usage_order'] = lastUsageOrderFilter;
    }
    try {
      final List<dynamic> response = await _httpClient.get(
        url,
        headers: headers,
        queryParameters: queryParameters,
      );
      return response
          .map(
            (frame) =>
                FrameResumedModel.fromJson(frame as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw FrameException(code);
    } catch (e) {
      throw Exception('Error during get frames: ${e.toString()}');
    }
  }

  Future<void> updateFrame({
    required int id,
    required String identifier,
    required String size,
    required String lines,
    required String lastUsageAt,
    FrameMaterial material = FrameMaterial.wood,
    List<int> printsIds = const [],
  }) async {
    final url = '${Settings.apiUrl}/$urlFrames/$id';
    final data = {
      'identifier': int.parse(identifier),
      'material': material.label,
      'prints_id': printsIds,
    };
    if (size.isNotEmpty) {
      data['size'] = size;
    }
    if (lines.isNotEmpty) {
      data['lines'] = int.parse(lines);
    }
    if (lastUsageAt.isNotEmpty) {
      data['last_usage_at'] = lastUsageAt;
    }
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.put(url, data: data, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw FrameException(code);
    } catch (e) {
      throw Exception('Error during update frame: ${e.toString()}');
    }
  }

  Future<FrameModel> getFrameById({required int frameId}) async {
    final url = '${Settings.apiUrl}/$urlFrames/$frameId';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      final Map<String, dynamic> response = await _httpClient.get(
        url,
        headers: headers,
      );
      return FrameModel.fromJson(response);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw FrameException(code);
    } catch (e) {
      throw Exception('Error during get frame by id: ${e.toString()}');
    }
  }

  Future<void> deleteFrame({required int frameId}) async {
    final url = '${Settings.apiUrl}/$urlFrames/$frameId';
    final headers = {'Authorization': _currentAuthUserService.firebaseIdToken};
    try {
      await _httpClient.delete(url, headers: headers);
    } on DioException catch (e) {
      final codeString = e.response?.data?['code']?.toString() ?? '0';
      final code = int.tryParse(codeString) ?? 0;
      throw FrameException(code);
    } catch (e) {
      throw Exception('Error during delete frame: ${e.toString()}');
    }
  }
}
