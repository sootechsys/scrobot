<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scrobot_공통사이드바</title>
 

	<style>
		/* 사이드바 스타일 */
		.sidenav {
			height:100%;
			position: fixed;
			z-index:1;
			top: 0;
			left: 0;
			margin-top:50px;
			background-color: #97d5e0;
			overflow-x: hidden;
			transition:0.5s ease-in-out;
			width:320px;
			/* padding-top: 60px; */
		}
		.sidenav tr {
			padding: 10px 10px 10px 10px;
			text-decoration: none;
			/* font-size: 25px; */
			color: #fff;
			display: block;
			transition: 0.2s ease-in-out;
		}
		.sidenav table{
			/* margin:auto; */
			width:100%;
		}
		
		.sidenav table thead tr th{
			margin:auto;
			
		}
		
		.sidenav tbody{
			width:80%;
		}
		.sidenav td{
			width:50px;
			height:20px;
			
		}
		
		.JCLRgrip{
			cursor:ew-resize;
		}
		
		/* 미디어쿼리 적용 */

/* #propertyTable{
	width:100%; 
	border: 1px solid #444444; 
	align: center;
	border-collapse: collapse;
	background-color: white;					
} */

#propertyTable tr {
	 border: 1px solid #444444;
}




</style>
<script type="text/javaScript">


