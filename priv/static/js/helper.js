$(document).ready(function(){
	var ele = document.getElementById('editor');
	if (ele) {
		var editor = new Editor({element: ele});
  		editor.render();
	}

	$(".markdown-text").each(function() {
		$(this).html(marked($(this).html()));
	});

	$(".reply-link").click(function(){
	    var uid = $(this).attr("data-uid");
	    var content = "[@" + $(this).attr("data-uname") +  "](/users/" + uid + ")";
	    editor.codemirror.replaceRange(content, {line: Infinity});

	    setTimeout(function() {
		    editor.codemirror.codeMirrorInstance.refresh();
		},1);
	});
});