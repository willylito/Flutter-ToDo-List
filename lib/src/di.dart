import 'package:get_it/get_it.dart';
import 'package:todo_list/src/controllers/todo_controller.dart';
import 'package:todo_list/src/services/consume_api.dart';
import 'package:todo_list/src/services/local_db.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Local DB instance
  instance.registerLazySingleton<LocalDb>(() => LocalDb());

  final localDb = await instance<LocalDb>().getDb();

  instance.registerFactory<TodoService>(() => TodoService(localDb));

  //DioFactory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await instance<DioFactory>().getDio();

  // AppServiceClient instance
  instance.registerLazySingleton(() => ApiService(dio));

  instance.registerFactory<TodoController>(
      () => TodoController(instance(), instance()));
}
