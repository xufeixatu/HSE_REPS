/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.web;

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
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.actcard.service.ActcardService;

/**
 * ACT卡Controller
 * @author 岳鑫
 * @version 2017-05-23
 */
@Controller
@RequestMapping(value = "${adminPath}/actcard/actcard")
public class ActcardController extends BaseController {

	@Autowired
	private ActcardService actcardService;
	
	@ModelAttribute
	public Actcard get(@RequestParam(required=false) String id) {
		Actcard entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = actcardService.get(id);
		}
		if (entity == null){
			entity = new Actcard();
		}
		return entity;
	}
	
	@RequiresPermissions("actcard:actcard:view")
	@RequestMapping(value = {"list", ""})
	public String list(Actcard actcard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Actcard> page = actcardService.findPage(new Page<Actcard>(request, response), actcard); 
		model.addAttribute("page", page);
		return "modules/actcard/actcardList";
	}

	@RequiresPermissions("actcard:actcard:view")
	@RequestMapping(value = "form")
	public String form(Actcard actcard, Model model) {
		
		String view = "actcardForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(actcard.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = actcard.getAct().getTaskDefKey();
			
			// 查看工单
			if(actcard.getAct().isFinishTask()){
				view = "actcardView";
			}
			// 修改环节
			else if ("modify".equals(taskDefKey)){
				view = "actcardForm";
			}
			// 指定解决人员环节
			else if ("appoint".equals(taskDefKey)){
				view = "actcardAppoint";
			}
			// 解决环节
			else if ("solve".equals(taskDefKey)){
				view = "actcardSolve";
			}

		}

		model.addAttribute("actcard", actcard);
		return "modules/actcard/" + view;

	}

	@RequiresPermissions("actcard:actcard:edit")
	@RequestMapping(value = "save")
	public String save(Actcard actcard, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, actcard)){
			return form(actcard, model);
		}
		actcardService.save(actcard);
		addMessage(redirectAttributes, "保存ACT卡成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcard/?repage";
	}
	
	@RequiresPermissions("actcard:actcard:edit")
	@RequestMapping(value = "delete")
	public String delete(Actcard actcard, RedirectAttributes redirectAttributes) {
		actcardService.delete(actcard);
		addMessage(redirectAttributes, "删除ACT卡成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcard/?repage";
	}

}