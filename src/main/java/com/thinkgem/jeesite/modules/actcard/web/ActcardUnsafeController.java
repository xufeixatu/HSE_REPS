/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.web;

import java.util.ArrayList;
import java.util.Date;
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
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafe;
import com.thinkgem.jeesite.modules.actcard.service.ActcardUnsafeService;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;

/**
 * actcard_unsafe关联表Controller
 * @author 岳鑫
 * @version 2017-06-07
 */
@Controller
@RequestMapping(value = "${adminPath}/actcard/actcardUnsafe")
public class ActcardUnsafeController extends BaseController {

	@Autowired
	private ActcardUnsafeService actcardUnsafeService;
	
	@Autowired
	private OfficeDao officeDao;
	
	@ModelAttribute
	public ActcardUnsafe get(@RequestParam(required=false) String id) {
		ActcardUnsafe entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = actcardUnsafeService.get(id);
		}
		if (entity == null){
			entity = new ActcardUnsafe();
		}
		return entity;
	}
	
	@RequiresPermissions("actcard:actcardUnsafe:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActcardUnsafe actcardUnsafe, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActcardUnsafe> page = actcardUnsafeService.findPage(new Page<ActcardUnsafe>(request, response), actcardUnsafe); 
		model.addAttribute("page", page);
		return "modules/actcard/actcardUnsafeList";
	}

	@RequiresPermissions("actcard:actcardUnsafe:view")
	@RequestMapping(value = "countView")
	public String countView(Actcard actcard, Model model) {
		System.out.println("countView");
		model.addAttribute("actcard", actcard);
		return "modules/actcard/countView";
	}
	@RequiresPermissions("actcard:actcardUnsafe:view")
	@RequestMapping(value = "countUnsafeEvent")
	public String countUnsafeEvent(ActcardUnsafe actcardUnsafe, HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println(actcardUnsafe.getStartTime());
		System.out.println(actcardUnsafe.getEndTime());
		System.out.println(actcardUnsafe.getOfficeIds());
		model.addAttribute("officeNames", getAllOfficeNameByOfficeIds(actcardUnsafe.getOfficeIds()));
		model.addAttribute("unsafeEventDate", getAllUnsafeEvent(actcardUnsafe));
		
//		Page<ActcardUnsafe> page = actcardUnsafeService.findPage(new Page<ActcardUnsafe>(request, response), actcardUnsafe); 
//		model.addAttribute("page", page);
		return "modules/actcard/countView";
	}
	private String getAllUnsafeEvent(ActcardUnsafe actcardUnsafe){
		String ids = actcardUnsafe.getOfficeIds();
		Date startTime = actcardUnsafe.getStartTime();
		Date endTime = actcardUnsafe.getEndTime();
		String act = "{name:'不安全行为',data:[";
		String statue = "{name:'不安全状态',data:[";
		if(ids.length()>=1){
			String[] idsArr = ids.split(",");
			for (int i = 0; i < idsArr.length; i++) {
				int actNum = actcardUnsafeService.findUnsafeActById(idsArr[i],startTime,endTime);
				act += actNum+",";
				int actStatue = actcardUnsafeService.findUnsafeStatueById(idsArr[i],startTime,endTime);
				statue += actStatue+",";
			}
		}
		if(",".equals(act.substring(act.length()-1, act.length()))){
			act = act.substring(0, act.length()-1);
			statue = statue.substring(0, statue.length()-1);
		}
		act += "]}";
		statue += "]}";
		return "["+act+","+statue+"]";
	}
	private String getAllOfficeNameByOfficeIds(String ids){
//		List<Office> list = new ArrayList<Office>();
//		if(ids.length()>1){
//			String[] idsArr = ids.split(",");
//			for (int i = 0; i < idsArr.length; i++) {
//				list.add(officeDao.get(idsArr[i]));
//			}
//		}
		String names = "[";
		if(ids.length()>=1){
			String[] idsArr = ids.split(",");
			for (int i = 0; i < idsArr.length; i++) {
				names+= "'"+officeDao.get(idsArr[i]).getId()+officeDao.get(idsArr[i]).getName()+"',";
			}
		}
		if(",".equals(names.substring(names.length()-1, names.length()))){
			names = names.substring(0, names.length()-1);
		}
		names += "]";
		System.out.println(names);
		return names;
	}
	@RequiresPermissions("actcard:actcardUnsafe:view")
	@RequestMapping(value = "form")
	public String form(ActcardUnsafe actcardUnsafe, Model model) {
		model.addAttribute("actcardUnsafe", actcardUnsafe);
		return "modules/actcard/actcardUnsafeForm";
	}

	@RequiresPermissions("actcard:actcardUnsafe:edit")
	@RequestMapping(value = "save")
	public String save(ActcardUnsafe actcardUnsafe, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, actcardUnsafe)){
			return form(actcardUnsafe, model);
		}
		actcardUnsafeService.save(actcardUnsafe);
		addMessage(redirectAttributes, "保存actcard_unsafe关联表成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardUnsafe/?repage";
	}
	
	@RequiresPermissions("actcard:actcardUnsafe:edit")
	@RequestMapping(value = "delete")
	public String delete(ActcardUnsafe actcardUnsafe, RedirectAttributes redirectAttributes) {
		actcardUnsafeService.delete(actcardUnsafe);
		addMessage(redirectAttributes, "删除actcard_unsafe关联表成功");
		return "redirect:"+Global.getAdminPath()+"/actcard/actcardUnsafe/?repage";
	}

}