
//
onclick = {};

/* focus = 클릭된 태그에 포커스를 주기 위한 분기처리 메소드
 * param(int) = shift 눌림 여부
 * vsClassNm = 선택된 클래스 이름
 * */
onclick.focus = function(param,e){
	
	var vsCompoDvs = $(e.target).attr("compoDvs");
	var vsClassNm = e.target.className;
	
	if(param != 1){ //shift 눌리지 않음
		//
		if(vsCompoDvs == "td"){
			var vitdCount = $(".tableFocus").length;
			if(vitdCount == 0){
				if(vsClassNm.indexOf("creationTd") != -1){
					e.target.className = "tableFocus";
				}
			}
			else if(vitdCount >= 1){
				focusOut.td();
				e.target.className = "tableFocus";
			}
				robot.getAttr("td");
			
		} else if(vsCompoDvs == "div_content"){
			if($(e.target).attr("focus") == "true"){
				
				$(e.target).attr("focus","false"); 
				$(e.target).attr("mainFocus","false"); 
				
			} else if($(e.target).attr("focus") == "false"){
				
				$(e.target).attr("focus","true"); 
				$(e.target).attr("mainFocus","true");
				var divNum = $("#creationTable > div").length;
				
				for(var i=0; i<divNum; i++){
					robot.getAttr("div", i);
				}
			}
			
		} else if(vsCompoDvs == "button"){
			
			if($(e.target).attr("focus") == "true"){
				$(e.target).attr("focus","false"); 
				
			} else if($(e.target).attr("focus") == "false"){
				
				$(e.target).attr("focus","true"); 
				var buttonLength =  $(".button").length;
				for(var i=0; i<buttonLength; i++){
					robot.getAttr("button",i);
				}
			}
			
		} else if(vsCompoDvs == "selectBox"){
			
			if($(e.target).attr("focus") == "true"){
				$(e.target).attr("focus","false"); 
				
			} else if($(e.target).attr("focus") == "false"){
				
				$(e.target).attr("focus","true"); 
				var SelectBoxLength = $(".selectBox").length;
				for(var i=0; i<SelectBoxLength; i++){
					var vsfocus = $("select[name=value"+i+"]").attr("focus");
					robot.getAttr("select",i);
				}
			}
			
		} else if(vsCompoDvs == "inputBox"){
			
			if($(e.target).attr("focus") == "true"){
				$(e.target).attr("focus","false"); 
				
			} else if($(e.target).attr("focus") == "false"){
				
				$(e.target).attr("focus","true"); 
				var inputFocusLength = $(".inputBox").length;
				for(var i=0; i<inputFocusLength; i++){
					var vsfocus = $("input[name=value"+i+"]").attr("focus");
					robot.getAttr("input",i);
				}
			}
			
		} else if(vsCompoDvs == "span_title"){
			
			if($(e.target).attr("focus") == "true"){
				$(e.target).attr("focus","false"); 
				
			} else if($(e.target).attr("focus") == "false"){
				
				$(e.target).attr("focus","true"); 
				var titleNum = $("#creationTable > div > span[class=\"span_title\"]").length;
				for(var i=0; i<titleNum; i++){
					robot.getAttr("title", i);	
				}
				
			}
		}
		
	} else if(param == 1){
		
		if (vsClassNm.indexOf("tableFocus") != -1) {
			e.target.className = "tbtd_content creationTd";
			
		} else if(vsClassNm.indexOf("tbtd_content") != -1){
			e.target.className = "tableFocus";
		}
	}
}

//div_content 개수
vnDivContentCount = 0;

// title 개수
vnTitleCount = 0;

// button 개수
vnButtonCount = 0;

// table 개수
vnTableCount = 0;

// input 개수
vnInputCount = 0;

// select 개수
vnSelectCount = 0;


/* 컴포넌트 생성시 폼크기 동적조정 */
onclick.fn_setformSize = function(){
	var vnFormHeight = Number($("#creationForm").css("height").replace("px",""));
	var vnContentTop = Number($("#creationTable").children().last().css("top").replace("px",""));
	var vnContentHeight = Number($("#creationTable").children().last().css("height").replace("px",""));
	var vnTotalSize = vnContentTop+vnContentHeight+220;
	var vnTableSize = vnContentTop+vnContentHeight+50;
	
	if(vnFormHeight <= vnTotalSize){
		vnFormHeight = vnTotalSize+"px";
		$("#creationForm").css("height",vnFormHeight);
		$("#creationTable").css("height",vnTableSize+"px");
	}
}


