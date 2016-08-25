angular
	.module("sudokuApp")
	.factory('sudokuService', ['$http', '$q',

function ($http, $q) {
	var solveSudoku = function(unsolvedPuzzle) {
		if (typeof unsolvedPuzzle == "object") {
			unsolvedPuzzle = parseSudoku(unsolvedPuzzle);
		};

		console.log(unsolvedPuzzle);

		var deferred = $q.defer();
		var queryString = {}
		queryString["sudoku_string"] = unsolvedPuzzle;
		$http.post('/solve', queryString)
			.success(function(data){
				deferred.resolve(data);
			})
			.error(function(err){
				console.log("Error retrieving data from Rails");
				deferred.reject(err);
			});
		return deferred.promise;
	};

	return {
		solveSudoku: solveSudoku
	};

}
]);

function parseSudoku(array) {
	var flattened = _.flatten(array);
	var pluck_value = _.pluck(flattened, "value")
	var mapped = _.map(pluck_value, function(value) { 
		if (value == null){
			return value = '.'
		}
		else {
			return value
		}
	});
	return mapped.join("")
};