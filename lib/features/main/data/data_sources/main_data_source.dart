abstract class MainDataSource {
  Future<bool> checkSession();

  Future<Stream<bool>> watchSession();
}
