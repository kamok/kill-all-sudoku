angular
	.module("sudokuApp")
	.controller("sudokuCtrl", ['$scope', 'sudokuService',

function($scope, sudokuService) {

	function solve(unsolvedPuzzle) {
		sudokuService.solveSudoku(unsolvedPuzzle).then(function(solvedPuzzle){
			$scope.solved = solvedPuzzle['solution']
		});
	};

	$scope.solveMe = function(unsolvedPuzzle) {
		solve(unsolvedPuzzle);
	};

	solve('.94...13..............76..2.8..1.....32.........2...6.....5.4.......8..7..63.4..8');
}
]);