abstract class Repository<T, ID> {
  Future<List<T>> getAll();

  Future<T> getData(ID id);

  Future<T> insert(T element);

  Future<T> update(ID id, T element);

  void deleteData(ID id);

  void close();
}
