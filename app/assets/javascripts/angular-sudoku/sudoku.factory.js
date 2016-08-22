angular
	.module("sudokuApp")
	.factory('sudokuService', ['$http', '$q',

function ($http, $q) {
	var solveSudoku = function(unsolvedPuzzle) {
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