
package scrobot.viewedit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import scrobot.viewedit.service.view010101P02Service;
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
public class view010101P02Controller {
	
	/** view010101Service */
	@Resource(name = "view010101P02Service")
	private view010101P02Service view010101P02service;
	
	@RequestMapping(value = "/retrieveWrkDetail.ajax", produces = "application/text; charset=utf8" )
	@ResponseBody
	public ModelAndView retrieveWrkDetail(@RequestParam Map<String, Object> paramMap, SessionStatus status, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		paramMap.put("userId", userId);
		
		ModelAndView mav = new ModelAndView("jsonView");
		
		List<EgovMap> eList = view010101P02service.retrieveWrkDetail(paramMap);
		
		mav.addObject("eList",eList);
		
		
		return mav;
	}

	
/*	@RequestMapping(value = "/view010101P02.do", produces = "application/text; charset=utf8" )
	public ModelAndView retrieveWrkDetailPop(HttpServletResponse Response, HttpServletRequest request) {
		
		
		return null;
	}*/
}
