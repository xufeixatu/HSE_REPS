package com.thinkgem.jeesite.modules.work.workSqlMapFilter;

import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;

@Component
@Scope("prototype")
public class WorkPlanSqlMapFilter {
	/**
	 * 保存在model中的工作计划类别（个人，公司，部门等类别）数据字典对象的键
	 */
	public final static String PLAN_TYPE_DICT_KEY = "planTypeDict";

	private Map<String, String> sqlMap = null;
	private StringBuffer dsf = new StringBuffer();
	private Dict planTypeDict = null;

	public static WorkPlanSqlMapFilter getFilter() {
		return new WorkPlanSqlMapFilter();
	}

	public void common(WorkPlan workPlan, Model model) {
		planTypeDict = DictUtils.getDictByValue(workPlan.getPlanType(), "type_plan");
		model.addAttribute(PLAN_TYPE_DICT_KEY, planTypeDict);
		sqlMap = workPlan.getSqlMap();

		if (sqlMap.get("dsf") != null && !"".equals(sqlMap.get("dsf"))) {
			dsf.append(sqlMap.get("dsf"));
			dsf.append(" ");
		}
	}

	/**
	 * 根据工作计划中的计划类别（个人计划，部门计划，公司计划）生成过滤条件保存在sqlMap.dsf中
	 * 
	 * @param workPlan
	 * @param model
	 */
	public void typePersonFilterSqlMapDsf(WorkPlan workPlan, Model model) {
		common(workPlan, model);

		// 设置根据计划类别（个人计划｜｜部门计划｜｜公司计划）过滤工作计划条件字符串
		dsf.append("and");
		dsf.append(" ");
		dsf.append("a.plan_type = '");
		dsf.append(planTypeDict.getId());
		dsf.append("'");

		// 只看本人创建的数据
		dsf.append(" and ");
		dsf.append("a.create_by = '");
		dsf.append(UserUtils.getUser().getId());
		dsf.append("'");

		// 将字符串加回到sqlMap.dsf属性
		sqlMap.put("dsf", dsf.toString());
	}

	/**
	 * 
	 * 个人工作：责任人是自己的必须处理所有工作
	 * 
	 * @param workPlan
	 * @param model
	 */
	public void typeliableFilter(WorkPlan workPlan, Model model) {
		common(workPlan, model);

		User me = UserUtils.getUser();
		dsf.append("and ");
		dsf.append("a.person_liable_id='");
		dsf.append(me.getId());
		dsf.append("' ");

		// 将字符串加回到sqlMap.dsf属性
		sqlMap.put("dsf", dsf.toString());
	}

	/**
	 * 
	 * 部门工作：自己所在部门必须处理所有工作
	 * 
	 * @param workPlan
	 * @param model
	 */
	public void typeDeptFilter(WorkPlan workPlan, Model model) {
		common(workPlan, model);
		// 设置根据计划类别（个人计划｜｜部门计划｜｜公司计划）过滤工作计划条件字符串
		dsf.append("and");
		dsf.append(" ");
		dsf.append("a.plan_type = '");
		dsf.append(planTypeDict.getId());
		dsf.append("' ");
		Office me = UserUtils.getUser().getOffice();
		dsf.append("and ");
		dsf.append("a.depts like '%");
		dsf.append(me.getId());
		dsf.append("%' ");

		// 将字符串加回到sqlMap.dsf属性
		sqlMap.put("dsf", dsf.toString());
	}

	/**
	 * 
	 * 部门工作：公司处理所有工作
	 * 
	 * @param workPlan
	 * @param model
	 */
	public void typeCompnayFilter(WorkPlan workPlan, Model model) {
		common(workPlan, model);
		planTypeDict = DictUtils.getDictByValue("company", "type_plan");
		dsf.append("and");
		dsf.append(" ");
		dsf.append("a.plan_type = '");
		dsf.append(planTypeDict.getId());
		dsf.append("' ");
		dsf.append("and");
		dsf.append(" (");
		dsf.append("a.is_open = 0");//开放状态
		dsf.append(" or ");
		dsf.append("a.person_liable_id='");
		dsf.append(UserUtils.getUser().getId());
		dsf.append("' or ");
		dsf.append("a.assigner_id='");
		dsf.append(UserUtils.getUser().getId());
		dsf.append("') ");
		
		// 将字符串加回到sqlMap.dsf属性
		sqlMap.put("dsf", dsf.toString());
	}
	/**
	 * 过滤所有已经提交状态的公司级工作计划
	 *    work_state_id = '45d756f45bb04155adb95e66b6a0d1c1'
	 * @param id
	 */
	public void typeSubmittedCompanyWorkPlanyFilter(WorkPlan workPlan, Model model){
		common(workPlan, model);
		planTypeDict = DictUtils.getDictByValue("company", "type_plan");
		dsf.append("and");
		dsf.append(" ");
		dsf.append("a.plan_type = '");
		dsf.append(planTypeDict.getId());
		dsf.append("' ");
		dsf.append("and");
		dsf.append(" ");
		dsf.append("a.work_state_id = '45d756f45bb04155adb95e66b6a0d1c1'");
		
		// 将字符串加回到sqlMap.dsf属性
		sqlMap.put("dsf", dsf.toString());
	}

	/**
	 * 过滤出所有end_state为"已分派"状态的公司级工作计划
	 * @param workPlan
	 * @param model
	 */
	public void typeRemainCompanyWorkPlanyFilter(WorkPlan workPlan, Model model) {
		common(workPlan, model);
		planTypeDict = DictUtils.getDictByValue("company", "type_plan");
		dsf.append("and");
		dsf.append(" ");
		dsf.append("a.plan_type = '");
		dsf.append(planTypeDict.getId());
		dsf.append("' ");
		dsf.append("and");
		dsf.append(" ");
		dsf.append("a.end_state_id = '042bb2ce059249729da41c7995e4381b' ");
		// 将字符串加回到sqlMap.dsf属性
		sqlMap.put("dsf", dsf.toString());
	}

	
}
