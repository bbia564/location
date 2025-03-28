
import 'package:get/get.dart';
import 'package:motion_record/db_montion/motion_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DBMotion extends GetxService {
  late Database dbBase;

  Future<DBMotion> init() async {
    await createMotionDB();
    return this;
  }

  createMotionDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'motion.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createMotionTable(db);
        });
  }

  createMotionTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS motion (id INTEGER PRIMARY KEY, createdTime TEXT, stepNumber INTEGER, seconds int, heat TEXT, distance TEXT)');
  }

  insertMotion(MotionEntity entity) async {
    final id = await dbBase.insert('motion', {
      'createdTime': entity.createdTime.toIso8601String(),
      'stepNumber': entity.stepNumber,
      'seconds': entity.seconds,
      'heat': entity.heat,
      'distance': entity.distance,
    });
    return id;
  }

  cleanMotionData() async {
    await dbBase.delete('motion');
  }

  Future<List<MotionEntity>> getMotionAllData() async {
    var result = await dbBase.query('motion', orderBy: 'createdTime DESC');
    return result.map((e) => MotionEntity.fromJson(e)).toList();
  }
}
