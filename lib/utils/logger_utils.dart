import 'package:logger/logger.dart';

Logger logger = Logger(
  filter: null,
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  output: null,
);
