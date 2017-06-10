/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.adm.web;

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
import com.thinkgem.jeesite.modules.adm.entity.ShopAdmin;
import com.thinkgem.jeesite.modules.adm.service.ShopAdminService;

/**
 * 管理员Controller
 * @author 小文
 * @version 2017-05-21
 */

@Controller

@RequestMapping(value = "${adminPath}/adm/shopAdmin")

public class ShopAdminController extends BaseController {


	@Autowired
	private ShopAdminService shopAdminService;
	
	@ModelAttribute
	public ShopAdmin get(@RequestParam(required=false) String id) {
		ShopAdmin entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = shopAdminService.get(id);
		}
		if (entity == null){
			entity = new ShopAdmin();
		}
		return entity;
	}
	
	@RequiresPermissions("adm:shopAdmin:view")
	@RequestMapping(value = {"list", ""})
	public String list(ShopAdmin shopAdmin, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ShopAdmin> page = shopAdminService.findPage(new Page<ShopAdmin>(request, response), shopAdmin); 
		model.addAttribute("page", page);
		return "modules/adm/shopAdminList";
	}

	@RequiresPermissions("adm:shopAdmin:view")
	@RequestMapping(value = "form")
	public String form(ShopAdmin shopAdmin, Model model) {
		model.addAttribute("shopAdmin", shopAdmin);
		return "modules/adm/shopAdminForm";
	}

	@RequiresPermissions("adm:shopAdmin:edit")
	@RequestMapping(value = "save")
	public String save(ShopAdmin shopAdmin, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, shopAdmin)){
			return form(shopAdmin, model);
		}
		shopAdminService.save(shopAdmin);
		addMessage(redirectAttributes, "保存增删改成功");
		return "redirect:"+Global.getAdminPath()+"/adm/shopAdmin/?repage";
	}
	
	@RequiresPermissions("adm:shopAdmin:edit")
	@RequestMapping(value = "delete")
	public String delete(ShopAdmin shopAdmin, RedirectAttributes redirectAttributes) {
		shopAdminService.delete(shopAdmin);
		addMessage(redirectAttributes, "删除增删改成功");
		return "redirect:"+Global.getAdminPath()+"/adm/shopAdmin/?repage";
	}

}