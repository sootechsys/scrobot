package ${packagePath}.${businessNm}.controller;

import java.util.List;
import java.util.Map;
//TODO add spring...

/**
 * ${businessNm} controller
 * @author
 * @since ${now}
 */
@Controller
@RequestMapping("TODO")
public class ${businessNm} {


	/**
	 * ${businessNm} 조회
	 */
	@RequestMapping("TODO")
	public String ${businessNm}List(HttpServletRequest request, Model model){
		return "경로/${businessNm}List";
	}
	

	/**
	 * ${businessNm} 등록 폼
	 */
	@RequestMapping("TODO")
	public String ${businessNm}RegistForm(HttpServletRequest request, Model model){
		return "경로/${businessNm}RegistForm";
	}	

	/**
	 * ${businessNm} 등록처리
	 */
	@RequestMapping("TODO")
	public String ${businessNm}Regist(HttpServletRequest request, Model model){
		return "경로/${businessNm}RegistForm";
	}	
	

	/**
	 * ${businessNm} 수정 폼
	 */
	@RequestMapping("TODO")
	public String ${businessNm}UpdtForm(HttpServletRequest request, Model model){
		return "경로/${businessNm}UpdtForm";
	}	
	

	/**
	 * ${businessNm} 수정 처리
	 */
	@RequestMapping("TODO")
	public String ${businessNm}Updt(HttpServletRequest request, Model model){
		return "경로/${businessNm}Updt";
	}	
	

	/**
	 * ${businessNm} 삭제 처리
	 */
	@RequestMapping("TODO")
	public String ${businessNm}Delete(HttpServletRequest request, Model model){
		return "경로/${businessNm}Delete";
	}	
	
}