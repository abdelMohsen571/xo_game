import 'package:flutter/material.dart';
import 'package:xo_game/button_widget.dart';
import 'package:xo_game/text_style.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int xScore, oScore;
  bool xTurn;
  late List<String> xoBoard;
  onChange(int index) {
    if (xoBoard[index] == '') {
      xoBoard[index] = (xTurn) ? "X" : "O";
      xTurn = !xTurn;
      setState(() {});
      checkForAWinner();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("You Can't Ovviride already used cell"),
          backgroundColor: Colors.red[900]));
    }
    int cnt = 0;
    for (int i = 0; i < 9; i++) {
      if (xoBoard[i] == "X" || xoBoard[i] == "O") cnt++;
    }
    if (cnt == 9) {
      resetBoard();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("No Winners"), backgroundColor: Colors.lightBlue[500]));
    }
  }

  String? checkColumns() {
    if (xoBoard[0] == xoBoard[3] && xoBoard[0] == xoBoard[6]) {
      return xoBoard[0];
    } else if (xoBoard[1] == xoBoard[4] && xoBoard[1] == xoBoard[7]) {
      return xoBoard[1];
    } else if (xoBoard[2] == xoBoard[5] && xoBoard[2] == xoBoard[8]) {
      return xoBoard[2];
    }
    return null;
  }

  String? checkRows() {
    if (xoBoard[0] == xoBoard[1] && xoBoard[0] == xoBoard[2]) {
      return xoBoard[0];
    } else if (xoBoard[3] == xoBoard[4] && xoBoard[3] == xoBoard[5]) {
      return xoBoard[3];
    } else if (xoBoard[6] == xoBoard[7] && xoBoard[6] == xoBoard[8]) {
      return xoBoard[6];
    }
    return null;
  }

  String? checkDiagonals() {
    if (xoBoard[0] == xoBoard[4] && xoBoard[0] == xoBoard[8]) {
      return xoBoard[0];
    } else if (xoBoard[2] == xoBoard[4] && xoBoard[2] == xoBoard[6]) {
      return xoBoard[2];
    }
    return null;
  }

  void resetBoard() {
    xoBoard.clear();
    xoBoard = List.generate(9, (index) => '');
    xTurn = true;
  }

  void checkForAWinner() {
    String? columnWinner = checkColumns(),
        rowWinner = checkRows(),
        diagonalWinner = checkDiagonals();
    print(columnWinner);
    print(rowWinner);
    print(diagonalWinner);

    if (columnWinner != null && columnWinner != '') {
      if (columnWinner == 'X') {
        xScore++;
      } else if (columnWinner == 'O') {
        oScore++;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Complete"), backgroundColor: Colors.green[900]));
      resetBoard();
    } else if (rowWinner != null && rowWinner != '') {
      if (rowWinner == 'X') {
        xScore++;
      } else if (rowWinner == 'O') {
        oScore++;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Complete"), backgroundColor: Colors.green[900]));
      resetBoard();
    } else if (diagonalWinner != null && diagonalWinner != '') {
      if (diagonalWinner == 'X') {
        xScore++;
      } else if (diagonalWinner == 'O') {
        oScore++;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Complete"), backgroundColor: Colors.green[900]));
      resetBoard();
    }
    setState(() {});
  }

  _HomePageState()
      : xScore = 0,
        oScore = 0,
        xTurn = true {
    xoBoard = List.generate(9, (index) => '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("XO Game"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "This the turn of: ",
                    style: textStyle,
                  ),
                  Text(
                    xTurn ? 'X' : "O",
                    style: textStyle,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "X Score :",
                            style: textStyle,
                          ),
                          Text(
                            "$xScore",
                            style: textStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "O Score :",
                            style: textStyle,
                          ),
                          Text(
                            "$oScore",
                            style: textStyle,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return ButtonWidget(xoBoard[index], () {
                    onChange(index);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
