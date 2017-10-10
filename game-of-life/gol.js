/*
More hardcore example with row-by-row processing
*/

let row1 = null;
let row2 = null;

function getNextRow(boardRow) {
  let newRow = [];
  
  if (!row1) {
    row1 = boardRow;
    return null;
  } else if(!row2) {
    row2 = boardRow;
    
    for(let c = 0; c <= row1.length - 1; c++) {
      newRow[c] = newCellState([row1, row2], 0, c);
    }
      
    row1 = row2;
  } else if(!boardRow) {
    for(let c = 0; c <= row1.length - 1; c++) {
      newRow[c] = newCellState([row1, row2], 1, c);
    }
  } else {
    let row3 = boardRow;
    for(let c = 0; c <= row1.length - 1; c++) {
      newRow[c] = newCellState([row1, row2, row3], 1, c);
    }
    row1 = row2;
    row2 = row3;
  }
  
  return newRow;
}

function newCellState(boardState, row, col) {
  const aliveN = aliveNeighbours(boardState, row, col);
  
  if (boardState[row][col] == 1) {
    if (aliveN < 2) { return 0; }
    if (aliveN > 3) { return 0; }
    return 1;
  } else {
    if (aliveN == 3) { return 1; }
    return 0;
  }
}

function aliveNeighbours(boardState, row, col) {
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


function runStep(board) {
    row1 = null;
    row2 = null;

    let newBoard = [];
    for (let r = 0; r <= board.length; r ++) {
      if(r == 0) {
        getNextRow(board[r]);
      } else if(r == board.length) {
        newBoard[r - 1] = getNextRow(null);
      } else {
        newBoard[r - 1] = getNextRow(board[r]);
      }
    }
    return newBoard;
}

function iterate(steps, board) {
    if(steps < 0) { return; }

    const newBoard = runStep(board);
    newBoard.forEach(row => {
        console.log(row.join(" "));
    });
    console.log("-----------");
    
    iterate(steps - 1, newBoard);
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

iterate(10, board1);

console.log("done");
