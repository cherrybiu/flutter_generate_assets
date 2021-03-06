import 'dart:io';

import 'package:args/args.dart';
import 'package:flutter_generate_assets/builder.dart';
import 'package:flutter_generate_assets/logger.dart';
import 'package:path/path.dart' as path_library;

String get separator => path_library.separator;

void main(List<String> args) {
  final ArgParser parser = ArgParser();
  parser.addFlag(
    'watch',
    abbr: 'w',
    defaultsTo: true,
    help: 'Continue to monitor changes after execution of orders.',
  );
  parser.addFlag(
    'recursive',
    abbr: 'r',
    defaultsTo: true,
    help: 'Recursive sub-directory',
  );
  parser.addOption(
    'output',
    abbr: 'o',
    defaultsTo: 'lib${separator}sm${separator}utils${separator}res${separator}assets_resource.dart',
    help: 'Your resource file path. \nIf it\'s a relative path, the relative flutter root directory',
  );
  parser.addOption(
    'src',
    abbr: 's',
    defaultsTo: '.',
    help: 'Flutter project root path',
  );
  parser.addOption(
    'name',
    abbr: 'n',
    defaultsTo: 'AssetsUtils',
    help: 'The class name for the constant.',
  );
  parser.addFlag('help', abbr: 'h', help: 'Help usage', defaultsTo: false);

  parser.addFlag('debug', abbr: 'd', help: 'debug info', defaultsTo: false);

  // parser.addFlag(
  //   'preview',
  //   abbr: 'p',
  //   help: 'Enable preview comments, defaults to true, use --no-preview to disable this functionality',
  //   defaultsTo: false,
  // );

  final ArgResults results = parser.parse(args);

  Logger().isDebug = results['debug'] as bool?;

  if (results.wasParsed('help')) {
    print(parser.usage);
    return;
  }

  final String path = results['src'] as String;
  final String? className = results['name'] as String?;
  final String? outputPath = results['output'] as String?;
  final File workPath = File(path).absolute;

  check(
    workPath,
    outputPath,
    className,
    results['watch'] as bool?,
    // results['preview'] as bool,
    results['recursive'] as bool?,
  );
}

void check(
  File workPath,
  String? outputPath,
  String? className,
  bool? isWatch,
  // bool isPreview,
  bool? isRecursive,
) {
  final ResourceDartBuilder builder = ResourceDartBuilder(workPath.absolute.path, outputPath);
  builder.isWatch = isWatch;
  // builder.isPreview = isPreview;
  builder.isRecursive = isRecursive;
  builder.generateResourceDartFile(className);
}
