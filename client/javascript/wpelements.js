
function loadPage(pageurl,func){
    $.ajax({
      url: pageurl+"?callback=?", //makes it jsonp
      success: func
    });
}

wpElements = {
	getLastPost: function(server,func){
		loadPage(server + "/lastpost",function(jsondata){
			var obj = $.parseJSON(jsondata);
			func(obj);
		});
	},
	getPost: function(server,postId,func){
		loadPage(server + "/post/" + postId,function(jsondata){
			var obj = $.parseJSON(jsondata);
			func(obj);
		});
	}
}