//컴포넌트 생성시 위치잡기
onclick.fn_creationPosition = function(param){
	// div focus 여부
	// 포커스가 없다면 body에 생성
	if(!focusOut.divYn()){//focusOut.divYn()
		var voChildInfo = $("#creationTable").children();
		if(voChildInfo.length != 0){
			var vsParentTop = Number(voChildInfo.last().css("top").replace("px",""));
			var vsParentHeight = Number(voChildInfo.last().css("height").replace("px",""));
		}
		
	// 포커스가 있다면 포커스잡힌 div에 생성
	} else{
		
		if(param == "content"){
			var voChildInfo = $("#creationTable").children();
			if(voChildInfo.length != 0){
				var vsParentTop = Number(voChildInfo.last().css("top").replace("px",""));
				var vsParentHeight = Number(voChildInfo.last().css("height").replace("px",""));
			}
		} else{
			var voChildInfo = $(".div_content[mainfocus=true]").children();
			var vnChildCount = voChildInfo.length;
			for(var i=0; i<vnChildCount; i++){
				if(voChildInfo.eq(i).attr("id") == "" || voChildInfo.eq(i).attr("id") == null){
					continue;
				}
				
				var vsParentTop = Number(voChildInfo.eq(i).css("top").replace("px",""));
				var vsParentHeight = Number(voChildInfo.eq(i).last().css("height").replace("px",""));
				
			}
		}
		
		
	}
	
	var vnWidth = 0;
	
	if(vsParentTop == null){
		vsParentTop = 0;
	}
	
	if(vsParentHeight == null){
		vsParentHeight = 0;
	}
	
	if((vsParentTop+vsParentHeight) != 0){
		vnWidth = (vsParentTop+vsParentHeight+20);
	}
	
	return vnWidth;
}


/*
 * draw = 그리기
 * tagName(String) = 태그 이름
 * param(array) 태그에 들어가야하는 데이터 
 * */
