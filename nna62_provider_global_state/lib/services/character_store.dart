import 'package:flutter/material.dart';
import 'package:nna62_provider_global_state/models/character.dart';
import 'package:nna62_provider_global_state/models/vocation.dart';

// lesson-60 - creating a data-repository, :ChangeNotifier:CharacterStore
class CharacterStore extends ChangeNotifier {
  // in a real app -  _characters would initialize from local cache or Firebase.
  final List<Character> _characters = [
    Character(id: '1', name: 'Klara', vocation: Vocation.wizard, slogan: 'Kapumf!'),
    Character(id: '2', name: 'Jonny', vocation: Vocation.junkie, slogan: 'Light me up...'),
    Character(id: '3', name: 'Crimson', vocation: Vocation.raider, slogan: 'Fire in the hole!'),
    Character(id: '4', name: 'Shaun', vocation: Vocation.ninja, slogan: 'Alright then gang.'),
  ];

  get characters => _characters;

  // add character (see lesson 62)
  void addCharacter(Character character) {
    _characters.add(character); // a. modify store
    notifyListeners(); // b. notify listeners
  }

  //@todo: save (update) character (via Firestore)

  //@todo: remove character (via Firestore)

  //@todo: initially fetch characters (via Firestore)
}
