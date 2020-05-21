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
		
		/* 미디어쿼리 적용 */

#propertyTable{
	width:100%; 
	border: 1px solid #444444; 
	align: center;
	border-collapse: collapse;
	background-color: white;					
}

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
	  
	  
  	
  	$(document).click(function(e){

  		fn_draggable();

  	});
  	
  	 $( "#sortable" ).sortable({
        //items: "li:not([level=1])",
        cancel: "[level=1]",
        dropOnEmpty: false,
        placeholder: "ui-state-highlight",
        
      /************************************* 
    	 * 정렬 시작 이벤트
    	 * 정렬을 하려고 outline 움직이는 순간 발생한다.
    	**************************************/
        start : function( event, ui){
      	  
      	  // outline 에러시 제자리 복귀하기 위한 index 저장
      	  vnSortNum = ui.item.parent().children().index(ui.item);
        },
        
        /************************************* 
         * 정렬 업데이트 이벤트
         * outline 정렬이 완료되는 순간 발생한다.
         **************************************/
        update: function( event, ui ) {
        	  var voInfo = ui.item;
        	  
        	  // outline이 바라보는 실제 컴포넌트id
        	  var vsOrgId = voInfo.attr("orgId");
        	  
        	  var voLiInfo = voInfo.parent().children();
        	  var vnRealIndex = voLiInfo.index(voInfo);
        	  
        	  var vsParentNm = "";
        	  
        	  // 자리이동시 상위에 level1인 부모값을 찾는다.
        	  for(var i=vnRealIndex-1; i>=0; i--){
        		if(voLiInfo.eq(i).attr("level") == 1){
        			vsParentNm = voLiInfo.eq(i).attr("id");
        			break;
        		}
        	  }
        	  
        	  // 부모가 없는곳으로 이동했을경우 제자리 복귀
        	  if(vsParentNm == ""){
        		  robot.alert("객체는 div안에서 존재해야 합니다.")
        		  $("#sortable").children().eq(vnSortNum).after(voInfo);
        		  
        	  // 다른 부모에게 이동했을경우 속성값중 parent값 업데이트
        	  } else{
            	  var vsOrgParentId = $("#"+vsParentNm).attr("orgId");
            	  
            	
            	  voInfo.attr("parent", vsParentNm);
          	  var vnIndex = $("[parent="+vsParentNm+"]").index(voInfo);
          	  
          	  
          	  // 다른 부모에게 이동했지만 첫번째 자식일경우 prepend
          	  if(vnIndex == 0){
          		  $("#"+vsOrgParentId).prepend($("#"+vsOrgId))
          	  // 첫번째 자식이 아닌경우 바로 위의 형제 노드를 찾아 after 처리
          	  } else{
          		  
          		  var voBeforeInfo = $("[parent="+vsParentNm+"]").eq(vnIndex-1).attr("orgId");
          		  
          		  $("#"+voBeforeInfo).after($("#"+vsOrgId));
          		  
          	  }
        	  }
        	  
        	  
         }
      });
  	
  	
      $( "#sortable" ).disableSelection();
  });
  
  
  
  /************************************* 
   * accordion 관련 함수
   **************************************/
    fn_draggable = function(){
  	  $( ".div_content" ).draggable({ cursor: "move",
  									  grid: [ 10, 10 ],
  									  stop: function( event, ui ) {/* 1188 */debugger;
  										  
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
	         	
	         	
	            // 도착한 div의 높이
    			var vnNewParentTop = Number(voContent.eq(vnDivRow).css("top").replace("px",""));
    			// 도착한 div의 폭
    			var vnNewParentLeft = Number(voContent.eq(vnDivRow).css("left").replace("px",""));
	         	
	         	
	         	
	            // 출발한 곳이 밖이라면
	            if(vsParentId == "creationTable"){
	            		
	            	
	            	// 움직인곳이 div 안으로 이동했다면(밖->안)
	            	if(vsDivYn == "Y"){
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
			vsSource += "\n <tr>";
			for (var j = 0; j < param[0]; j++) {
				vsSource += "\n  <td class=\"tbtd_content creationTd\" "
				vsSource += "name=\"tbtd_"+j+"\""
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
	fn_spanTitleOnClick = function(param) {debugger;
		
	
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
			}
		}
		else if(shiftHold == 1){
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
	
	/* 행추가 */
	function fn_tableColAdd() { 
			
		var vsTableId = "#"+$(".tableFocus").parent().parent().parent().attr("id");
		var tdnum = $(vsTableId+"> tbody td").length;
		var trnum = $(vsTableId+"> tbody tr").length;
		
		var count = tdnum/trnum;
		
		var buffer = "<tr>";
		
		for(var i=0; i<count; i++){
			buffer += "\n  <td class=\"tbtd_content creationTd\" "
			buffer += "name=\"tbtd_"+i+"\""
			buffer += "style=\"height:30px; cursor:pointer\" "
			buffer += "onclick=\"fn_tdOnClick(this)\" "
			buffer += "ondblclick=\"fn_tdDbClick(this)\"> "
			buffer += "</td>"
		}
		
		buffer += "\n </tr>";
		
		$(vsTableId+"> tbody:last").append(buffer);
	}
	
	/* 행삭제 */
	function fn_tableColDel(){
		var vsTableId = "#"+$(".tableFocus").parent().parent().parent().attr("id");
		$(vsTableId+">tbody:last > tr:last").remove();
	}
	

	//행 병합;
	function fn_tableColMerge(){ 
		
		//행병합 시 colSpan 속성 갯수 구하기
		var colComp = 0;
		//선택된 것들 중 가장 앞에 있는 셀의 name을 가져옴
		var tfnameFirst = $(".tableFocus").attr("name");
		//name 뒤에 수를 가져옴
		var tfnameFirstNum = parseInt(tfnameFirst.substring(tfnameFirst.lastIndexOf("_")+1));
		//tableFocus된 셀의 갯수 파악
		var FocusCount = $(".tableFocus").length;
		//열병합 방지 변수
		var rowSpan = 0;
		for(var i=tfnameFirstNum; i<FocusCount+tfnameFirstNum+1; i++){
			var viCol = $(".tableFocus[name=tbtd_"+i+"]").attr("colSpan");
			var vitfname = $(".tableFocus[name=tbtd_"+i+"]").attr("name");
			if(typeof viCol != "undefined"){ // 콜스판찾아오기
				colComp += parseInt(viCol);
			}
			if(typeof vitfname == "undefined"){// name이 undefined면 열을 선택했거나 떨어져서 선택
				var maxlength = FocusCount+tfnameFirstNum;
				if(i == maxlength){
					//만약 이전에 이름이 있었다면?
					var j = i-1;
					var beforeName = $(".tableFocus[name=tbtd_"+j+"]").attr("name");
					if(beforeName != null){
						rowSpan = 0;
						console.log(beforeName);
					}else{
						rowSpan = 1;
						if(rowSpan == 1){
							alert("다시 선택하세요");
							break;
					}
				}
			}
		}
	}
		
		if(colComp == 0){
			if(rowSpan == 0){
				$(".tableFocus[name =tbtd_"+tfnameFirstNum+"]").attr("class","tbtd_sum"); // 병합할 td 클래스명 일시변경
				$(".tbtd_sum").attr("colSpan",FocusCount);
				$(".tbtd_sum").attr("class","tbtd_content creationTd"); //원상복귀
				$(".tableFocus").remove();
			}
		}
		else if(colComp != 0){
			//콜스판 포함한 셀의 수
			var totalSel = colComp + FocusCount - 1;
			$(".tableFocus[name=tbtd_"+tfnameFirstNum+"]").attr("class","tbtd_sum");
			$(".tbtd_sum").attr("colSpan",totalSel);
			$(".tbtd_sum").attr("class","tbtd_content creationTd"); 
			$(".tableFocus").remove();
		}			
	}//fn_tableColMerge() end
		
	//행 분할시 하나씩만 할 수 있도록 한다.
 	function fn_tableColDivision(){ 
 		
 		var vsColspanYN = $(".tableFocus").attr("colSpan");
 		if(typeof vsColspanYN == "undefined" || vsColspanYN == null){
 			alert("병합되지 않은 셀 또는 열은 분할할 수 없습니다.");
 		}
 		else{
	 		var colspan = $(".tableFocus").attr("colSpan");
	 		var name = $(".tableFocus").attr('name');
	 	 	var namenum = parseInt(name.substring(name.lastIndexOf("_")+1)); 
	 	 	var totalnum = parseInt(colspan)+namenum;
	 	 	var buffer ="";
	 	 	for(namenum; namenum<totalnum; namenum++){
	 	 		buffer += "\n  <td class=\"tbtd_content creationTd\" ";
	 	 		buffer += "name=\"tbtd_"+namenum+"\"";
	 	 		buffer += "style=\"height:30px; cursor:pointer\" ";
	 	 		buffer += "onclick=\"fn_tdOnClick(this)\" ";
	 	 		buffer += "ondblclick=\"fn_tdDbClick(this)\"> ";
	 	 		buffer += "</td>";
	 	 		}
	 			$("td.tableFocus[name ="+name+"]").after(buffer);
	 			$("td.tableFocus[name ="+name+"]").remove();
 			}
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
			//console.log("key="+keys[i],"value="+vmObj[keys[i]]);
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
				console.log("alert");
				alert("검색어를 입력하세요");
				break;
			}
			// 입력값이 테이블에 있을때 
			if(Keys[j] == vsProperty){
				console.log("success");
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
				<table width="400px" border="1" cellpadding="0" cellspacing="0" style="align: center; bordercolor: #D3E2EC; bordercolordark: #FFFFFF; border-collapse: collapse;">
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
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColAdd();">행 추가</td>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColDel();">행 삭제</td>
					</tr>
					<tr>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColMerge();">병합</td>
						<td class="tbtd_content" style="cursor: pointer" onclick="fn_tableColDivision();">분할</td>
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