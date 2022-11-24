import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pokemon/home_screen.dart';
import 'package:pokemon/pokemon.dart';

import 'db.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // create list
  List _pokemons;

  // call function when screen is loaded
  @override
  void initState() {
    super.initState();
    if (mounted) {
      getAllPokemon();
    }
  }

  getAllPokemon() async {
    // get all pokemon
    List<Pokemon> pokemonList = await DB.pokemons();

    setState(() {
      _pokemons = pokemonList;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // add text and Image
        title: Text(
          'Favoritos',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        // color black
        iconTheme: IconThemeData(color: Colors.black),

        //action
        actions: [
          IconButton(
            icon: Icon(Icons.remove_circle_outline_rounded),
            onPressed: () {
              // call resetDB function
              DB.resetDB();

              // call getAllPokemon function
              getAllPokemon();
            },
          ),
        ],
        // remove elevation
        elevation: 0,
      ),
      body: Stack(children: [
        Positioned(
          top: 20,
          bottom: 0,
          width: width,
          child: Column(
            children: [
              // list pokemons is not empty
              _pokemons != null && _pokemons.length > 0
                  ? Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.4),
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: _pokemons.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: InkWell(
                                child: SafeArea(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: _pokemons[index].type == "Grass"
                                            ? Colors.greenAccent
                                            : _pokemons[index].type == "Fire"
                                                ? Colors.redAccent
                                                : _pokemons[index].type ==
                                                        "Water"
                                                    ? Colors.blue
                                                    : _pokemons[index].type ==
                                                            "Poison"
                                                        ? Colors
                                                            .deepPurpleAccent
                                                        : _pokemons[index]
                                                                    .type ==
                                                                "Electric"
                                                            ? Colors.amber
                                                            : _pokemons[index]
                                                                        .type ==
                                                                    "Rock"
                                                                ? Colors.grey
                                                                : _pokemons[index]
                                                                            .type ==
                                                                        "Ground"
                                                                    ? Colors
                                                                        .brown
                                                                    : _pokemons[index].type ==
                                                                            "Psychic"
                                                                        ? Colors
                                                                            .indigo
                                                                        : _pokemons[index].type ==
                                                                                "Fighting"
                                                                            ? Colors.orange
                                                                            : _pokemons[index].type == "Bug"
                                                                                ? Colors.lightGreenAccent
                                                                                : _pokemons[index].type == "Ghost"
                                                                                    ? Colors.deepPurple
                                                                                    : _pokemons[index].type == "Normal"
                                                                                        ? Colors.black26
                                                                                        : Colors.pink,
                                        borderRadius: BorderRadius.all(Radius.circular(25))),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: -10,
                                          right: -10,
                                          child: Image.asset(
                                            'images/pokeball.png',
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          right: 5,
                                          child: Hero(
                                            tag: index,
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                    _pokemons[index].image,
                                                height: 100,
                                                fit: BoxFit.fitHeight,
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )),
                                          ),
                                        ),
                                        Positioned(
                                          top: 55,
                                          left: 15,
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                  top: 5,
                                                  bottom: 5),
                                              child: Text(
                                                _pokemons[index].type,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    shadows: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.blueGrey,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 1.0,
                                                          blurRadius: 15)
                                                    ]),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 15,
                                          child: Text(
                                            _pokemons[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.blueGrey,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 1.0,
                                                      blurRadius: 15)
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }))
                  : Center(
                      child: Text(
                        'No hay pokemones favoritos',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            height: 150,
            width: width,
          ),
        ),
      ]),
    );
  }
}
