import 'dart:io';
import 'package:path/path.dart' as path_library;

class Template {
  Template(this.className);

  final String className;

  String license =
      '''/// Generate by [resource_generator](https://github.com/cherrybiu/flutter_generate_assets) library.
\n''';

  String get classDeclare => '''class $className {\n
  const $className._();\n''';

  String get classDeclareFooter => '}\n';

  String formatFiled(String path, String projectPath, bool isPreview) {
  //   if (isPreview) {
  //     return '''
  //
  // /// ![preview](file://$projectPath${path_library.separator}${_formatPreviewName(path)})
  // static const String ${_formatFiledName(path)} = '$path';\n''';
  //   } else {
  //     return '''
  //
  // static const String ${_formatFiledName(path)} = '$path';\n''';
  //   }
    return '''static const String ${_formatFiledName(path)} = '$path';\n''';
  }

  String _formatPreviewName(String path) {
    path = path.replaceAll(' ', '%20').replaceAll('/', path_library.separator);
    return path;
  }

  String getPrefix(String path) {
    final List<String> filterPath = path.substring(0, path.length).split('/');
    if (filterPath.contains('images') && filterPath[filterPath.length - 2] != 'images') {
      return filterPath[filterPath.length - 2].trim().toLowerCase() + '_';
    }

    return '';
  }

  String _formatFiledName(String path) {
    final List<String> paths = path.split('/');
    path = getPrefix(path) + paths.last.toString().trim().toLowerCase();

    path = path
        .replaceAll('/', '_')
        .replaceAll('.', '_')
        .replaceAll(' ', '_')
        .replaceAll('-', '_')
        .replaceAll('@', '_at_')
        .replaceAll(RegExp('_png'), '')
        .replaceAll(RegExp('_jpeg'), '')
        .replaceAll(RegExp('_jpg'), '');
    return path;
  }

  String toLowercaseFirstLetter(String str) {
    return '${str[0].toLowerCase()}${str.substring(1)}';
  }
}
