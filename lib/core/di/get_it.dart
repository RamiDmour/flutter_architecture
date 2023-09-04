import 'package:flutter_architecture/core/navigation/app_router.dart';
import 'package:flutter_architecture/data/todo/local_datasource/entity/todo_entity.dart';
import 'package:flutter_architecture/data/todo/local_datasource/todo_local_datasource.dart';
import 'package:flutter_architecture/data/todo/remote_datasource/todo_remote_datasource.dart';
import 'package:flutter_architecture/data/todo/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoEntitySchema], directory: dir.path);

  getIt.registerSingleton<Isar>(isar);
  getIt.registerSingleton<AppRouter>(AppRouter());

  final todoLocalDatasource = TodoLocalDatasource(isar: isar);
  final todoRemoteDatasource = TodoRemoteDatasource();
  getIt.registerSingleton<TodoLocalDatasourceBase>(todoLocalDatasource);
  getIt.registerSingleton<TodoRemoteDatasourceBase>(todoRemoteDatasource);

  getIt.registerSingleton<TodoRepositoryBase>(TodoRepository(
    todoLocalDatasource: getIt.get(),
    todoRemoteDatasource: getIt.get(),
  ));
}
