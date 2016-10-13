package com.cc.framework.web.admin;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.cc.framework.model.ResultMap;
import com.cc.framework.model.SysLog;
import com.cc.framework.service.LogService;
import com.cc.framework.web.BaseController;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/admin/log")
public class SysLogController extends BaseController {

	@Autowired
	private LogService logService;

	/**
	 * 列表
	 */
	@RequestMapping("/list.json")
	@ResponseBody
	public Map<String, Object> list(@RequestParam(value="limit",required=false) int limit,
			@RequestParam(value="offset",required=false) int offset,@ModelAttribute(value="admin") SysLog log){
		if(limit == 0) limit = this.pageSize;
		HashMap<String, Object> result = new HashMap<String, Object>();
		int pageNum = (offset/limit)+1;
		if(StringUtils.isEmpty(log.getOperation())) log.setOperation(null);
		if(StringUtils.isEmpty(log.getOperator())) log.setOperator(null);
		if(StringUtils.isEmpty(log.getIp()))log.setIp(null);
		PageInfo<SysLog> pageInfo = logService.selectByPage(log, pageNum, limit);
		result.put("rows", pageInfo.getList());
		result.put("total", pageInfo.getTotal());
		return result;
	}
	
	@RequestMapping("/index")
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView("/admin/log/index");
		return mv;
	}

	/**
	 * 查看
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view(Long id, ModelMap model) {
		model.addAttribute("log", logService.selectByKey(id));
		return "/admin/log/view";
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/del.json", method = RequestMethod.POST)
	public @ResponseBody
	ResultMap delete(Long[] ids) {
		logService.batchDel(ids);
		return this.success("删除成功!");
	}

	/**
	 * 清空
	 */
	@RequestMapping(value = "/clear", method = RequestMethod.POST)
	public @ResponseBody
	ResultMap clear() {
		logService.clear();
		return this.success("清空成功!");
	}

}