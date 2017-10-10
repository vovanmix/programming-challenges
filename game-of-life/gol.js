/*
More hardcore example with row-by-row processing
*/

function GameOfLifeStep() {
    this.row1 = null;
    this.row2 = null;

    this.getNextRow = function (boardRow) {
      let newRow = [];

      if (!this.row1) {
        this.row1 = boardRow;
        return null;
      } else if(!this.row2) {
        this.row2 = boardRow;

        for(let c = 0; c <= this.row1.length - 1; c++) {
          newRow[c] = this.newCellState([this.row1, this.row2], 0, c);
        }

        this.row1 = this.row2;
      } else if(!boardRow) {
        for(let c = 0; c <= this.row1.length - 1; c++) {
          newRow[c] = this.newCellState([this.row1, this.row2], 1, c);
        }
      } else {
        let row3 = boardRow;
        for(let c = 0; c <= this.row1.length - 1; c++) {
          newRow[c] = this.newCellState([this.row1, this.row2, row3], 1, c);
        }
        this.row1 = this.row2;
        this.row2 = row3;
      }

      return newRow;
    }

    this.newCellState = function (boardState, row, col) {
      const aliveN = this.aliveNeighbours(boardState, row, col);

      if (boardState[row][col] == 1) {
        if (aliveN < 2) { return 0; }
        if (aliveN > 3) { return 0; }
        return 1;
      } else {
        if (aliveN == 3) { return 1; }
        return 0;
      }
    }

    this.aliveNeighbours = function (boardState, row, col) {
      let alive = 0;

      for(let r = row - 1; r <= row + 1; r++) {
        for(let c = col - 1; c <= col + 1; c++) {
          if (r < 0 || c < 0) { continue; }
          if (r >= boardState.length || c >= boardState[row].length) { continue; }
          if (r == row && c == col) { continue; }

          alive += boardState[r][c];
        }
      }
      return alive;
    }
}

function GameOfLife(board) {
    this.board = board;
    
    this.runStep = function () {
        const step = new GameOfLifeStep();

        let newBoard = [];
        for (let r = 0; r <= this.board.length; r ++) {
          if(r == 0) {
            step.getNextRow(this.board[r]);
          } else if(r == this.board.length) {
            newBoard[r - 1] = step.getNextRow(null);
          } else {
            newBoard[r - 1] = step.getNextRow(this.board[r]);
          }
        }
        return newBoard;
    }

    this.iterate = function (steps) {
        if(steps < 0) { return; }

        this.board = this.runStep();
        this.board.forEach(row => {
            console.log(row.join(" "));
        });
        console.log("-----------");

        this.iterate(steps - 1);
    }
}



// --------------

const board1 = [
  [1,1,1,0,1],
  [1,0,1,1,0],
  [1,0,1,1,1],
  [1,0,1,0,0],
  [1,0,1,1,0],
  [1,1,1,1,1],
];

const game = new GameOfLife(board1);
game.iterate(10);

console.log("done");
