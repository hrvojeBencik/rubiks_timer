import 'dart:math';

List<String> _rightMoves = ["R", "R'", "2R", "2R'"];
List<String> _leftMoves = ["L", "L'", "2L", "2L'"];
List<String> _upMoves = ["U", "U'", "2U", "2U'"];
List<String> _downMoves = ["D", "D'", "2D", "2D'"];
List<String> _frontMoves = ["F", "F'", "2F", "2F'"];
List<String> _backMoves = ["B", "B'", "2B", "2B'"];

class ScrambleAlgorithm {
  static List<List<String>> _allMoves = [
    _rightMoves,
    _leftMoves,
    _upMoves,
    _downMoves,
    _frontMoves,
    _backMoves
  ];

  static String generate() {
    String _algorithm = "";
    var rng = Random();
    int disabledMove = 6;
    for (int i = 0; i < 28; i++) {
      int move = rng.nextInt(6);
      if (disabledMove == move) {
        continue;
      }
      int x = rng.nextInt(_rightMoves.length);
      String selectedMove = _allMoves[move][x];
      _algorithm = _algorithm + " " + selectedMove;
      disabledMove = move;
    }

    return _algorithm;
  }
}
