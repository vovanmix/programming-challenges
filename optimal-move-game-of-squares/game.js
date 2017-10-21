/*
  Game of squares
  Two players
  Turn: Subtracting a perfect square from the current state
  State: Always a non-negative integer
*/
function getOptimalMove(currentState, memo) {
    if(memo[currentState] != undefined) { return memo[currentState]; }
    
    let counter = 1;
    while(counter * counter <= currentState) {
        const square = counter * counter;
        const remainder = currentState - square;
        if (getOptimalMove(remainder, memo) == -1) {
            memo[currentState] = square;
            return memo[currentState];
        }
        counter += 1;
    }
    memo[currentState] = -1;
    return memo[currentState];
}

const memo = {};
console.log(getOptimalMove(20, memo));
console.log(getOptimalMove(1, memo));
console.log(getOptimalMove(4, memo));
console.log(getOptimalMove(1000, memo));

/*
  time complexity: O(n * sqrt(n))
  bc number of squares inside of K is sqrt(K)
  and the depth of the tree in the worst case is N
*/
