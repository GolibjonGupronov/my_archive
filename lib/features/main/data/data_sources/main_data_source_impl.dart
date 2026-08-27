import 'package:dio/dio.dart';
import 'package:my_archive/features/main/data/data_sources/main_data_source.dart';

class MainDataSourceImpl extends MainDataSource {
  final Dio dio;

  MainDataSourceImpl({required this.dio});

  @override
  Future<bool> checkSession() {
    // TODO: implement checkSession
    throw UnimplementedError();
  }
}