onclick.draw = function(tagName, param){

	if(tagName == "div"){
		// 전체 div 시작
		var vsSource = "<div id=\"div" + vnDivContentCount + "\"";
		vsSource += " class=\"div_content\" focus=false mainfocus=false compoDvs=\"div_content\" ";
		vsSource += " style=\"top:"+onclick.fn_creationPosition("content")+"px;\"";
		//vsSource += " onclick=\"fn_divOnClick(this)\"";
		vsSource += " >";

		vsSource += "</div>";

		$("#creationTable").append(vsSource);
		
		// divcontent영역 개수 증가
		vnDivContentCount ++;
		
		
		// form 크기 동적조정
		onclick.fn_setformSize();
		
		// right div 그리기
		//fn_rightDraw();
	}
	else if(tagName == "title"){

		
		// 부모 가로크기
		//var width = $(voFocusDivInfo).css("width");
		// 타이틀 div 시작
		var vsSource = "  <div id=\"div" + vnTitleCount + "_title\"";
		vsSource += "   class=\"div_title\" compoDvs=\"div_title\" ";
		
		vsSource += "   style=\"top:"+onclick.fn_creationPosition()+"px;\"";

		
		//vsSource += "  onclick=\"fn_divTitleOnClick(this)\" ";
		vsSource += ">";
	
		// 타이틀 span
		vsSource += "  <span id=\"span" + vnTitleCount +"_title\" focus=false";
		vsSource += "  class=\"span_title\" compoDvs=\"span_title\" "
		vsSource += "  ondblclick=\"fn_titleOnDblClick(this);\"> Title "   // onclick=\"fn_spanTitleOnClick(this)\"
		vsSource += "  </span>";
		vsSource += "  </div>";
		
		// div focus 여부
		// 포커스가 없다면 body에 생성
		if(!focusOut.divYn()){
			$("#creationTable").append(vsSource);
		// 포커스가 있다면 포커스잡힌 div에 생성
		} else{
			//$(voFocusDivInfo).append(vsSource);
			$(".div_content[mainfocus=true]").append(vsSource);
		}
		
		vnTitleCount++;
		
		onclick.fn_setformSize();
		

	}
	else if(tagName == "input"){
		
		//voFocusTdInfo.textContent = "";
		
		var vsSource = "";
		
		if(!focusOut.tableYn()){
			vsSource += "<br/>"
		}
		
		vsSource += "<input id=\"inputBox"+vnInputCount+"\" type=\"text\" class=\"inputBox\" name=\"value"+vnInputCount+"\" ";
		//onclick=\"fn_InputBoxOnClick(this);\"
		vsSource += "readonly focus=false compoDvs=\"inputBox\" "
		if(!focusOut.tableYn()){
			vsSource += "style=\"text-align:left; top:"+onclick.fn_creationPosition()+"px;\">";
		} else {
			vsSource += "style=\"text-align:left; position:relative;\">";
		}
		vsSource += "</input>";

		// input박스 왼쪽정렬
		$(".tableFocus").css("text-align","left");
		
		
		// table focus 여부
		// 포커스가 없다면 body에 생성
		if(!focusOut.tableYn()){
			// div도 포커스가 없다면
			if(!focusOut.divYn()){
				$("#creationTable").append(vsSource);
			} else{
				$(".div_content[mainfocus=true]").append(vsSource);
			}
			
		// 포커스가 있다면 포커스잡힌 td에 생성
		} else{
			$(".tableFocus").append(vsSource);
		}
		
		vnInputCount++;
		
	}
	else if(tagName == "select"){debugger;
		
		//voFocusTdInfo.textContent = "";
		
		var vsSource = "";
		
		if(!focusOut.tableYn()){
			vsSource += "<br/>"
		}
		vsSource += "<select id=\"selectBox"+vnSelectCount+"\" class=\"selectBox\" name=\"value"+vnSelectCount+"\" ";
		vsSource += "focus=false  ondblclick=\"fn_SelectBoxOnDblClick(this);\" compoDvs=\"selectBox\" ";
		//onclick=\"fn_onclickSelectBox(this)\"
		if(!focusOut.tableYn()){
			vsSource += "style=\"text-align:left; top:"+onclick.fn_creationPosition()+"px;\">";
		} else {
			vsSource += "style=\"text-align:left; position:relative;\">";
		}
		
		vsSource += "</select>";
		
		// input박스 왼쪽정렬
		$(".tableFocus").css("text-align","left");
		
		// table focus 여부
		// 포커스가 없다면 body에 생성
		if(!focusOut.tableYn()){
			// div도 포커스가 없다면
			if(!focusOut.divYn()){
				$("#creationTable").append(vsSource);
			} else{
				$(".div_content[mainfocus=true]").append(vsSource);
			}
			
		// 포커스가 있다면 포커스잡힌 td에 생성
		} else{
			$(".tableFocus").append(vsSource);
		}
		
		vnSelectCount++;	
	}
	else if(tagName == "button"){
		// 부모 가로크기
		//var width = $(voFocusDivInfo).css("width");
	
		// 타이틀 span
		var vsSource = "  <input type=\"button\" id=\"button" + vnButtonCount+"\"";
		vsSource += "  class=\"button\" "
		vsSource += "  value=\"button\" "
		vsSource += "  focus=false compoDvs=\"button\" "
		vsSource += "  style=\"top:"+onclick.fn_creationPosition()+"px;\"";
		vsSource += "  ondblclick=\"fn_buttonOnDblClick(this);\">"; // onclick=\"fn_buttonOnClick(this)\" 
		vsSource += "  </input>";
		
		// div focus 여부
		// 포커스가 없다면 body에 생성
		if(!focusOut.divYn()){
			$("#creationTable").append(vsSource);
		// 포커스가 있다면 포커스잡힌 div에 생성
		} else{
			$(".div_content[mainfocus=true]").append(vsSource);
		}
		
		vnButtonCount++;
		
		// form 크기 동적조정
		onclick.fn_setformSize();
		
		// right div 그리기
		//fn_rightDraw();
	}
	else if(tagName == "table"){
		if(param == "" || param == null){
			return false;
		}
		
		// 부모 가로크기
		//var width = $(voFocusDivInfo).css("width");

		// table 시작
		var vsSource = "<table id=\"table" + vnTableCount + "\"";;
		vsSource += " class=\"table\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" ";
		vsSource += " style=\"top:"+onclick.fn_creationPosition()+"px;\" compoDvs=\"table\" ";
		vsSource += "\n <colgroup>";

		for (var i = 0; i < param[0]; i++) {
			//짝수 셀
			if(i % 2 == 0){
				vsSource += "\n  <col width=\"100\"/>";
			// 홀수 셀
			} else{
				vsSource += "\n  <col width=\"225\"/>";
			}
			
		}
		vsSource += "\n </colgroup>";
		
		//tbody 추가
		vsSource += "\n <tbody>"

		for (var i = 0; i < param[1]; i++) {
			vsSource += "\n <tr name=\"tr\" row=\""+i+"\" compoDvs=\"tr\" >";
			for (var j = 0; j < param[0]; j++) {
				vsSource += "\n  <td class=\"tbtd_content creationTd\" "
				vsSource += "shell=\""+j+"\" ";
				vsSource += "compoDvs=\"td\" ";
				vsSource += "style=\"height:30px;\" "
				vsSource += "ondblclick=\"fn_tdDbClick(this)\"> "
				vsSource += "</td>";
			}
			vsSource += "\n </tr>";
		}
		
		//tbody 추가
		vsSource += "\n </tbody>"

		vsSource += "</table>";
		
		// div focus 여부
		// 포커스가 없다면 body에 생성
		if(!focusOut.divYn()){
			$("#creationTable").append(vsSource);
		// 포커스가 있다면 포커스잡힌 div에 생성
		} else{
			$(".div_content[mainfocus=true]").append(vsSource);
		}

		vnTableCount++;
		
		// form 크기 동적조정
		onclick.fn_setformSize();
		
		// right div 그리기
		//fn_rightDraw();

	}
}












