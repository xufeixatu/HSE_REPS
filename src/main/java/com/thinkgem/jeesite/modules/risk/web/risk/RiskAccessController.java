/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.web.risk;

import java.io.IOException;
import java.util.List;

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
import com.thinkgem.jeesite.common.supcan.treelist.cols.Group;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.risk.entity.risk.RiskAccess;
import com.thinkgem.jeesite.modules.risk.service.risk.RiskAccessService;

/**
 * riskController
 * @author lily
 * @version 2017-05-11
 */
@Controller
@RequestMapping(value = "${adminPath}/risk/risk/riskAccess")
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
	
	@RequiresPermissions("risk:risk:riskAccess:view")
	@RequestMapping(value = {"list", ""})
	public String list(RiskAccess riskAccess, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RiskAccess> page = riskAccessService.findPage(new Page<RiskAccess>(request, response), riskAccess); 
		model.addAttribute("page", page);
		return "modules/risk/risk/riskAccessList";
	}

	@RequiresPermissions("risk:risk:riskAccess:view")
	@RequestMapping(value = {"exportExcel", ""})
	public void exportExcel(RiskAccess riskAccess, HttpServletRequest request, HttpServletResponse response, Model model) {
		ExportExcel exportExcel=new ExportExcel("", RiskAccess.class,1,null);
		List<RiskAccess> listR = riskAccessService.findList(riskAccess);
		exportExcel.setDataList(listR);
		try {
			exportExcel.write(response, "moban.xlsx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequiresPermissions("risk:risk:riskAccess:view")
	@RequestMapping(value = "form")
	public String form(RiskAccess riskAccess, Model model) {
		model.addAttribute("riskAccess", riskAccess);
		return "modules/risk/risk/riskAccessForm";
	}

	@RequiresPermissions("risk:risk:riskAccess:edit")
	@RequestMapping(value = "save")
	public String save(RiskAccess riskAccess, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, riskAccess)){
			return form(riskAccess, model);
		}
		riskAccessService.save(riskAccess);
		addMessage(redirectAttributes, "保存risk成功");
		return "redirect:"+Global.getAdminPath()+"/risk/risk/riskAccess/?repage";
	}
	
	@RequiresPermissions("risk:risk:riskAccess:edit")
	@RequestMapping(value = "delete")
	public String delete(RiskAccess riskAccess, RedirectAttributes redirectAttributes) {
		riskAccessService.delete(riskAccess);
		addMessage(redirectAttributes, "删除risk成功");
		return "redirect:"+Global.getAdminPath()+"/risk/risk/riskAccess/?repage";
	}

}