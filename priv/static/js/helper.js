$(document).ready(function(){
	var ele = document.getElementById('editor');
	if (ele) {
		var editor = new Editor({element: ele});
  		editor.render();
	}

	$(".markdown-text").each(function() {
		var htmlWithEmoji = replaceEmoji($(this).html());
		$(this).html(marked(htmlWithEmoji));
	});

	$(".reply-link").click(function(){
	    var uid = $(this).attr("data-uid");
	    var content = "[@" + $(this).attr("data-uname") +  "](/users/" + uid + ") ";
	    editor.codemirror.replaceRange(content, {line: Infinity});

	    setTimeout(function() {
		    editor.codemirror.codeMirrorInstance.refresh();
		},1);
	});

	function replaceEmoji(text) {
		return text.replace(/:(smile|iphone|girl|smiley|heart|kiss|copyright|coffee|a|ab|airplane|alien|ambulance|angel|anger|angry|arrow_forward|arrow_left|arrow_lower_left|arrow_lower_right|arrow_right|arrow_up|arrow_upper_left|arrow_upper_right|art|astonished|atm|b|baby|baby_chick|baby_symbol|balloon|bamboo|bank|barber|baseball|basketball|bath|bear|beer|beers|beginner|bell|bento|bike|bikini|bird|birthday|black_square|blue_car|blue_heart|blush|boar|boat|bomb|book|boot|bouquet|bow|bowtie|boy|bread|briefcase|broken_heart|bug|bulb|person_with_blond_hair|phone|pig|pill|pisces|plus1|point_down|point_left|point_right|point_up|point_up_2|police_car|poop|post_office|postbox|pray|princess|punch|purple_heart|question|rabbit|racehorse|radio|up|us|v|vhs|vibration_mode|virgo|vs|walking|warning|watermelon|wave|wc|wedding|whale|wheelchair|white_square|wind_chime|wink|wink2|wolf|woman|womans_hat|womens|x|yellow_heart|zap|zzz|\+1|\-1):/g,
			"![emoji](https://assets-cdn.github.com/images/icons/emoji/$1.png)");
	}
});