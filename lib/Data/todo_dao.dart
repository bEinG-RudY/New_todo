import 'package:sembast/sembast.dart';
import 'package:todo_new/Data/app_database.dart';
import 'package:todo_new/Model/todo.dart';

class TodoDao {
  static const String CONTACT_STORE_NAME = 'todos';
  final _todoStore = intMapStoreFactory.store(CONTACT_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(ToDo todo) async {
    await _todoStore.add(await _db, todo.toMap());
  }

  Future update(ToDo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await _todoStore.update(await _db, todo.toMap(), finder: finder);
  }

  Future delete(ToDo todo) async {
    final finder = Finder(filter: Filter.byKey(todo.id));
    await _todoStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<ToDo>> getAllInSortedOrder() async {
    final finder = Finder(sortOrders: [
      SortOrder('isDone', false),
      SortOrder('name'),
    ]);

    final RecordSnapshot = await _todoStore.find(await _db, finder: finder);

    return RecordSnapshot.map((snapshot) {
      final todo = ToDo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }
}
