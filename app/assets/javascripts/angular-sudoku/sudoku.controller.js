angular
	.module("sudokuApp")
	.controller("sudokuCtrl", ['$scope', 'sudokuService',

function($scope, sudokuService) {

	function solve(unsolvedPuzzle) {
		sudokuService.solveSudoku(unsolvedPuzzle).then(function(solvedPuzzle){
			var output = [];
			var sNumber = solvedPuzzle['solution'].toString();

			for (var i = 0; i < sNumber.length; i += 1) {
			  output.push(+sNumber.charAt(i));
			}

			var nestedArray = []

			for (var i = 0; i < 9 ; i += 1) {
				var a = output.splice(0,9)
				nestedArray.push(a);
			}

			$scope.solved = nestedArray
		});
	};

	$scope.solveMe = function(unsolvedPuzzle) {
		solve(unsolvedPuzzle);
	};

	solve('.94...13..............76..2.8..1.....32.........2...6.....5.4.......8..7..63.4..8');
}
]);