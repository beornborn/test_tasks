function put_main(){
	$("#content").html($(".main").html());
}

function RunTyping (text, l,counter, side){
	 rnd = Math.random();
	 var delay  = 10;
	 if (rnd<0.05){
		delay=delay*rnd*5000;	
	 } else {
		delay = 100*Math.random();
	 }
 
 	setTimeout(function() {	 
    	if (counter++ < l) {
      		$(".background__"+side+"-column").append(text[counter])
      		RunTyping(text,l, counter, side);
    	} else {
			counter=0;
			$(".background__"+side+"-column").html("");
			RunTyping(text,l, counter, side);
		}
  	}, delay);
}

function buttonEventsSubscribe(){
	$(".prof-exp__project-act-gotfibs-show").live('click', function(){
		$(".prof-exp__project-act-content-gotfibs").slideToggle();
	});

	$(".prof-exp__project-act-docomo-show").live('click', function(){
		$(".prof-exp__project-act-content-docomo").slideToggle();
	});
	
	$(".menu__button-container-button").click(function(){
		$(".menu__button-container-button-state-active").removeClass("menu__button-container-button-state-active");
		$(this).addClass("menu__button-container-button-state-active");
		source=$(this).attr('source');
		$("#content").html($("."+source).html());
	});
}