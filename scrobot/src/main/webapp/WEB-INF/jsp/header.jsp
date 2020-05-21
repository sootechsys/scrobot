<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


    <script src="https://code.jquery.com/jquery-2.2.1.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javaScript" language="javascript" defer="defer">

        /* 로그인 화면 function */
        fn_logOut = function () {

        	window.location.href = "/logout.do";
        }
    </script>

    <form:form id="header" name="header" method="post">
        <div id="header_content_pop">

        	<div id="header_table" style="width:500px;">
        		<table width="50%" border="1" cellpadding="0" cellspacing="0" style="align:center; bordercolor:#D3E2EC; bordercolordark:#FFFFFF;border-collapse: collapse; ">
        			<colgroup>
        				<col width="100"/>
        				<col width="100"/>
        			</colgroup>
        			<tr>
        				<td class="tbtd_content"><a href="/viewEdit.do">화면그리기</a></td>
        				<td class="tbtd_content"><a href="/egovSampleList.do">게시판</a></td>
        			</tr>
        		</table>
        		
        	</div>
			<input type="button" value="로그아웃" onclick="fn_logOut();"></input>
        </div>
    </form:form>
