
package scrobot.viewedit.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import scrobot.sourceFileGenerator.Application;
import scrobot.viewedit.service.view010101Service;
/**
 * @Class Name : viewEditController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class view010101Controller {
	
	/** view010101Service */
	@Resource(name = "view010101Service")
	private view010101Service view010101service;
	
	/**
	 * 화면그리기 화면을 조회한다.
	 */
	@RequestMapping(value = "/viewEdit.do", method = RequestMethod.GET, produces = "application/text; charset=utf8" )
	public String main() throws Exception {
		return "view/view010101";
	}
	
	/**
	 * 소스 만들기를 실행한다.
	 */
	@RequestMapping(value = "/creationSource.do", produces = "application/text; charset=utf8" )
	public void creationSource(@RequestParam Map<String, Object> param, SessionStatus status) throws Exception {
		Application.main(param);
	}
	
	/**
	 * HTML 만들기를 실행한다.
	 */
	@RequestMapping(value = "/creationHTML.do", produces = "application/text; charset=utf8" )
	public void creationHTML(@RequestParam Map<String, Object> paramMap, SessionStatus status, HttpServletRequest request) throws Exception {
		//paramMap = Application.creationHTML(paramMap);
		
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		paramMap.put("userId", userId);
		paramMap.put("wrkNm", paramMap.get("businessNm"));
		paramMap.put("source", paramMap.get("html"));
		view010101service.registViewDrawWrk(paramMap);
		view010101service.registViewDrawWrkHistry(paramMap);
	}
	



}
