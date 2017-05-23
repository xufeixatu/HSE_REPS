/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.risk.entity.RiskAccess;
import com.thinkgem.jeesite.modules.risk.entity.RiskSaferesult;
import com.thinkgem.jeesite.modules.risk.service.RiskAccessService;

/**
 * riskController
 * @author lily
 * @version 2017-05-18
 */
@Controller
@RequestMapping(value = "${adminPath}/risk/riskAccess")
public class RiskAccessController extends BaseController {

	@Autowired
	private RiskAccessService riskAccessService;
	
	@ModelAttribute
	public RiskAccess get(@RequestParam(required=false) String id) {
		RiskAccess entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = riskAccessService.get(id);
		}
		if (entity == null){
			entity = new RiskAccess();
		}
		return entity;
	}
	
	@RequiresPermissions("risk:riskAccess:view")
	@RequestMapping(value = {"list", ""})
	public String list(RiskAccess riskAccess, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RiskAccess> page = riskAccessService.findPage(new Page<RiskAccess>(request, response), riskAccess); 
		model.addAttribute("page", page);
		if(riskAccess==null||riskAccess.getRiskType()==null){
			return "modules/risk/riskAccessList";		
		}else if(riskAccess.getRiskType().equals("0")){
			return "modules/risk/riskAccessList";			
		}else if(riskAccess.getRiskType().equals("1")){
			return "modules/risk/riskAccessList2";			
		}
		else if(riskAccess.getRiskType().equals("2")){
			return "modules/risk/riskAccessList3";			
		}
		else if(riskAccess.getRiskType().equals("3")){
			return "modules/risk/riskAccessList4";			
		}
		else if(riskAccess.getRiskType().equals("4")){
			return "modules/risk/riskAccessList5";			
		}else{
			return "modules/risk/riskAccessList";		
		}
	}
	
	@RequiresPermissions("risk:riskAccess:view")
	@RequestMapping(value = "form")
	public String form(RiskAccess riskAccess, Model model) {
		model.addAttribute("riskAccess", riskAccess);
		return "modules/risk/riskAccessForm";
	}

	/**
	 * 风险分析
	 * @param riskAccess
	 * @param model
	 * @return
	 */
	@RequiresPermissions("risk:riskAccess:view")
	@RequestMapping(value = "analyse")
	public String analyse(RiskAccess riskAccess, Model model) {
		riskAccessService.analyse(riskAccess);
		model.addAttribute("riskAccess", riskAccess);
		return "modules/risk/riskAccessAnalyseForm";
	}

	@RequiresPermissions("risk:riskAccess:view")
	@RequestMapping(value = "envirFactorForm")
	public String environment(RiskAccess riskAccess, Model model) {
	
		model.addAttribute("riskAccess", riskAccess);
		return "modules/risk/envirFactorForm";
	}

	@RequiresPermissions("risk:riskAccess:edit")
	@RequestMapping(value = "save")
	public String save(RiskAccess riskAccess, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, riskAccess)){
			return form(riskAccess, model);
		}
	        
		riskAccessService.save(riskAccess);
		addMessage(redirectAttributes, "保存风险成功");
		return "redirect:"+Global.getAdminPath()+"/risk/riskAccess/?repage";
	}
	
	@RequiresPermissions("risk:riskAccess:edit")
	@RequestMapping(value = "delete")
	public String delete(RiskAccess riskAccess, RedirectAttributes redirectAttributes) {
		riskAccessService.delete(riskAccess);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/risk/riskAccess/?repage";
	}

}