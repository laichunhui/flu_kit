import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  FileUtil._();

  /// 获取应用文档目录
  static Future<Directory> getDocumentDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// 获取应用临时目录
  static Future<Directory> getTemporaryDirectory() async {
    return await getTemporaryDirectory();
  }

  /// 获取应用缓存目录
  static Future<Directory> getCacheDirectory() async {
    return await getApplicationCacheDirectory();
  }

  /// 获取应用支持目录
  static Future<Directory> getSupportDirectory() async {
    return await getApplicationSupportDirectory();
  }

  /// 在文档目录中创建文件
  static Future<File> createFileInDocumentDirectory(String fileName) async {
    final directory = await getDocumentDirectory();
    final filePath = '${directory.path}/$fileName';
    return File(filePath);
  }

  /// 在临时目录中创建文件
  static Future<File> createFileInTemporaryDirectory(String fileName) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName';
    return File(filePath);
  }

  /// 在缓存目录中创建文件
  static Future<File> createFileInCacheDirectory(String fileName) async {
    final directory = await getCacheDirectory();
    final filePath = '${directory.path}/$fileName';
    return File(filePath);
  }

  /// 在文档目录中创建目录
  static Future<Directory> createDirectoryInDocumentDirectory(
    String dirName,
  ) async {
    final directory = await getDocumentDirectory();
    final dirPath = '${directory.path}/$dirName';
    return await Directory(dirPath).create(recursive: true);
  }

  /// 获取文件大小（字节）
  static Future<int> getFileSize(File file) async {
    return await file.length();
  }

  /// 获取文件大小的可读字符串表示
  static Future<String> getFileSizeString(File file) async {
    final bytes = await getFileSize(file);
    return formatFileSize(bytes);
  }

  /// 格式化文件大小
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  /// 检查文件是否存在
  static Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }

  /// 检查目录是否存在
  static Future<bool> directoryExists(String path) async {
    return await Directory(path).exists();
  }

  /// 删除文件
  static Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// 删除目录
  static Future<void> deleteDirectory(
    String path, {
    bool recursive = true,
  }) async {
    final directory = Directory(path);
    if (await directory.exists()) {
      await directory.delete(recursive: recursive);
    }
  }

  /// 获取文件扩展名
  static String getFileExtension(String path) {
    return path.split('.').last;
  }

  /// 获取文件名（不含扩展名）
  static String getFileNameWithoutExtension(String path) {
    final fileName = path.split('/').last;
    return fileName.substring(0, fileName.lastIndexOf('.'));
  }

  /// 获取文件名（含扩展名）
  static String getFileName(String path) {
    return path.split('/').last;
  }

  /// 获取文件的MIME类型
  static String getMimeType(String path) {
    final extension = getFileExtension(path).toLowerCase();

    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'ppt':
        return 'application/vnd.ms-powerpoint';
      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      case 'mp3':
        return 'audio/mpeg';
      case 'mp4':
        return 'video/mp4';
      case 'json':
        return 'application/json';
      case 'xml':
        return 'application/xml';
      case 'html':
        return 'text/html';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }
}
