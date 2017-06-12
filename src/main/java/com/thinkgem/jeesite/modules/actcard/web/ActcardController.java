/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.web;

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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardUnsafeDao;
import com.thinkgem.jeesite.modules.actcard.dao.ActcardUnsafeEventDao;
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardReview;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafe;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafeEvent;
import com.thinkgem.jeesite.modules.actcard.service.ActcardService;
import com.thinkgem.jeesite.modules.actcard.service.ActcardUnsafeEventService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

/**
 * ACT卡Controller
 * @author 岳鑫
 * @version 2017-05-30
 */
@Controller
@RequestMapping(value = "${adminPath}/actcard/actcard")
public class ActcardController extends BaseController {

	@Autowired
	private ActcardService actcardService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private ActcardUnsafeEventDao actcardUnsafeEventDao;
	@Autowired
	private ActcardUnsafeDao actcardUnsafeDao;
	
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
		model.addAttribute("actcard", actcard);
		//model.addAttribute("menuList", systemService.findAllMenu());
		model.addAttribute("actcardUnsafeEventList", actcardUnsafeEventDao.findAllList(new ActcardUnsafeEvent()));
		String unids = actcard.getActcardUnsafeEventId();
		if(null!=unids && unids.length()>1){
			//当unids.length()大于1时为提交过的数据，只查询被选择的数据
//			unids = unids.substring(0, unids.length()-1);
//			unids = "'"+unids.replaceAll(",", "','")+"'";
			List<ActcardUnsafe> list = actcardUnsafeDao.findListByActcardId(actcard.getId());
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setId(list.get(i).getUnsafeEventId());
			}
			model.addAttribute("actcardUnsafeEventList2", list);
//			System.out.println(actcardUnsafeEventDao.findCheckedList(unids).size());
		}
		
		return "modules/actcard/actcardForm";
	}
	
	
	
	@RequiresPermissions("actcard:actcard:view")
	@RequestMapping(value = "view")
	public String view(Actcard actcard, Model model) {
		model.addAttribute("actcard", actcard);
		String unids = actcard.getActcardUnsafeEventId();
		if(null!=unids && unids.length()>1){
			List<ActcardUnsafe> list = actcardUnsafeDao.findListByActcardId(actcard.getId());
			for (int i = 0; i < list.size(); i++) {
				list.get(i).setId(list.get(i).getUnsafeEventId());
			}
			model.addAttribute("actcardUnsafeEventList2", list);
			System.out.println("list.size()----->"+list.size());
		}
		return "modules/actcard/actcardView";
	}
	
	@RequiresPermissions("actcard:actcard:view")
	@RequestMapping(value = "review")
	public String review(ActcardReview actcardReview, Model model) {
		actcardService.review(actcardService.get(actcardReview.getActcard().getId()), actcardReview);
		Actcard actcard = actcardService.get(actcardReview.getActcard().getId());
		model.addAttribute("actcard", actcard);
		return "modules/actcard/actcardView";
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