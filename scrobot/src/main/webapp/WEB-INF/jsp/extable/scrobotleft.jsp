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
			width: 20%;
			position: fixed;
			z-index:1;
			top: 0;
			left: 0;
			margin-top:35px;
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
			width:40px;
			height:20px;
			
		}
		
		/* 미디어쿼리 적용 */
	
.tableFocus {
	border: 3px solid grey !important;
}

[focus="true"]{
	border: 3px solid grey !important;
}


.span_title {
	font-weight: bold;
	font-size: 15pt;
	cursor: pointer;
	
}

.div_button{
	height:30px;
	margin-top:20px;
	
}

.button{
	
	margin-right:20px;
	width:60px;
	height:30px;
	
}

.creationTd{
	 cursor:pointer;
}

.inputBox{
	width:150px;
}
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

  // div_button 개수
  vnDivButtonCount = 0;

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


  $(function(){
  	
  	$(document).click(function(e){

  		if (!$(e.target).is('.div_content')) {
  	        // code
  	    }

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
  	  $( ".div_content" ).draggable();
  	  $( ".div_content" ).resizable();
  	  $( ".div_title" ).draggable({ containment: "parent" });
  	  $( ".span_title" ).draggable({ containment: "parent" });
  	  $( ".div_button" ).draggable({ containment: "parent" });
  	  
  	  $(".button").draggable({cancel:false, containment: "parent"});
  	  $( ".div_table" ).draggable({ containment: "parent" });
    }
    
    $( "#sortable" ).on( "sortupdate", function( event, ui ) {} );
	
	
	
	
	/* ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 그리기 이벤트 ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ */
	
	
	/************************************* 
     * outline 그리기 함수
     **************************************/
	fn_rightDraw = function(){
		var vsBasicSource = "<li class=\"ui-state-default\" "; 
		var vsRightSource = "";
		
		// 컴포넌트 그리는 div자식들 가져온다.
		var voChild = $("#creationTable").children();
		var vnChildCount = voChild.length;
		
		// div_content가 1개이상이라면
		if(vnChildCount != 0){
			for(var a=0; a<vnChildCount; a++){
				var voSortableChild = $("#sortable").children();
				var vnSortableChildCount = voSortableChild.length;
				
				var vsTagNm = voChild.eq(a).prop("tagName");
				var vsTagId = voChild.eq(a).prop("id");
				var vsTagInfo = vsTagNm + "_" + vsTagId;
				
				vsRightSource =  vsBasicSource + "id = \""+vsTagInfo + "\"";
				vsRightSource += " orgId=\""+vsTagId+"\"";
				vsRightSource += " level=\"1\"";
				vsRightSource += ">";
				vsRightSource +=  vsTagInfo + "</li>"
				
				var vnoverlapCount = 0;
				
				//outline에 1개이상 있다면
				if(vnSortableChildCount != 0){
					
					// 컴포넌트가 outline에 이미 존재하는지 체크
					for(var b=0; b<vnSortableChildCount; b++){
						if(voSortableChild.eq(b).text() == vsTagInfo){
							vnoverlapCount++;
							
						}
					}
					
					// 존재하지 않다면 outline에 추가
					if(vnoverlapCount == 0){
						$("#sortable").append(vsRightSource);
					}
			    // outline에 컴포넌트가 0개라면 바로 outline 추가
				} else{
					$("#sortable").append(vsRightSource);
				}
				
				
				// 버튼div, 타이틀div, 테이블div 등등 손자를 그리기위하여 포커스잡힌 div를 가져옴
				var voFocusDiv = $("[mainFocus=true]");
				var voChild2 = voFocusDiv.children();
				
				vsTagNm = voFocusDiv.eq(a).prop("tagName");
				vsTagId = voFocusDiv.eq(a).prop("id");
				vsTagInfo = vsTagNm + "_" + vsTagId;
				
				
				var vnChildCount2 = voChild2.length
				if(vnChildCount2 != 0){
					for(var b=0; b<vnChildCount2; b++){
						if(voChild2.eq(b).prop("id") != ""){
							var vsTagNm2 = voChild2.eq(b).prop("tagName");
							var vsTagId2 = voChild2.eq(b).prop("id");
							var vsTagInfo2 = vsTagNm2 + "_" + vsTagId2;
							
							vsRightSource =  vsBasicSource + "id = \""+vsTagInfo2 + "\"";
							vsRightSource += " orgId=\""+vsTagId2+"\"";
							vsRightSource += " level = \"2\"";
							vsRightSource += " parent = \""+vsTagInfo + "\"";
							vsRightSource += "><span class=\"ui-icon ui-icon-arrowthick-2-n-s\"></span>";
							vsRightSource +=  vsTagInfo2 + "</li>"
							
							var vnoverlapCount = 0;
							
							// 손자가 outline에 이미 존재하는지 체크
							for(var c=0; c<vnSortableChildCount; c++){
								if(voSortableChild.eq(c).text() == vsTagInfo2){
									vnoverlapCount++;
								}
							}
							
							// 존재하지 않는다면 추가
							if(vnoverlapCount == 0){
								
								// 자식이 하나도 없다면 부모바로 다음에 존재해야 함으로 after처리
								if($("[parent="+vsTagInfo+"]").length == 0){
									$("#"+vsTagInfo).after(vsRightSource);
							    // 자식이 하나 이상이라면 가장 마지막 처리
								} else{
									$("[parent="+vsTagInfo+"]").last().after(vsRightSource);
								}
								
							}

/* 							var voChild3 = voChild2.children();
							var vnChildCount3 = voChild3.length
							if(vnChildCount3 != 0){
								for(var c=0; c<vnChildCount3; c++){
									if(voChild3.eq(c).prop("id") != ""){
										var vsTagNm3 = voChild3.eq(c).prop("tagName");
										var vsTagId3 = voChild3.eq(c).prop("id");
										var vsTagInfo3 = vsTagNm3 + "_" + vsTagId3;
										
										vsRightSource =  vsBasicSource + "id = \""+vsTagInfo3 + "\"";
										vsRightSource += " parent = \""+vsTagInfo2 + "\"";
										vsRightSource += "><span class=\"ui-icon ui-icon-arrowthick-2-n-s\"></span>";
										vsRightSource +=  vsTagInfo3 + "</li>"
										
										var vnoverlapCount = 0;
										for(var d=0; d<vnSortableChildCount; d++){
											if(voSortableChild.eq(d).text() == vsTagInfo3){
												vnoverlapCount++;
											}
										}
										
										if(vnoverlapCount == 0){
											if($("[parent="+vsTagInfo2+"]").length == 0){
												$("#"+vsTagInfo2).after(vsRightSource);
											} else{
												$("[parent="+vsTagInfo2+"]").after(vsRightSource);
											}
										}

									}
								}
								
							} */
						}
						
						
					}
					
				}
			}
		}
	}
	
	
	/* DIV 만들기 */
	function divCreation() {
		robot.prompt("가로크기와 세로크기를 지정하십시오.", ["가로크기","세로크기"],"생성","취소","fn_divCreationCallBack");
	};
	
	/* DIV 만들기 CallBack */
	fn_divCreationCallBack = function(param){
		
		if(param != ""){
			// 전체 div 시작
			var vsSource = "<div id=\"div" + vnDivContentCount + "\"";;
			vsSource += " class=\"div_content\" ";
			vsSource += " style=\"position:relative; margin-top:30px; width:"+param[0]+"px; height:"+param[1]+"px; border: 1px solid;\" ";
			vsSource += " onclick=\"fn_divOnClick(this)\"";
			vsSource += " >";

			vsSource += "</div>";

			$("#creationTable").append(vsSource);
			
			// divcontent영역 개수 증가
			vnDivContentCount ++;
			
			// right div 그리기
			fn_rightDraw();
				
		}
			
	}
	
	
	
	
	
	/* TITLE 만들기 */
	function titleCreation() {
		
		// div focus 여부
		if(!fn_divFocusYn()){
			return false;
		};
		
		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");
		// 타이틀 div 시작
		var vsSource = "  <div id=\"div" + vnTitleCount + "_title\"";
		vsSource += "   class=\"div_title\" width=\""+width+"\" ";
		vsSource += "   style=\"position:relative; text-align:left; margin:10px 0px 0px 5px;\" ";
		vsSource += "  onclick=\"fn_divTitleOnClick(this)\" ";
		vsSource += ">";
	
		// 타이틀 이미지
		vsSource += "  <img src=\"<c:url value='/images/egovframework/example/title_dot.gif'/>\" />";
	
		// 타이틀 span
		vsSource += "  <span id=\"span" + vnTitleCount + "_title\"";
		vsSource += "  class=\"span_title\" "
		vsSource += "  onclick=\"fn_spanTitleOnClick(this)\"> Title "
		vsSource += "  </span>";
		vsSource += "  </div>";
		
		$(voFocusDivInfo).append(vsSource);
		
		vnTitleCount++;
		
		// right div 그리기
		fn_rightDraw();

	};
	
	
	/* button 만들기 */
	function buttonCreation() {
		
		// div focus 여부
		if(!fn_divFocusYn()){
			return false;
		};
		
		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");
		// 타이틀 div 시작
		var vsSource = "  <div id=\"div" + vnDivButtonCount + "_button\"";
		vsSource += "   class=\"div_button\" width=\""+width+"\"";
		vsSource += "   style=\"position:relative; text-align:right;\" ";
		vsSource += "   onclick=\"fn_divButtonOnClick(this)\"";
		vsSource += ">";
	
		// 타이틀 span
		vsSource += "  <input type=\"button\" id=\"div" + vnDivButtonCount + "_title_button" + vnButtonCount+"\"";
		vsSource += "  class=\"button\" "
		vsSource += "  value=\"button\" "
		vsSource += "  onclick=\"fn_buttonOnClick(this)\">"
		vsSource += "  </input>";
		vsSource += "  </div>";
		
		$(voFocusDivInfo).append(vsSource);
		
		vnDivButtonCount++;
		vnButtonCount++;
		
		// right div 그리기
		fn_rightDraw();

	};
	

	
	
	
	/* 테이블그리기 */
	function tableCreation() {
		
		// div focus 여부
		if(!fn_divFocusYn()){
			return false;
		};
		
		robot.prompt("행과 열의 갯수를 지정하십시오.", ["행","열"],"생성","취소","fn_tableCreationCallBack");

	};
	
	
	/* 테이블그리기 CallBack */
	fn_tableCreationCallBack = function(param) {

		// 부모 가로크기
		var width = $(voFocusDivInfo).css("width");

		// div table 시작
		var vsTableSource = "  <div id=\"div" + vnTableCount + "_table\"";
		vsTableSource += "   class=\"div_table\" ";
		vsTableSource += "   style=\"position:relative; padding:10px 0px 10px 0px; width:"+(width-5)+"\" ";
		vsTableSource += "  onclick=\"fn_divTableOnClick(this)\" "
		vsTableSource += ">";

		// table 시작
		vsTableSource += "<table id=\"table" + vnTableCount + "\"";;
		vsTableSource += " class=\"table\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" ";
		vsTableSource += " style=\"position:relative; margin:0px 12px 0px 12px; width:"+(width-24)+"\">";
		vsTableSource += "\n <colgroup>";

		for (var i = 0; i < param[0]; i++) {
			//짝수 셀
			if(i % 2 == 0){
				vsTableSource += "\n  <col width=\"100\"/>";
			// 홀수 셀
			} else{
				vsTableSource += "\n  <col width=\"200\"/>";
			}
			
		}
		vsTableSource += "\n </colgroup>";
		
		//tbody 추가
		vsTableSource += "\n <tbody>"

		for (var i = 0; i < param[1]; i++) {
			vsTableSource += "\n <tr>";
			for (var j = 0; j < param[0]; j++) {
				vsTableSource += "\n  <td class=\"tbtd_content creationTd\" "
				vsTableSource += "name=\"tbtd_"+j+"\""
				vsTableSource += "style=\"height:30px;\" "
				vsTableSource += "onclick=\"fn_tdOnClick(this)\" "
				vsTableSource += "ondblclick=\"fn_tdDbClick(this)\"> "
				vsTableSource += "</td>";
			}
			vsTableSource += "\n </tr>";
		}
		
		//tbody 추가
		vsTableSource += "\n </tbody>"

		vsTableSource += "</table>";
		vsTableSource += "</div>";

		$(voFocusDivInfo).append(vsTableSource);

		vnTableCount++;
		
		// right div 그리기
		fn_rightDraw();

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
		fn_draggable();
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
		
		vsCompoClickDvs = "divTitle";
		voFocusDivInfo = param;

	}
	
	
	/* 스팬타이틀 Onclick */
	fn_spanTitleOnClick = function(param) {
		
		vsCompoClickDvs = "title";
		
		var title = prompt("타이틀을 입력하시오");
		if(title != null){
			param.textContent = title;
		}

	}
	
	
	
	/* div 버튼 Onclick */
	fn_divButtonOnClick = function(param) {
		
		vsCompoClickDvs = "divButton";
		voFocusDivInfo = param;

	}
	
	
	/* 버튼 Onclick */
	fn_buttonOnClick = function(param) {
		
		vsCompoClickDvs = "button";
		
		var buttonNm = prompt("버튼명을 입력하시오");
		if(buttonNm != null && buttonNm != ""){
			$(param).val(buttonNm);
		}

	}
	
	/* div 테이블 Onclick */
	fn_divTableOnClick = function(param) {
		
		if(vsCompoClickDvs != "td"){
			vsCompoClickDvs = "divTable";
			voFocusDivInfo = param;
		}
		

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
			robot.alert("div를 선택하여 주시기 바랍니다.")
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
	
	
	
	

	/* 글 등록 화면 function */
	fn_createSource = function() {
		// html 만들기
		var vsHtml = $("#creationTable").html();
		//prompt로 우선 vsbusinessNm을 받는다
		var vsbusinessNm = prompt("업무명");
		//var vsbusinessNm = $("#businessNm").val();
		var vsStyle = $("style").html();
		
		if(vsbusinessNm == null || vsbusinessNm == ""){
			alert("업무명을 입력하시오");
			return false;
		}
		var vjCreationInfo = {
				"html" : vsHtml,
				"businessNm" : vsbusinessNm,
				"style" : vsStyle
		}
		
		$.ajax({
			url : "/creationHTML.do",
			type : "POST",
			data : vjCreationInfo,
			success : function() {
				alert("완료");

			},
			error : function() {
			}
		})
	}
		// 모든소스 만들기
/* 		var vjCreationInfo = $("#creationForm").serialize();

		$.ajax({
			url : "/creationSource.do",
			type : "POST",
			data : vjCreationInfo,
			success : function() {
				alert("완료");

			},
			error : function() {
			}
		}) */
	
	
		
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
				<table width="50%" border="1" cellpadding="0" cellspacing="0" style="align: center; bordercolor: #D3E2EC; bordercolordark: #FFFFFF; border-collapse: collapse;">
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
		<table id="propertyTable">
			<tr>
				<!-- 이거로 검색. -->
				<td><input type="text" id="Search"></input></td>
				<td><input type="button" onclick="infoSearch();" value="검색"></input><td>
				<td><input type="button" onclick="infoUpdate();" value="수정"></input></td>
			</tr>
		</table>
	</div>
	
	<div style="width: 150px; float: right;">
		<ul id="sortable">
		</ul>
	</div>
</body>
</html>