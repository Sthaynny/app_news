import 'package:ufersa_hub/core/strings/strings.dart';
import 'package:ufersa_hub/core/utils/result.dart';

mixin RequestMixin {
  Future<Result<T>> request<T>(Future<T> Function() function) async {
    try {
      final result = await function();
      return Result.ok(result);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.errorDefault(errorDefaultString);
    }
  }
}
