/**
 * 
 */
robot = {};

/* prompt - 프롬프트를 실행한다.
 * msg : 메시지 내용(String)
 * ele : prompt 요소(Arrary)
 * btn1 : 버튼1 name(String)
 * btn2 : 버튼2 name(String)
 * callBack : callback함수(String)
 * */
robot.prompt = function(msg, ele, btn1, btn2, callBack){
	
	if(typeof(ele) != "object"){
		robot.alert("프롬프트 메소드 에러","");
		return false;
	}
	var vsSource = "<h3>"+msg+"</h3><br><br>";
	for(var i=0; i<ele.length; i++){
		vsSource += "<span>"+ele[i]+" : "+"</span>";
		vsSource += "<input class=\"prompt_input\" type=\"text\"></input><br><br>";
	}
	
	vsSource += "<br>"
	
	if(btn1 == null || btn1 == ""){
		btn1 = "확인";
	}
	if(btn2 == null || btn2 == ""){
		btn2 = "취소";
	}
	
	vsSource += "<input type=\"button\" style=\"width:30px; height:20px;\" value=\""+btn1+"\" onclick=\"robot.promptOnclick("+callBack+")\"></input>";
	vsSource += "<input type=\"button\" style=\"width:30px; height:20px;\" value=\""+btn2+"\" onclick=\"robot.closePop('',"+callBack+")\"></input>";
	
	var info = {"header" : "prompt"};
	robot.openPop(info,callBack, vsSource,"tag");
}

robot.promptOnclick = function(callBack){
	var voClassInfo = $(".prompt_input");
	var voClassValue = [];
	for(var i=0; i<voClassInfo.length; i++){
		if(voClassInfo.eq(i).val() == ""){
			robot.alert("행과 열을 올바르게 입력하여 주시기 바랍니다.");
			return false;
		}
		voClassValue.push(voClassInfo.eq(i).val());
	}
	
	robot.closePop(voClassValue, callBack);
	
}


/* alert - alert창을 실행
 * msg : 메시지 내용(String)
 * btn : 버튼 name(String)
 * callBack : callback함수(String)
 * */
robot.alert = function(msg, btn, callBack){

	var vsSource = "<h3>"+msg+"</h3><br><br>";
	vsSource += "<br>"
	
	if(btn == null || btn == ""){
		btn = "확인";
	}
	
	vsSource += "<input type=\"button\" style=\"width:30px; height:20px;\" value=\""+btn+"\" onclick=\"robot.closePop(true,"+callBack+")\"></input>";
	
	
	var info = {"header" : "alert"};
	robot.openPop(info,callBack, vsSource,"tag");
}



/* openPop - 팝업을 오픈한다.
 * info : header헤더에 표시될 내용(string)
 * ele : prompt 요소(arrary)
 * url : 팝업에 표시될 url내용(String)
 * urlDvs : jsp를 호출할지 tag를 직접입력할지 여부(String)
 *        - tag경우에 append, url인경우 load
 * */
robot.openPop = function(info,callBack, url, urlDvs){

	var header = info.hedaer;
	var width = info.width;
	var height = info.height;
	
	if(typeof(header) == "undefined"){
		header = "popUp";
	}
	
	if(typeof(width) == "undefined"){
		width = "400px";
	} else if(typeof(width) == "number"){
		width += "px";
	}
	
	if(typeof(height) == "undefined"){
		height = "250px";
	} else if(typeof(height) == "number"){
		height += "px";
	}
	
	
	var div_popCount = $(".div_pop").length;

	var info= "<div id=\"div_pop"+div_popCount+"\" class=\"div_pop\" style=>";
	info += "    <div id=\"div_pop_content"+div_popCount+"\" class=\"div_pop_content\" style=\"width:"+width+"; height:"+height+"\">";
	info += "      <div style=\"height:30px; background-color:#6666CC; text-align:left; \">";
	info += "      <span style=\"font-size:15pt; color:black; font-weight:bold; height:30px;\">"+header+"</span>";
	info += "      <input type=\"button\" value=\"X\" style=\"float:right; background-color:#6666CC; height:100%; width:30px; font-size:15pt;\"";
	info += "      onclick=\"robot.closePop('',"+callBack+");\">";
	info += "      </div>";
	info += "      <div id=\"pop_content"+div_popCount+"\" class=\"pop_content\">";
	info += "      </div>";
	info += "    </div>";
	info += "</div>";


	$("body").append(info);
	
	
	if(urlDvs == "tag"){
		$("#pop_content"+div_popCount).append(url);
	} else {
		$("#pop_content"+div_popCount).load("./ws/pop/"+url);
	}
	
}

/* closePop - 팝업을 닫는다.
 * param : 콜백함수로 보내질 param값(Object)
 * callBack : callBack 함수(String)
 * */
robot.closePop = function(param, callBack){

	var div_popCount = ($(".div_pop").length)-1;
	$("#div_pop"+div_popCount).remove();
	
	if(callBack != null && callBack != "" && typeof(callBack) == "function"){
		callBack(param);
	}
}

