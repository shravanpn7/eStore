/**
 * New node file
 */

function rem(pid,uid){
	console.log("remove");
	$.ajax({
		type : "POST",
		url : "http://localhost:8080/eStore/myrest/sc/remove/"+pid+"?buyerid="+uid,
		success : function(data) {
			console.log("success");
			console.log(data);
		},
		error : function() {
			console.log("error");
		}
	});
	
	return false;
};