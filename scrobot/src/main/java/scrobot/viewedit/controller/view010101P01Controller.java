
package scrobot.viewedit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import scrobot.sourceFileGenerator.Application;
import scrobot.viewedit.service.view010101P01Service;
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
public class view010101P01Controller {
	
	/** view010101Service */
	@Resource(name = "view010101P01Service")
	private view010101P01Service view010101P01service;
	
	/***
	 * HTML 만들기를 실행한다.
	 */
	@RequestMapping(value = "/retrieveWrk.ajax", produces = "application/text; charset=utf8" )
	@ResponseBody
	public ModelAndView retrieveWrk(@RequestParam Map<String, Object> paramMap, SessionStatus status, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		paramMap.put("userId", userId);
		List<EgovMap> wrkList = view010101P01service.retrieveWrkList(paramMap);
		List<EgovMap> wrkHistryList = view010101P01service.retrieveWrkHistryList(paramMap);
		
		Map<String, Object> resultMap = new HashMap();
		
		resultMap.put("wrkList", wrkList);
		resultMap.put("wrkHistryList", wrkHistryList);
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		mav.addObject("resultMap",resultMap);
		return mav;
	}
	


}
