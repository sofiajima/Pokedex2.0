import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'pokemon.dart';

class DB {
  // create database
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'pokemon.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE pokemon(id INTEGER PRIMARY KEY, name TEXT, image TEXT, type TEXT)",
        );
      },
      version: 1,
    );
  }

// CRUD

// insert
  static Future<void> insertPokemon(Pokemon pokemon) async {
    final Database db = await _openDB();

    print("INSERT");
    print(db);

    await db.insert(
      'pokemon',
      pokemon.toMap(),
    );

    // print all pokemon
    print(await db.query('pokemon'));
  }

  // return all
  static Future<List<Pokemon>> pokemons() async {
    final Database db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query('pokemon');

    return List.generate(maps.length, (i) {
      return Pokemon(
        id: maps[i]['id'],
        name: maps[i]['name'],
        image: maps[i]['image'],
        type: maps[i]['type'],
      );
    });
  }

  // delete
  static Future<void> deletePokemon(String name) async {
    final db = await _openDB();

    await db.delete(
      'pokemon',
      where: "name = ?",
      whereArgs: [name],
    );
  }

  // with values
  static Future<void> insertWithValue(Pokemon pokemon) async {
    final Database db = await _openDB();

    var result = await db.rawInsert(
        "INSERT INTO pokemon (id, name, image, type) VALUES (?, ?, ?, ?)",
        [pokemon.id, pokemon.name, pokemon.image, pokemon.type[0]]);
  }

  // reset database
  static Future<void> resetDB() async {
    final Database db = await _openDB();

    // truncate table
    await db.execute("DELETE FROM pokemon");
  }
}
