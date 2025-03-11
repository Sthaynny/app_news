import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Solicita uma única permissão e retorna `true` se for concedida.
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// Verifica se uma permissão já foi concedida.
  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.status.isGranted;
  }

  /// Solicita várias permissões e retorna um mapa com os resultados.
  Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }

  /// Abre as configurações do app para que o usuário possa conceder permissões manualmente.
  Future<bool> openSettings() => openAppSettings();
}
