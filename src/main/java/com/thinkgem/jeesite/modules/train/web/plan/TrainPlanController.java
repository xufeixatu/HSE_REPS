/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.train.web.plan;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.train.entity.plan.TrainPlan;
import com.thinkgem.jeesite.modules.train.service.plan.TrainPlanService;

/**
 * 培训计划信息Controller
 * @author peizhen
 * @version 2017-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/train/plan/trainPlan")
public class TrainPlanController extends BaseController {

	@Autowired
	private TrainPlanService trainPlanService;
	
	@ModelAttribute
	public TrainPlan get(@RequestParam(required=false) String id) {
		TrainPlan entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = trainPlanService.get(id);
		}
		if (entity == null){
			entity = new TrainPlan();
		}
		return entity;
	}
	
	@RequiresPermissions("train:plan:trainPlan:view")
	@RequestMapping(value = {"list", ""})
	public String list(TrainPlan trainPlan, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TrainPlan> page = trainPlanService.findPage(new Page<TrainPlan>(request, response), trainPlan); 
		model.addAttribute("page", page);
		return "modules/train/plan/trainPlanList";
	}

	@RequiresPermissions("train:plan:trainPlan:view")
	@RequestMapping(value = "form")
	public String form(TrainPlan trainPlan, Model model) {
		model.addAttribute("trainPlan", trainPlan);
		return "modules/train/plan/trainPlanForm";
	}

	@RequiresPermissions("train:plan:trainPlan:edit")
	@RequestMapping(value = "save")
	public String save(TrainPlan trainPlan, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, trainPlan)){
			return form(trainPlan, model);
		}
		trainPlanService.save(trainPlan);
		addMessage(redirectAttributes, "保存培训计划成功");
		return "redirect:"+Global.getAdminPath()+"/train/plan/trainPlan/?repage";
	}
	
	@RequiresPermissions("train:plan:trainPlan:edit")
	@RequestMapping(value = "delete")
	public String delete(TrainPlan trainPlan, RedirectAttributes redirectAttributes) {
		trainPlanService.delete(trainPlan);
		addMessage(redirectAttributes, "删除培训计划成功");
		return "redirect:"+Global.getAdminPath()+"/train/plan/trainPlan/?repage";
	}
	
	@RequiresPermissions("train:plan:trainPlan:edit")
	@RequestMapping(value = "start")
	public String start(TrainPlan trainPlan, RedirectAttributes redirectAttributes) {
		trainPlanService.start(trainPlan);
		addMessage(redirectAttributes, "启动培训计划"+trainPlan.getName()+"成功");
		return "redirect:"+Global.getAdminPath()+"/train/record/trainRecord/?repage";//跳转到自动生成的培训记录
	}

	/**
	 * 导出培训计划数据
	 * @param trainPlan
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("train:plan:trainPlan:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(TrainPlan trainPlan, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "培训计划数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            Page<TrainPlan> page = trainPlanService.findTrainPlan(new Page<TrainPlan>(request, response, -1), trainPlan);
    		new ExportExcel("培训计划数据", TrainPlan.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出培训计划失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/train/plan/trainPlan/list?repage";
    }

	/**
	 * 导入培训计划数据
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("train:plan:trainPlan:edit")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/train/plan/trainPlan/list?repage";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<TrainPlan> list = ei.getDataList(TrainPlan.class);
			for (TrainPlan trainPlan : list){
				try{
					trainPlanService.save(trainPlan);
					failureNum++;
					
				}catch(ConstraintViolationException ex){
					failureMsg.append("<br/>XXX "+trainPlan.getName()+" 导入失败：");
					List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList){
						failureMsg.append(message+"; ");
						failureNum++;
					}
				}catch (Exception ex) {
					failureMsg.append("<br/>XXX "+trainPlan.getName()+" 导入失败："+ex.getMessage());
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条培训计划，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 "+successNum+" 条培训计划"+failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入培训计划失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/train/plan/trainPlan/list?repage";
    }
	
	/**
	 * 下载导入培训计划数据模板
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("train:plan:trainPlan:view")
    @RequestMapping(value = "import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "培训计划数据导入模板.xlsx";
    		List<TrainPlan> list = Lists.newArrayList(); 
    		list.add(new TrainPlan());
    		new ExportExcel("培训计划数据", TrainPlan.class, 2).setDataList(list).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息："+e.getMessage());
		}
		return "redirect:" + adminPath + "/train/plan/trainPlan/list?repage";
    }
}