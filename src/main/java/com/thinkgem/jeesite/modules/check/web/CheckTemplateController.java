/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.check.web;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.check.entity.CheckTemplate;
import com.thinkgem.jeesite.modules.check.service.CheckTemplateService;

/**
 * 检查模板管理Controller
 * @author hehui
 * @version 2017-05-08
 */
@Controller
@RequestMapping(value = "${adminPath}/check/checkTemplate")
public class CheckTemplateController extends BaseController {

	@Autowired
	private CheckTemplateService checkTemplateService;
	
	@ModelAttribute
	public CheckTemplate get(@RequestParam(required=false) String id) {
		CheckTemplate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = checkTemplateService.get(id);
		}
		if (entity == null){
			entity = new CheckTemplate();
		}
		return entity;
	}
	
	@RequiresPermissions("check:checkTemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(CheckTemplate checkTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CheckTemplate> page = checkTemplateService.findPage(new Page<CheckTemplate>(request, response), checkTemplate); 
		model.addAttribute("page", page);
		return "modules/check/checkTemplateList";
	}

	@RequiresPermissions("check:checkTemplate:view")
	@RequestMapping(value = "form")
	public String form(CheckTemplate checkTemplate, Model model) {
		model.addAttribute("checkTemplate", checkTemplate);
		return "modules/check/checkTemplateForm";
	}

	@RequiresPermissions("check:checkTemplate:edit")
	@RequestMapping(value = "save")
	public String save(MultipartFile file, CheckTemplate checkTemplate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, checkTemplate)){
			return form(checkTemplate, model);
		}
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			System.out.println(ei.getCellValue(ei.getRow(3), 3));
			
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		checkTemplateService.save(checkTemplate);
		addMessage(redirectAttributes, "保存检查模板管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTemplate/?repage";
	}
	
	@RequiresPermissions("check:checkTemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(CheckTemplate checkTemplate, RedirectAttributes redirectAttributes) {
		checkTemplateService.delete(checkTemplate);
		addMessage(redirectAttributes, "删除检查模板管理成功");
		return "redirect:"+Global.getAdminPath()+"/check/checkTemplate/?repage";
	}

}