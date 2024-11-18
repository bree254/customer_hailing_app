class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  static void log(dynamic data, {StackTrace? stackTrace}) {
    if (_logMode == LogMode.debug) {
      print("Error: $data$stackTrace");
    } else if (_logMode == LogMode.live) {
      // logToFile("Error: $data$stackTrace");
    }
  }

  // static Future<void> logToFile(String message) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = directory.path;
  //   final logDirectory = Directory('$path/logs');
  //
  //   // Check if the directory exists, if not then create it
  //   if (!await logDirectory.exists()) {
  //     await logDirectory.create(recursive: true);
  //   }
  //
  //   final file = File('${logDirectory.path}/logs.txt');
  //   // Write the log message to the file
  //   await file.writeAsString('$message\n', mode: FileMode.append);
  // }
}

enum LogMode { debug, live }
