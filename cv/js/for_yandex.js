	function subscribeClickEvents(){
		subscribeClickEvent("common");
		subscribeClickEvent("prof");
	}
	
	function subscribeClickEvent(type){
		pattern="q-ya__"+type+"-q-";
		$('div[class^='+pattern+']').live("click",function(){
			$(".q-ya__reply").html($(".q-ya__"+type+"-r-"+$(this).attr("value")).html());
		});
	}
	
	function randomOrder(begin, end){
		 var arr = []; 
		 for (var i = begin; i < end+1; i++) {
			 arr[i]=i;
		 }
		 for (var i = begin; i < end+1; i++) {
			 temp=arr[i];
			 x = Math.ceil(begin + Math.random() * (end-begin));
			 arr[i]=arr[x];
			 arr[x]=temp;		 
		 }
		 return arr;
	}
	
	function appear(i,end,type,order){
		setTimeout(function() {	 	
      		$(".q-ya__"+type+"-q-"+order[i]).animate({opacity:1},500);
			if (i<end){
    			appear(i+1,end,type,order);
			}
  		}, 500);
	}