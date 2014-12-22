$(document).ready(function(){
	var ele = document.getElementById('editor');
	if (ele) {
		var editor = new Editor({element: ele});
  		editor.render();
	}
});