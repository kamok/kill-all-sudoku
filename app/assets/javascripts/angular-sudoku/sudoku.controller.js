angular
	.module("sudokuApp")
	.controller("sudokuCtrl", ['$scope', 'sudokuService',

function($scope, sudokuService) {

	function solve(unsolvedPuzzle) {
		sudokuService.solveSudoku(unsolvedPuzzle).then(function(solvedPuzzle){
			var output = [];
			if (solvedPuzzle['solution']) {
				var sNumber = solvedPuzzle['solution'].toString();
				for (var i = 0; i < sNumber.length; i += 1) {
			  output.push({value: +sNumber.charAt(i)});
				};

				var nestedArray = [];

				for (var i = 0; i < 9 ; i += 1) {
					var a = output.splice(0,9);
					nestedArray.push(a);
				};

				$scope.board = nestedArray;
			};

			$scope.error = solvedPuzzle['error'];
		});
	};

	$scope.solveMe = function(unsolvedPuzzle) {
		solve(unsolvedPuzzle);
	};

	$scope.clearBoard = function() {
		var board = [];
		var empty = { value: null };

		_(9).times(function() {
			var row = [];
			_(9).times(function() {
				row.push(_.clone(empty))
			});
			board.push(row)
		});

		$scope.board = board;
	};

	$scope.defaultPuzzle = function() {
		$scope.board = [[{"value":3},{"value":9},{"value":null},{"value":8},{"value":2},{"value":null},{"value":7},{"value":null},{"value":null}],[{"value":8},{"value":null},{"value":1},{"value":5},{"value":null},{"value":null},{"value":null},{"value":6},{"value":9}],[{"value":null},{"value":2},{"value":null},{"value":1},{"value":6},{"value":null},{"value":4},{"value":null},{"value":3}],[{"value":null},{"value":null},{"value":2},{"value":null},{"value":9},{"value":6},{"value":null},{"value":5},{"value":8}],[{"value":9},{"value":3},{"value":5},{"value":null},{"value":null},{"value":null},{"value":6},{"value":null},{"value":2}],[{"value":null},{"value":6},{"value":null},{"value":7},{"value":5},{"value":2},{"value":null},{"value":3},{"value":null}],[{"value":7},{"value":null},{"value":3},{"value":9},{"value":4},{"value":1},{"value":null},{"value":null},{"value":null}],[{"value":2},{"value":null},{"value":null},{"value":null},{"value":3},{"value":7},{"value":5},{"value":9},{"value":null}],[{"value":null},{"value":1},{"value":9},{"value":null},{"value":null},{"value":null},{"value":3},{"value":4},{"value":7}]];
	}
	
}
]);