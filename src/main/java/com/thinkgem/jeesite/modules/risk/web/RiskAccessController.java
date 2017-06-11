/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.risk.web;

import java.io.IOException;
import java.util.Date;
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

import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.risk.entity.RiskAccess;
import com.thinkgem.jeesite.modules.risk.entity.RiskSaferesult;
import com.thinkgem.jeesite.modules.risk.service.RiskAccessService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

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
	/**
	 * 导出风险控制的模板
	 * @param riskAccess
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequiresPermissions("risk:riskAccess:view")
	@RequestMapping(value = "exceltemplate")
	public void exceltemplate(RiskAccess riskAccess,HttpServletRequest request, HttpServletResponse response, Model model) {
		ExportExcel exportExcel=new ExportExcel("风险控制模板", RiskAccess.class, 2);
		try {
			exportExcel.write(response, "风险控制模板.xlsx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 导出风险控制数据
	 * @param riskAccess
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequiresPermissions("risk:riskAccess:view")
	@RequestMapping(value = "excel")
	public void excel(RiskAccess riskAccess,HttpServletRequest request, HttpServletResponse response, Model model) {
		ExportExcel exportExcel=new ExportExcel("风险控制数据", RiskAccess.class, 1);
		try {
			exportExcel.write(response, "风险控制数据.xlsx");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 导入往年历史记录
	 * @param riskAccess
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("risk:riskAccess:edit")
	@RequestMapping(value = "importHistroy")
	public String importHistory(RiskAccess riskAccess, HttpServletRequest request, HttpServletResponse response, Model model, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/risk/riskAccess/list?repage";
		}
		
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			List<RiskAccess> list =riskAccessService.findList(riskAccess);
			if(list.isEmpty()){
				addMessage(redirectAttributes, riskAccess.getYears()+"年份的风险为空");				
			}else{
				for (RiskAccess risk :list) {
					RiskAccess temp=new RiskAccess();
					temp.setYears(riskAccess.getYears());
					temp.setNumber(riskAccess.getNumber());
					if(risk.getNumber()!=null&&riskAccessService.findList(temp).get(0).getYears().equals(risk.getNumber())){
						failureMsg.append("</br>编号为"+risk.getNumber()+"的风险已经存在");
						failureNum++;
					}else{
						risk.setYears(new Date());
						risk.setId(null);
						riskAccessService.save(risk);
						successNum++;
					}
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条关键环节，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条关键环节记录" + failureMsg);
			}catch (Exception e) {
				addMessage(redirectAttributes, "导入往年失败！失败信息：" + e.getMessage());
			}
		
		
		return "redirect:" + adminPath + "/risk/riskAccess/list?repage";
	}
	/**
	 * 导入关键环节数据
	 * @param file
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + adminPath + "/risk/riskAccess/list?repage";
		}
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<RiskAccess> list = ei.getDataList(RiskAccess.class);
			for (RiskAccess risk : list) {
				try {
					if (risk.getPlaceDevice().isEmpty()) {
						failureMsg.append("<br/>设备物料不能为空");
						failureNum++;
					} else if (risk.getWorkName().isEmpty())  {
						failureMsg.append("<br/>作业活动名称/活动、物料、产品、服务不能为空");
						failureNum++;
					}else if (risk.getRiskFactors().isEmpty())  {
						failureMsg.append("<br/>危害因素不能为空");
						failureNum++;
					}else{
						risk.setRiskType("0");
						riskAccessService.save(risk);
						successNum++;
					}
				} catch (ConstraintViolationException ex) {
					failureMsg.append("<br/>风险 " +risk.getWorkName() + " 导入失败：");
					List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList) {
						failureMsg.append(message + "; ");
						failureNum++;
					}
				} catch (Exception ex) {
					failureMsg.append("<br/>风险 " + risk.getWorkName() + " 导入失败：" + ex.getMessage());
				}
			}
			if (failureNum > 0) {
				failureMsg.insert(0, "，失败 " + failureNum + " 条关键环节，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum + " 条关键环节记录" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入关键环节失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/risk/riskAccess/list?repage";
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

	/**
	 * 环境因素分析
	 * @param riskAccess 
	 * @param model
	 * @return
	 */
	@RequiresPermissions("risk:riskAccess:view")
	@RequestMapping(value = "analyse_envir")
	public String analyse_envir(RiskAccess riskAccess, Model model) {
		riskAccessService.analyse_envir(riskAccess);
		model.addAttribute("riskAccess", riskAccess);
		return "modules/risk/riskAccessEnvirAnalyseForm";
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