//포커스잡힌 td의 정보
  voFocusTdInfo = "";

  // 포커스잡힌 div의 정보
  voFocusDivInfo = "";

  // 선택된 컴포넌트 종류
  vsCompoClickDvs = "";

  // div_content 개수
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

  // outline 제자리 복귀시 rownum
  vnSortNum = 0;
  
  vbTitleDragCheck = false;
  vbButtonDragCheck = false;


  $(function(){
	  
	  
  	

  	

  });
  
  
  
  /************************************* 
   * accordion 관련 함수
   **************************************/
    fn_draggable = function(){
  	  $( ".div_content" ).draggable({ cursor: "move",
  									  grid: [ 10, 10 ],
  									  stop: function( event, ui ) {/* 1188 */
  										  
  										var voChild = $("#creationTable").children();
  										
  										var vnTotalLeft = 0;
  										var vnTotalTop = 0;
  										for(var i=0; i<voChild.length; i++){
  											if(voChild.eq(i).attr("id") != ""){
  												var vnLeft = Number(voChild.eq(i).css("left").replace("px",""));
  												var vnWidth = Number(voChild.eq(i).width());
  												
  												var vnTop = Number(voChild.eq(i).css("top").replace("px",""));
  												var vnHeight = Number(voChild.eq(i).height());
  												
  												if(vnTotalLeft < vnLeft+vnWidth){
  													vnTotalLeft = vnLeft+vnWidth;
  												}
  												
  												if(vnTotalTop < vnTop+vnHeight){
  													vnTotalTop = vnTop+vnHeight;
  												}
  											}
  										}
  										
  										if(vnTotalLeft >  $("#creationForm").width()){
  											var vsFormLeft = (ui.offset.left+500)+"px";
    										  var vsTableLeft = (ui.offset.left+430)+"px";
    									  	  $("#creationForm").css("width",vsFormLeft);
    									  	  
    									  	  $("#creationTable").css("width",vsTableLeft);
  										}
  										
  										if(vnTotalTop+200 >  $("#creationForm").height()){
  											var vsFormTop = (ui.offset.top+600)+"px";
    										  var vsTableTop = (ui.offset.top+430)+"px";
    									  	  $("#creationForm").css("height",vsFormTop);
    									  	  
    									  	  $("#creationTable").css("height",vsTableTop);
  										}
  										  
  										  
  									  }
  	  });
  	  $( ".div_content" ).resizable();
  	  $( ".div_content" ).droppable({
/*         drop: function( event, ui ) {
        
            if(ui.draggable.attr("class").indexOf("div_content") == -1){
            	
            	var vnTop = Number(ui.draggable.css("top").replace("px",""));
            	var vnOldParentTop = Number(ui.draggable.parent().css("top").replace("px",""));
    			var vnNewParentTop = Number($( this ).css("top").replace("px",""));
    			
            	
        		if(ui.draggable.parent().attr("id") == "creationTable"){
        		
        			
        			
        			ui.draggable.css("top",(vnTop-vnNewParentTop-30)+"px")

        		} else {
        			
        			ui.draggable.css("top",(vnOldParentTop-vnNewParentTop+vnTop)+"px")
        		}
        		
        		$( this ).append(ui.draggable);
        		

        		
        	}
        
        } */
      });
  	  
  	  
  	$( "#creationTable" ).droppable({
        drop: function( event, ui ) {
        
	        if(ui.draggable.attr("class").indexOf("div_content") == -1){
	        		
	            var voContent = $(".div_content");
	            var vnContLength = voContent.length;
	            
	            // 부모 아이디
	            var vsParentId = ui.draggable.parent().attr("id");
	            
	         	// 부모 클래스
	            var vsParentClass = ui.draggable.parent().attr("class");
	            
	            // 움직인곳의 세로높이
	            var vnCurrTop = Number(ui.draggable.css("top").replace("px",""));
	            
	         	// 움직인곳의 가로높이
	            var vnCurrLeft = Number(ui.draggable.css("left").replace("px",""));
	         	
	         	var vsDivYn = "N";
	        	var vnDivRow = 0;
	        	
	        	
	        	
	        	
	            if(vsParentClass != null){
	            	// 출발한 곳이 안이라면
	            	if(vsParentClass.indexOf("div_content") != -1){
	            		// 출발한 div의 높이
		            	var vnOldParentTop = Number(ui.draggable.parent().css("top").replace("px",""));
		            	
		            	// 출발한 div의 폭
		            	var vnOldParentLeft = Number(ui.draggable.parent().css("left").replace("px",""));
		            	vnCurrTop += vnOldParentTop;
		            	vnCurrLeft += vnOldParentLeft;
	            	}
	            	
	            }
	            
	         	// div_content 개수 동안 반복
	         	for(var i=0; i<vnContLength; i++){
	         		var top = Number(voContent.eq(i).css("top").replace("px",""));
            		var height = Number(voContent.eq(i).css("height").replace("px",""));
            		var left = Number(voContent.eq(i).css("left").replace("px",""));
            		var width = Number(voContent.eq(i).css("width").replace("px",""));
            		
            		
            		
            		// 도착한 곳이 div 안이라면(밖->안)
	                if(vnCurrTop < top+height && vnCurrTop > top &&
	                   vnCurrLeft < left+width && vnCurrLeft > left){
	                	
	                	vsDivYn = "Y";
	                }
            		
            		
    	            if(vsDivYn == "Y"){
    	            	vnDivRow = i;
    	            	break;
    	            }
            		
            		
            		
	         	}
	         	
	         	
	         	
	            
	         	
	         	
	         	
	            // 출발한 곳이 밖이라면
	            if(vsParentId == "creationTable"){
	            		
	            	
	            	// 움직인곳이 div 안으로 이동했다면(밖->안)
	            	if(vsDivYn == "Y"){
	            		// 도착한 div의 높이
	        			var vnNewParentTop = Number(voContent.eq(vnDivRow).css("top").replace("px",""));
	        			// 도착한 div의 폭
	        			var vnNewParentLeft = Number(voContent.eq(vnDivRow).css("left").replace("px",""));
	        			
            			ui.draggable.css("top",(vnCurrTop-vnNewParentTop-30)+"px")
            			ui.draggable.css("left",(vnCurrLeft-vnNewParentLeft-30)+"px")
            			
            			voContent.eq(vnDivRow).append(ui.draggable);
            			
	            	
	            	// 움직인곳이 밖으로 이동했다면(밖->밖)
	            	} else{
	            		// 아무액션 필요없음
	            	}
	            
	            // 출발한 곳이 div 안일경우
	            } else{
	            	
	            	
	            	
            		
	            	
            		// 도착한 곳이 div 안이라면(안->안)
	            	if(vsDivYn == "Y"){
	            		
	            		// 도착한 div의 높이
	        			var vnNewParentTop = Number(voContent.eq(vnDivRow).css("top").replace("px",""));
	        			// 도착한 div의 폭
	        			var vnNewParentLeft = Number(voContent.eq(vnDivRow).css("left").replace("px",""));
	        			
            			ui.draggable.css("top",(vnCurrTop-vnNewParentTop)+"px")
            			ui.draggable.css("left",(vnCurrLeft-vnNewParentLeft)+"px")
            			voContent.eq(vnDivRow).append(ui.draggable);
	            	
	            	// 도착한 곳이 div 밖이라면(안->밖)
	            	} else{
	            		
	            		
	            		ui.draggable.css("top",(vnCurrTop+30)+"px")
	            		ui.draggable.css("left",(vnCurrLeft+30)+"px")
	            		$( this ).append(ui.draggable);
	            	}
	            	
	            }
	         	
	         	
	            
	        		
	        
	        }
        }
  	 });
  	
   	  $( ".table" ).resizable();
  	  
  	  $( ".table" ).draggable({ cursor: "move",
		    grid: [ 10, 10 ]
				}); 

	  
  	  $( ".div_title" ).draggable({ cursor: "move",
  		  						    grid: [ 10, 10 ],
  		  						    stop: function(){
  		  			                   vbTitleDragCheck = true;
  		  			   				}});
  	  
  	  $(".button").draggable({ cancel:false,
  	     					   cursor: "move",
			    			   grid: [ 10, 10 ],
  		                       stop: function(){
		  			               vbButtonDragCheck = true;
		  			   		}});
    }
    
    $( "#sortable" ).on( "sortupdate", function( event, ui ) {} );
	
	
	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 그리기 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */

	
	
	// 컴포넌트 생성시 위치잡기
	fn_creationPosition = function(param){
		// div focus 여부
		// 포커스가 없다면 body에 생성
		if(!fn_divFocusYn()){
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
				var voChildInfo = $(voFocusDivInfo).children();
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
	
	
	/* 컴포넌트 생성시 폼크기 동적조정 */
	fn_setformSize = function(){
		var vnFormHeight = Number($("#creationForm").css("height").replace("px",""));
		var vnContentTop = Number($("#creationTable").children().last().css("top").replace("px",""));
		var vnContentHeight = Number($("#creationTable").children().last().css("height").replace("px",""));
		var vnTotalSize = vnContentTop+vnContentHeight+220;
		var vnTableSize = vnContentTop+vnContentHeight+50;
		
		if(vnFormHeight <= vnTotalSize){
			vnFormHeight = vnTotalSize+"px";
			$("#creationForm").css("height",vnFormHeight)
			$("#creationTable").css("height",vnTableSize+"px")
		}
	}
	
	
	/* DIV 만들기 */
	function divCreation() {
		
		// 전체 div 시작
		var vsSource = "<div id=\"div" + vnDivContentCount + "\"";;
		vsSource += " class=\"div_content\" ";
		vsSource += " style=\"top:"+fn_creationPosition("content")+"px;\"";
		vsSource += " onclick=\"fn_divOnClick(this)\"";
		vsSource += " >";

		vsSource += "</div>";

		$("#creationTable").append(vsSource);
		
		// divcontent영역 개수 증가
		vnDivContentCount ++;
		
		
		// form 크기 동적조정
		fn_setformSize();
		
		// right div 그리기
		//fn_rightDraw();
	};
	

	
	
	/* TITLE 만들기 */
	function titleCreation() {
		
		
		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");
		// 타이틀 div 시작
		var vsSource = "  <div id=\"div" + vnTitleCount + "_title\"";
		vsSource += "   class=\"div_title\"";
		
		vsSource += "   style=\"top:"+fn_creationPosition()+"px;\"";

		
		vsSource += "  onclick=\"fn_divTitleOnClick(this)\" ";
		vsSource += ">";
	
		// 타이틀 span
		vsSource += "  <span id=\"span" + vnTitleCount + "_title\"";
		vsSource += "  class=\"span_title\" "
		vsSource += "  onclick=\"fn_spanTitleOnClick(this)\"> Title "
		vsSource += "  </span>";
		vsSource += "  </div>";
		
		// div focus 여부
		// 포커스가 없다면 body에 생성
		if(!fn_divFocusYn()){
			$("#creationTable").append(vsSource);
		// 포커스가 있다면 포커스잡힌 div에 생성
		} else{
			$(voFocusDivInfo).append(vsSource);
		}
		
		
		
		vnTitleCount++;
		
		// form 크기 동적조정
		fn_setformSize();
		
		// right div 그리기
		//fn_rightDraw();

	};
	
	
	/* button 만들기 */
	function buttonCreation() {

		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");
	
		// 타이틀 span
		var vsSource = "  <input type=\"button\" id=\"button" + vnButtonCount+"\"";
		vsSource += "  class=\"button\" "
		vsSource += "  value=\"button\" "
		vsSource += "  style=\"top:"+fn_creationPosition()+"px;\"";
		vsSource += "  onclick=\"fn_buttonOnClick(this)\">"
		vsSource += "  </input>";
		
		// div focus 여부
		// 포커스가 없다면 body에 생성
		if(!fn_divFocusYn()){
			$("#creationTable").append(vsSource);
		// 포커스가 있다면 포커스잡힌 div에 생성
		} else{
			$(voFocusDivInfo).append(vsSource);
		}
		
		vnButtonCount++;
		
		// form 크기 동적조정
		fn_setformSize();
		
		// right div 그리기
		//fn_rightDraw();

	};
	

	
	
	
	/* 테이블그리기 */
	function tableCreation() {
		
		robot.prompt("행과 열의 갯수를 지정하십시오.", ["행","열"],"생성","취소","fn_tableCreationCallBack");

	};
	
	
	/* 테이블그리기 CallBack */
	fn_tableCreationCallBack = function(param) {

		if(param == "" || param == null){
			return false;
		}
		
		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");

		// table 시작
		var vsSource = "<table id=\"table" + vnTableCount + "\"";;
		vsSource += " class=\"table\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" ";
		vsSource += " style=\"top:"+fn_creationPosition()+"px;\"";
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
			vsSource += "\n <tr name=\"tr\" row=\""+i+"\">";
			for (var j = 0; j < param[0]; j++) {
				vsSource += "\n  <td class=\"tbtd_content creationTd\" "
				vsSource += "shell=\""+j+"\"";
				vsSource += "style=\"height:30px;\" "
				vsSource += "onclick=\"fn_tdOnClick(this)\" "
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
		if(!fn_divFocusYn()){
			$("#creationTable").append(vsSource);
		// 포커스가 있다면 포커스잡힌 div에 생성
		} else{
			$(voFocusDivInfo).append(vsSource);
		}

		vnTableCount++;
		
		// form 크기 동적조정
		fn_setformSize();
		
		// right div 그리기
		//fn_rightDraw();

	};

	
	
	
	/* input박스 그리기 */
	function inputCreation() {

		fn_tableFocusYn();
		voFocusTdInfo.textContent = "";
		var vsInputSource = "<input type=\"text\" class=\"inputBox\" name=\"value"+vnInputCount+"\" ";
		vsInputSource += "readonly style=\"text-align:left\">";
		vsInputSource += "</input>";

		$(".tableFocus").append(vsInputSource);
		voFocusTdInfo.className = "tbtd_content creationTd";
		
		// input박스 왼쪽정렬
		$(voFocusTdInfo).css("text-align","left");
		
		vnInputCount++;
		
	};

	
	
	/* select박스 그리기 */
	function selectCreation() {

		fn_tableFocusYn();
		var vsSelectSource = "<select class=\"selectBox\" name=\"value"+vnSelectCount+"\"";
		vsSelectSource += "style=\"width:100px;\""
		vsSelectSource += "></select>";

		$(".tableFocus").append(vsSelectSource);
		voFocusTdInfo.className = "tbtd_content creationTd";
		
		vnSelectCount++;
	};
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 그리기 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */

	
	
	
	
	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ click 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	//shift 클릭으로 포커스 주입을 위한 전역변수 ( 0<안눌림> / 1<눌림> )
	var shiftHold = 0;
	$(document).ready(function(){
		
		$("body").keydown(function (e){
			// shift
			if(e.keyCode == 16){
				shiftHold = 1;
			}
			// delete
			if(e.keyCode == 46){
				// 현재 포커스를 가지고있는 객체를 삭제한다.
				var voRightInfo = $("[orgId="+$("[focus=true]").attr("id")+"]");
				if(voRightInfo.attr("level") == "1"){
					$("[parent="+voRightInfo.attr("id")+"]").remove();
					voRightInfo.remove();
				} else{
					voRightInfo.remove();
				}
					
				$("[focus=true]").remove();
			}
		});
		$("body").keyup(function (e){
			// shift
			if(e.keyCode == 16){
				shiftHold = 0;
			}
		});
		
		
		$("#creationTable").click(function(e){

  			

  		});
		
		$(document).click(function(e){

			fn_draggable();
			//fn_colResize();
			
			if($(e.target).attr("id") == "creationTable"){
				//div 포커스 해제
				fn_divFocusCancel();
				//테이블 포커스 해제
				fn_tableFocusCancel();
			}

		});
		
	  	
	})
	
	
	
	
	
	/* div 온클릭 이벤트 
	 * 포커스 주입 */
	fn_divOnClick = function(param){
		
		if(shiftHold == 0){//shift가 눌리지 않았을때. 하나만 클릭이 되어야 한다.
			
			if(vsCompoClickDvs == ""){
				//div 포커스 해제
				fn_divFocusCancel();
				//테이블 포커스 해제
				fn_tableFocusCancel();
				
				voFocusDivInfo = param;
				$(param).attr("focus","true");
				$(param).attr("mainFocus","true");
			} 
			else if(vsCompoClickDvs == "divTitle" || vsCompoClickDvs == "divButton" || vsCompoClickDvs == "divTable"){
				if (voFocusDivInfo.className == "divFocus") {
					voFocusDivInfo.className = "";
			    } else {
			    	//div 포커스 해제
					fn_divFocusCancel();
					//테이블 포커스 해제
					fn_tableFocusCancel();
					$(voFocusDivInfo).attr("focus","true");	
			    }
			} else if(vsCompoClickDvs == "td"){
				
				//div 포커스 해제
				fn_divFocusCancel();
				voFocusDivInfo = "";
			}

			
			vsCompoClickDvs = "";
		
			//div 선택시 id/class/name/label/style 을 propertyTable에 append
			var divNum = $("#creationTable > div").length;
			var vmObj = {};
			for(var i=0; i<divNum; i++){
				var vsfocus = $("#div"+i).attr("focus");
				if(vsfocus == "true"){
					vmObj = {
							"id" : $("#div"+i).attr("id"),
							"class" : $("#div"+i).attr("class"),
							"name" : $("#div"+i).attr("name"),
							"label" : $("#div"+i).attr("label"),
							"style" : $("#div"+i).attr("style")
					};
				}
			}
			
			var keys = Object.keys(vmObj);
			var vsbuffer = "";
			
			for(var i in keys){
				$("tr[name=buffer"+i+"]").remove();
				if(typeof vmObj[keys[i]] == "undefined"){
					vmObj[keys[i]]="";
				}
				vsbuffer +="<tr name=\"buffer"+i+"\">";
				vsbuffer +="<td>"+keys[i]+"</td>";
				vsbuffer +="<td><input type=\"text\" value=\""+vmObj[keys[i]]+"\"></input></td>";
				vsbuffer +="</tr>";
			}
			
			$("#propertyTable > tbody:last").append(vsbuffer);
			
			
		}else if(shiftHold == 1){
			
			if(vsCompoClickDvs == ""){
				//div 포커스 해제 (포커스 되어있다면 false)
				var vsType = $(param).attr("focus");
				if(vsType == "true"){
					$(param).attr("focus","false");
					$(param).attr("mainFocus","false");
				}
				else if(vsType == "false"){
					$(param).attr("focus","true");
					$(param).attr("mainFocus","true");
				}
				//fn_divFocusCancel();
				//테이블 포커스 해제
				//fn_tableFocusCancel();
				
				voFocusDivInfo = param;
				//$(param).attr("focus","true");
				//$(param).attr("mainFocus","true");
			} 
			else if(vsCompoClickDvs == "divTitle" || vsCompoClickDvs == "divButton" || vsCompoClickDvs == "divTable"){
				if (voFocusDivInfo.className == "divFocus") {
					voFocusDivInfo.className = "";
			    } else {
			    	//div 포커스 해제
					fn_divFocusCancel();
					//테이블 포커스 해제
					fn_tableFocusCancel();
					$(voFocusDivInfo).attr("focus","true");	
			    }
			} else if(vsCompoClickDvs == "td"){
				
				//div 포커스 해제
				fn_divFocusCancel();
				voFocusDivInfo = "";
			}

			
			vsCompoClickDvs = "";
		}
	}
		
	
	
	/* div 타이틀 Onclick */
	fn_divTitleOnClick = function(param) {
		
		
		if(vbTitleDragCheck == false){
			vsCompoClickDvs = "divTitle";
			voFocusDivInfo = param;
		}
		
		vbTitleDragCheck = false;
		

	}
	
	
	/* 스팬타이틀 Onclick */
	fn_spanTitleOnClick = function(param) {
		
	
		if(vbTitleDragCheck == false){
			vsCompoClickDvs = "title";
		
			var title = prompt("타이틀을 입력하시오");
			if(title != null){
				$(param).parent().css("width","1000px");
				param.textContent = title;
				var vnWidth = $(param).css("width");
				$(param).parent().css("width",vnWidth);
		}
	}
	
	
		

	}
	
	
	/* 버튼 Onclick */
	fn_buttonOnClick = function(param) {
		
		if(vbButtonDragCheck == false){
			vsCompoClickDvs = "button";
			
			var buttonNm = prompt("버튼명을 입력하시오");
			if(buttonNm != null && buttonNm != ""){
				$(param).val(buttonNm);
			}
		}
		
		vbButtonDragCheck = false;
	}
	

	/* 테이블 td 온클릭 이벤트
		포커스 주입 */
	fn_tdOnClick = function(param) { 
		
		vsCompoClickDvs = "td";
		// td에 자식이 없을 경우에만 포커스
		var vitdCount = $(".tableFocus").length;
		if(shiftHold == 0){
			if(param.children.length == 0){
				if(vitdCount == 0){
					if(param.className == "tbtd_content creationTd"){
						param.className = "tableFocus";
					}
				}else if(vitdCount >= 1){
					fn_tableFocusCancel();
					param.className = "tableFocus";
				}
				// td 선택 시 상세보기 테이블에 데이터 추가 1개기준.
				var vmObj = {
						"id" : $(".tableFocus").attr("id"),
						"class" : $(".tableFocus").attr("class"),
						"name" : $(".tableFocus").attr("name"),
						"label" : $(".tableFocus").attr("label"),
						"style" : $(".tableFocus").attr("style")
				};
			
				var keys = Object.keys(vmObj);
				var vsbuffer = "";
				for(var i in keys){
					//테이블 상세보기 마다 초기화 
					$("tr[name=buffer"+i+"]").remove();
					
				//	console.log("key="+keys[i],"value="+vmObj[keys[i]]);
					
					if(typeof vmObj[keys[i]] == "undefined"){
						vmObj[keys[i]] = ""; 
					}
					
					vsbuffer +="<tr name=\"buffer"+i+"\">";
					vsbuffer +="<td>"+keys[i]+"</td>";
					vsbuffer +="<td><input type=\"text\" value=\""+vmObj[keys[i]]+"\"></input></td>";
					vsbuffer +="</tr>";
				}
					
				$("#propertyTable > tbody:last").append(vsbuffer);	
			}
			
			
			
			
		} else if(shiftHold == 1){
			if(param.children.length == 0){
				if (param.className == "tableFocus") {
					param.className = "tbtd_content creationTd";
				} else {
					/* voFocusTdInfo.className = "tbtd_content";
					voFocusTdInfo = param; */
					param.className = "tableFocus";
				}
			}
		}
	}
		

	/* 테이블 td 더블클릭 이벤트
		라벨 설정 */
	fn_tdDbClick = function(param) {
		var label = prompt("라벨을 입력하시오");
		
		if(label != null){
			param.textContent = label;
			$(".tableFocus").attr("label",label);
		}
		param.removeChild;

		voFocusTdInfo.className = "tbtd_content creationTd";

		
	}
	
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ click 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	

	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 포커스 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	/* Div 포커스 여부 */
	fn_divFocusYn = function() {
		
		var vnFocusCount = $("[mainFocus=true]").length;
		if (vnFocusCount == 0) {
			//robot.alert("div를 선택하여 주시기 바랍니다.")
			return false;
		} else{
			return true;
		}
	}

	/* 테이블 포커스 여부 */
	fn_tableFocusYn = function() {
		
		var vnFocusCount = $(".tableFocus").length;
		if (vnFocusCount == 0) {
			alert("셀을 선택하여 주시기 바랍니다.")
			return false;
		}
	}
	
	
	/* div focus 해제 */
	fn_divFocusCancel = function(){
		if($("[focus=true]").length != 0){
			$("[focus=true]").attr("focus","false");
			$("[mainFocus=true]").attr("mainFocus","false");
		}
	}
	
	/* table td focus 해제 */
	fn_tableFocusCancel = function(){
		
		var vnTableFocusCount = $(".tableFocus").length;
		if(vnTableFocusCount != 0){
			for(var i=0; i<vnTableFocusCount; i++){
				$(".tableFocus")[0].className = "tbtd_content creationTd";
			}
			
		}
	}
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 포커스 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	

	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ TABLE 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	/*
	* focus는 tableFocus
	* 병합 분할은 row shell로 하는걸로
	*/
	
	//위로 행추가
	//focus된 셀을 누르고 추가시 위에 추가.
	//현재 테이블 기준으로 가져옴
	function fn_tableColAddUp(){
		var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
		var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
		var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
		currentTdNum = currentTdNum / currentTrNum; // table td길이
		
		var vsFocusTrRow = $(".tableFocus").parent().attr("row"); //focus row
		var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
		
		var buffer = "<tr name=\"tr\" row=\"\">";
		for(var i=0; i<currentTdNum; i++){
			buffer += "\n  <td class=\"tbtd_content creationTd\""
			buffer += "shell = \""+i+"\"";
			buffer += "style=\"height:30px; cursor:pointer\" "
			buffer += "onclick=\"fn_tdOnClick(this)\" "
			buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
			buffer += "</td>"
		}
		buffer += "\n </tr>";
		
		if(vsFocusTrRow ==0){ //가장 위 선택 시 
			$("#"+vsTableId+"> tbody > tr:first").before(buffer);
		}else if(vsFocusTrRow !=0){ // 다른곳 선택 시 
			for(var a=0; a<currentTdNum; a++){ // td갯수만큼 반복
				var rowSpan = $("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow-1)+"] > td[shell="+a+"]").attr("rowSpan");// 각td마다 rowSpan을 가져온다
				if(typeof rowSpan != "undefined" || rowSpan != null){// rowSpan이 있으면
					viRowSpan = parseInt(rowSpan);
					viRowSpan += 1;
					$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow-1+"] > td[shell="+a+"]").attr("rowSpan",viRowSpan);
				}
			}
			$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").before(buffer);
		}
			
		
		//다 끝나고 나면 tr row 정비
		// row를 다시 1번부터 매겨줌
		var resetTrNum = $("#"+vsTableId+"> tbody > tr").length;
		for(var i=1; i<=resetTrNum; i++){
			$("#"+vsTableId+"> tbody > tr:nth-child("+i+")").attr("row",i-1);
			}
		
		
	}
	
	
	//아래행추가
	//focus된 셀을 누르고 추가시 아래에 추가.
	//현재 테이블 기준으로 가져옴
	function fn_tableColAddDown(){
		var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
		var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
		var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
		currentTdNum = currentTdNum / currentTrNum; // table td길이
		
		var vsFocusTrRow = $(".tableFocus").parent().attr("row"); //focus row
		var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
		
		var buffer = "<tr name=\"tr\" row=\"\">";
		for(var i=0; i<currentTdNum; i++){
			buffer += "\n  <td class=\"tbtd_content creationTd\""
			buffer += "shell = \""+i+"\"";
			buffer += "style=\"height:30px; cursor:pointer\" "
			buffer += "onclick=\"fn_tdOnClick(this)\" "
			buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
			buffer += "</td>"
		}
		buffer += "\n </tr>";
		
		for(var a=0; a<currentTdNum; a++){ // td갯수만큼 반복
			
	    	var rowSpan = $("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow+1)+"] > td[shell="+a+"]").attr("rowSpan");// 각td마다 rowSpan을 가져온다
	    	
	    	if(typeof rowSpan != "undefined" || rowSpan != null){// rowSpan이 있으면
	    		
	    		viRowSpan = parseInt(rowSpan);
	    		viRowSpan += 1;
	    		$("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow+1)+"] > td[shell="+a+"]").attr("rowspan",viRowSpan);
	    	}
	    }
	    	$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").after(buffer);
		
		//다 끝나고 나면 tr row 정비
		// row를 다시 1번부터 매겨줌
		var resetTrNum = $("#"+vsTableId+"> tbody > tr").length;
		for(var i=1; i<=resetTrNum; i++){
			$("#"+vsTableId+"> tbody > tr:nth-child("+i+")").attr("row",i-1);
			}
		
		
	}
	
	
	
	
	//행삭제
	//focus된 행을 삭제한다.
	function fn_tableColDel(){
		var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); //현재 table
		var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
		var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
		currentTdNum = currentTdNum / currentTrNum; // table td길이
		var vsFocusTrRow = $(".tableFocus").parent().attr("row");// focus tr row
		var vsFocusTdShell = $(".tableFocus").attr("shell"); //focs td shell
		
		
			
		for(var i=0; i<currentTdNum; i++){
			var rowSpan = $("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"] > td[shell="+i+"]").attr("rowspan");// 각td마다 rowSpan을 가져온다	
			if(typeof rowSpan != "undefined" || rowSpan != null){ // rowSpan 있을떄
				var viRowSpan = parseInt(rowSpan);	
				
				var buffer = "<td class=\"tbtd_content creationTd\""
					buffer += "shell = \""+i+"\"";
					buffer += "style=\"height:30px; cursor:pointer\" "
					buffer += "onclick=\"fn_tdOnClick(this)\" "
					buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
					buffer += "</td>"
			
				$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").remove();
					
				for(var j=1; j<viRowSpan; j++){
					$("#"+vsTableId+"> tbody > tr[row="+(vsFocusTrRow+j)+"] > td[shell="+i+"]").after(buffer);
				}
				
			}
			else if(typeof rowSpan == "undefined" || rowSpan == null){ //rowSpan 없을떄
				$("#"+vsTableId+"> tbody > tr[row="+vsFocusTrRow+"]").remove();
			}
		}
		
		//다 끝나고 나면 tr row 정비
		// row를 다시 1번부터 매겨줌
		var resetTrNum = $("#"+vsTableId+"> tbody > tr").length;
		for(var i=1; i<=resetTrNum; i++){
			$("#"+vsTableId+"> tbody > tr:nth-child("+i+")").attr("row",i-1);
			}
	}
	
	/* 테이블 병합 
	 * 테이블 병합 순서
	 * 1. 테이블의 모든 colspan rowspan을 받아온다
	 * 2. 각각을 비교 - 1:1 = 1 / r:1 = rn / 1:c = cn / r:c = r:c
	*/

	// 테이블 병합.
function fn_tableMerge(){ 
	var vsTableId = $(".tableFocus").parent().parent().parent().attr("id"); // 테이블 아이디
	var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; //현재 tr 갯수
	var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
	currentTdNum = currentTdNum / currentTrNum; //현재 td 갯수
	
	//rowSpan 탐색
	var vsRow = new Array(currentTdNum);
		for(var i=0; i<currentTrNum; i++){
			vsRow[i] = new Array(currentTrNum);
		}

	for(var i=0; i<currentTrNum; i++){//tr갯수만큼 반복
		var viTdLength = $("#"+vsTableId+" > tbody > tr[row="+i+"] > td").length;
		for(var j=0; j<currentTdNum; j++){//td갯수만큼 반복
			var rowSpan = $("#"+vsTableId+" > tbody >  tr[row="+i+"]  > td[shell="+j+"]").attr("rowspan");
				if(typeof rowSpan != "undefined" || rowSpan != null){
					vsRow[i][j] = rowSpan;
				}
				else{
					vsRow[i][j] = 1;
				}
		}
	}
	

	
	//colSpan 탐색
	var vsCol = new Array(currentTdNum);
		for(var i=0; i<currentTrNum; i++){
			vsCol[i] = new Array(currentTrNum);
		}
		
	for(var i=0; i<currentTrNum; i++){//tr갯수만큼 반복
		var viTdLength = $("#"+vsTableId+" > tbody > tr[row="+i+"] > td").length;
		for(var j=0; j<currentTdNum; j++){//td갯수만큼 반복
			var colSpan = $("#"+vsTableId+" > tbody >  tr[row="+i+"]  > td[shell="+j+"]").attr("colspan");
				if(typeof colSpan != "undefined" || colSpan != null){
					vsCol[i][j] = colSpan;
				}
				else{
					vsCol[i][j] = 1;
				}
		}	
	}
	
	
	//text 탐색
	var vsText = new Array(currentTdNum);
		for(var i=0; i<currentTrNum; i++){
			vsText[i] = new Array(currentTrNum);
		}
		
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			vsText[i][j] = $("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").text();
		}
	}
	
	
	
	//row / col 세이브
	var vsTotal = new Array(currentTdNum);
	for(var i=0; i<currentTrNum; i++){
		vsTotal[i] = new Array(currentTrNum);
	}
	
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			var rowSpan = vsRow[i][j];
			var colSpan = vsCol[i][j];
			// 분기처리 - 1. xx 2. xy 3. yx 4. yy
			// 1. xx 둘다 없다
			if(rowSpan == "1" && colSpan == "1"){
				if(vsTotal[i][j]=="c0" || vsTotal[i][j]=="r0"){ // row&col에 먹힌거면
					continue;
				}else{
					vsTotal[i][j] = "1";
				}
			}
			// 2. row는 있고 col은 없다
			else if(rowSpan != "1" && colSpan == "1"){
				var virowSpan = parseInt(rowSpan);
				for (var a=1; a<virowSpan; a++){
					if(i+a > currentTrNum){
						break;
					}
					vsTotal[i+a][j] = "r0";
					vsTotal[i][j] = "r"+rowSpan;
				}
			}
			// 3. row는 없고 col은 있다
			else if(rowSpan == "1" && colSpan != "1"){
				var viColSpan = parseInt(colSpan);
				for (var a=1; a<viColSpan; a++){
					if(j+a > currentTdNum){
						break;
					}
					vsTotal[i][j+a] = "c0";
					vsTotal[i][j] = "c"+colSpan;
				}
			}
			// 4. yy 둘다 있다 i=tr j=td
			else if(rowSpan != "1" && colSpan != "1"){
				var virowSpan = parseInt(rowSpan);
				var viColSpan = parseInt(colSpan);
				for (var a=i; a<virowSpan+i; a++){
					for(var b=j; b<viColSpan+j; b++){
						if(a == i && b == j){
							vsTotal[a][b]= rowSpan+":"+colSpan;
						}else if(a == i){
							vsTotal[a][b]="c0";
						}else if(a!=i){
							vsTotal[a][b]="r0";
						}
					}
				}
			}
		}
	}
	
	// ↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 상단까지 배열로 col / row 가져오기 실시함 / text ↑↑↑↑↑↑↑↑↑↑↑↑↑↑
		
	// focus 된 td들의 위치를 정확히 파악해서 그곳에다가 attr해줌. 0인경우 remove(); || hide(); 
	var vsTalbeFocus = new Array(currentTdNum);
	for(var i=0; i<currentTrNum; i++){
		vsTalbeFocus[i] = new Array(currentTrNum);
	}
	
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			vsTalbeFocus[i][j] = $("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("class");
		}
	}

	
	
	var tableFocusRowNumber = $(".tableFocus").parent().attr("row");
	var stub = parseInt(tableFocusRowNumber);
	var tableFocusShellNumber = $(".tableFocus").attr("shell"); //tablefocus 좌상단
	var stub2 = parseInt(tableFocusShellNumber);
	
	var Span = [];
	
	//rowSpan의 갯수는 각 tr당 r이 속해있는 것 중 
	
	var inputRowSpan = 0; // 최종 row
	var inputColSpan = 0; // 최종 col
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			var check = vsTotal[i][j];
			var classCheck = vsTalbeFocus[i][j];
			// 유형 = tf-c / tf-r / tf-cr / tf-1 / tf-0
			if(typeof Span[i] == "undefined" && Span[i] == null){
				Span[i]=0;
			}
			if(classCheck == "tableFocus"){
				if(check.indexOf(":") != -1){ // tf-cr
					var vaCheck = check.split(":");
					var viRNum = parseInt(vaCheck[0]);
					var viCNum = parseInt(vaCheck[1]);
					var colSize = Span[i];
					Span[i] = colSize+viCNum;
				}
				else if(check.indexOf("c") != -1){
					var viStup2 = parseInt(check.replace("c",""));
					var colSize = Span[i];
					Span[i] = colSize+viStup2;
				}
				else if(check.indexOf("r") != -1){
					var colSize = Span[i];
					Span[i] = colSize+1;					
				}
				else if(check == "1"){
					var colSize = Span[i];
					Span[i] = colSize+1;
				}
			}

		}
	}
	
	
	inputColSpan = Span[stub]; //colSpan 길이
	
	//rowSpan 길이
	var viFocusRow = new Array(currentTdNum);
	for(var i=0; i<currentTrNum; i++){
		viFocusRow[i] = new Array(currentTrNum);
	}
	
	
	for(var i=0; i<currentTrNum; i++){
		for(var j=0; j<currentTdNum; j++){
			var check = vsTotal[i][j];
			var classCheck = vsTalbeFocus[i][j];
			if(classCheck == "tableFocus"){
				if(check.indexOf(":") != -1){
					var vaCheck = check.split(":");
					var viRNum = parseInt(vaCheck[0]);
					viFocusRow[i][j] = viRNum;
				}
				else if(check.indexOf("r") != -1){
					var viStup1 = parseInt(check.replace("r",""));
					var viRNum = parseInt(viStup1);
					viFocusRow[i][j] = viRNum;
					
				}
				else if(check.indexOf("c") != -1){
					viFocusRow[i][j] = 1;
				}
				else if(check == 1){
					viFocusRow[i][j] = 1;
				}
			}
			else if(classCheck != "tableFocus"){
				viFocusRow[i][j] = 0;
			}
			
		}
	}
	
	var total = [];
	for(var i=0; i<currentTdNum; i++){
		for(var j=0; j<currentTrNum; j++){
			var adder = viFocusRow[j][i];
			if(typeof total[i] =="undefined"){
				total[i]=0;
			}
			if(adder == 0){
				continue;
			}
			else if(adder != 0){
				var current = total[i];
				total[i] = current + adder;
			}
		}
	}
	
	// inputRowSpan에 값 설정.
	for(var i=0; i<total.length; i++){
		var check = total[i];
		if(inputRowSpan <= check){
			inputRowSpan = check;
		}		
	}

	
	
	

		
		//col row 재분배함
		// 좌측 상단에만 줘야함, 나머지는 0으로 바꿔줘야함.
		var first=0;
		for(var i=0; i<currentTrNum; i++){
			for(var j=0; j<currentTdNum; j++){
				var check = vsTotal[i][j];
				var classCheck = vsTalbeFocus[i][j];
				
				if(classCheck == "tableFocus"){
					if(check != "0"){
						if(first == 0){
							first += 1;
							if(inputRowSpan > 1 && inputColSpan > 1){ // r:c
								// 여기서 줄인다..?
								for(var a=stub; a<inputRowSpan+stub; a++){
									for(var b=stub2; b<inputColSpan+stub2; b++){
										if(a == stub && b == stub2){
											continue;
										}
										
										if(a == stub){
											vsTotal[a][b] = "c0";
										}
										else if(a != stub){
											vsTotal[a][b] = "r0";
										}
										
									}
								}
								vsTotal[i][j] = inputRowSpan.toString()+":"+inputColSpan.toString();	
							}
							else if(inputRowSpan > 1 && inputColSpan <= 1){ // r
								for(var a=stub; a<inputRowSpan+stub; a++){
									if(a == stub){
										continue;
									}
									vsTotal[a][j] = "r0"
								}
								vsTotal[i][j] = "r"+ inputRowSpan.toString()
							}
							else if(inputRowSpan <= 1 && inputColSpan > 1){ // c
								for(var b=stub2; b<inputColSpan+stub2; b++){
									if(b == stub2){
										continue;
									}
									vsTotal[i][b] = "c0"
								}
								vsTotal[i][j] = "c"+inputColSpan.toString();
							}
							else if(inputRowSpan <= 1 && inputColSpan <= 1){ // 없
								alert("하나만 선택하면 안되요");
							}
						}
					}
				}
			}
		}
		
		
		for(var i=0; i<currentTrNum; i++){
			for(var j=0; j<currentTdNum; j++){
				var InputSpan = vsTotal[i][j];
				// 0 / 1 / c / r / r:c
				if(InputSpan == "c0" || InputSpan == "r0" ){ //포함되는 셀 hide();
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").hide(); // h
				} 
				else if(InputSpan == "1"){
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").show();
				}
				else if(InputSpan.indexOf(":") != -1){ // row:col // row나 col이 0일 수 있음 분기처리.
					var vaCheck = InputSpan.split(":");
					var vsRNum = vaCheck[0];
					var vsCNum = vaCheck[1];
					var viRNum = vsRNum.replace("r",""); //r 값
					var viCNum = vsCNum.replace("c",""); //c 값
					
					if(viRNum == "0" && viCNum != "0"){
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colspan",viCNum);
					}
					else if(viCNum == "0" && viRNum != "0"){
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("rowspan",viRNum);
					}
					else if(viCNum != "0" && viRNum != "0"){
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colspan",viCNum);
						$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("rowspan",viRNum);
					}
				}
				else if(InputSpan.indexOf("c") != -1){ // col
					var viStup2 = parseInt(InputSpan.replace("c",""));
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("colspan",viStup2);
				}
				else if(InputSpan.indexOf("r") != -1){ // row
					var viStup1 = parseInt(InputSpan.replace("r",""));
					$("#"+vsTableId+"> tbody > tr[row="+i+"] > td[shell="+j+"]").attr("rowspan",viStup1);
				}
			}
		}
}//병합 end


	/* 테이블 분할  - 눌린셀은 그냥 전부 분할되게.
	 * 테이블 분할 
	 * 1. 병합된 셀 분할
	 * 2. 단일 셀 분할
	*/
	function fn_tableDivision(){ 
		var vsTableId = $(".tableFocus").parent().parent().parent().attr("id");
		var focusTr = parseInt($(".tableFocus").parent().attr("row"));
		var focusTd = parseInt($(".tableFocus").attr("shell"));
		var currentTrNum = $("#"+vsTableId+" > tbody > tr").length; // table tr길이
		var currentTdNum = $("#"+vsTableId+" > tbody > tr > td").length; 
		currentTdNum = currentTdNum / currentTrNum; 
		
		 var checkColSpan = $(".tableFocus").attr("colspan");
		 	if(typeof checkColSpan == "undefined"){
		 		checkColSpan = 0;
		 	}
		 var focusShellCol = parseInt(checkColSpan);
		 
		 var checkRowSpan = $(".tableFocus").attr("rowspan");
		 	if(typeof checkRowSpan == "undefined"){
		 		checkRowSpan = 0;
		 	}
		 var focusShellRow = parseInt(checkRowSpan);
		 
		 if(focusShellCol == 0 && focusShellRow != 0){// col이 없을떄
			$("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("rowSpan");
			
		 	for(var a=focusTr+1; a<focusTr+focusShellRow; a++){
				$("#"+vsTableId+"> tbody > tr[row="+a+"] > td[shell="+focusTd+"]").show();
			}
		 }
		 else if(focusShellCol != 0 && focusShellRow == 0){ // row가 없을때
			 $("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("colSpan");
	
			 for(var a=focusTd+1; a<focusTd+focusShellCol; a++){
				$("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+a+"]").show();
			}
		 }
		 else if(focusShellCol != 0 && focusShellRow != 0){ // 둘다 있으면
			 $("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("rowSpan");
			 $("#"+vsTableId+"> tbody > tr[row="+focusTr+"] > td[shell="+focusTd+"]").removeAttr("colSpan");
			 
			 for(var a=focusTr; a<focusTr+focusShellRow; a++){
				 for(var b=focusTd; b<focusTd+focusShellCol; b++){
					 if(a==focusTr && b==focusTd){
						 continue;
					 }
					 else{
						 $("#"+vsTableId+"> tbody > tr[row="+a+"] > td[shell="+b+"]").show();
					 }
				 }
			 }
		 }
		 else if(focusShellCol == 0 && focusShellRow == 0){ 			
		}
	}	
	 
		
		
	fn_colResize = function(){
		
		var onSampleResized = function(e){
			var table = $ (e.currentTarget);
		 };
		
			$ ("#table0").colResizable({
			 	liveDrag : true , 
			    gripInnerHtml : "<div class = 'grip'> </ div>" ,  
			    draggingClass : "dragging" ,  
			    onResize : onSampleResized
		  });
		}
	


	
	
	
	/* ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ TABLE 이벤트 ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */
	
	
	
		
	/**********************************
	 수정  프로세스 
	***********************************/
	function infoUpdate(){
		
		var vsTrnum = $("#propertyTable tbody tr").length;
			vsTrnum --;
		
		var vmObj = {};
		//jsonArray에 변경정보 담기
		for(var i=0; i<vsTrnum; i++){
			var vsKey = $("tr[name=buffer"+i+"] > td:first").text();
			var vsValue = $("tr[name=buffer"+i+"] > td:last > input[type=text]").val();
			
			if(vsKey != null && vsValue != null){
				if(vsKey == "id"){
					vmObj["id"] = vsValue;	
				}
				if(vsKey == "class"){
					vmObj["class"] = vsValue;	
				}
				if(vsKey == "name"){
					vmObj["name"] = vsValue;	
				}
				if(vsKey == "label"){
					vmObj["label"] = vsValue;	
				}
			}
		}
		//key값 셋팅
		var keys = Object.keys(vmObj);
		
		//key와 value를 가져와 해당 component에 입력
		for(var i in keys){
			$(".tableFocus").attr(keys[i],vmObj[keys[i]]);
		}
	}//수정 프로세스 end
	
		
	/**********************************
	 검색 프로세스 
	***********************************/
	function infoSearch(){
		//vsProperty == 검색어 
		var vsProperty = $("#Search").val();
		var vsTrnum = $("#propertyTable tbody tr").length;
			vsTrnum --;
		
		//반복문을 통해 td의 값(속성 키,값)을 가져와 JsonArray에 삽입
		var vmObj = {};
		
		for(var i=0; i<vsTrnum; i++){
			//vsKey == 속성키
			var vsKey = $("tr[name=buffer"+i+"] > td:first").text();
			var vsValue = $("tr[name=buffer"+i+"] > td:last > input[type=text]").val();
			if(vsKey != null && vsValue != null){
				if(vsKey == "id"){
					vmObj["id"] = vsValue;	
				}
				if(vsKey == "class"){
					vmObj["class"] = vsValue;	
				}
				if(vsKey == "name"){
					vmObj["name"] = vsValue;	
				}
				if(vsKey == "label"){
					vmObj["label"] = vsValue;	
				}
			}
		}	
		
		// vmObj의 key값만 저장
		var Keys = Object.keys(vmObj);
		
		// 키값으로 검색어 찾기 
		for(var j=0; j<Keys.length; j++){
			//입력값이 없을때 
			if(vsProperty == null){
				alert("검색어를 입력하세요");
				break;
			}
			// 입력값이 테이블에 있을때 
			if(Keys[j] == vsProperty){
				for(var k=0; k<vsTrnum; k++){	
					$("tr[name=buffer"+k+"]").hide();
				}
					$("tr[name=buffer"+j+"]").show();
				break;
			} 
			
		}		
	}//검색 프로세스 end

	
</script>

</head>
 
<body>
	<div id="mysidenav" class="sidenav">
		<!-- <div style="width: 500px; float: left;"> -->
				<table border="1" cellpadding="0" cellspacing="0" style="align: center; bordercolor: #D3E2EC; bordercolordark: #FFFFFF; border-collapse: collapse;">
					<colgroup>
						<col width="100" />
						<col width="100" />
						<col width="100" />
					</colgroup>
					<tr>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="divCreation();">DIV영역</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="titleCreation();">TITLE</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="tableCreation();">TABLE</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="buttonCreation();">BTN 영역</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="inputCreation();">Input Box</td>
						<td class="tbtd_content" style="cursor: pointer"
							onclick="selectCreation();">Select Box</td>
					</tr>
					
					<tr>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColAddUp();">위로 행 추가</td>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColAddDown();">아래 행 추가</td>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColDel();">행 삭제</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableMerge();">병합</td>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableDivision();">분할</td>
					</tr>
				</table>
			<!-- </div> -->
		<table id="propertyTable" style="display:none;">
			<tr>
				<!-- 이거로 검색. -->
				<td><input type="text" id="Search"></input></td>
				<td><input type="button" onclick="infoSearch();" value="검색"></input><td>
				<td><input type="button" onclick="infoUpdate();" value="수정"></input></td>
			</tr>
		</table>
	</div>
	
	<div style="width: 150px; float: right; display:none;">
		<ul id="sortable">
		</ul>
	</div>
</body>
</html>