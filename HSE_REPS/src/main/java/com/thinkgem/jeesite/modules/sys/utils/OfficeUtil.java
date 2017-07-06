package com.thinkgem.jeesite.modules.sys.utils;

import java.util.List;

import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.work.entity.WorkPlan;

public class OfficeUtil {
	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);
	/**
	 * 根据部门ID查找部门
	 * @param id
	 * @return
	 */
	public static Office getOfficeById(String id){
		return officeDao.get(id);
	}
	
	/**
	 * 根据ID查询部门名称或多个部门名称集合
	 * @param id 参数可以是一个部门也可以是多个部门，多个部门ID用‘，’分开
	 * @return 一个或多个部门名称，多个部门名称用','分开
	 */
	public static String getOfficeNameById(String id){
		
		if(id.contains(",")){
			StringBuffer s = new StringBuffer();
			String[] ids = id.split(",");
			for(String i : ids){
				s.append(officeDao.get(i).getName());
				if(i != ids[ids.length - 1]){
					s.append(",");
				}
			}
			return s.toString();
		}
		return officeDao.get(id).getName();
	}
	
	/**
	 * 查找当前用户任负责人的所有部门
	 * @param userid
	 * @return
	 */
	public static List<Office> getCurrentUserOfficeById(WorkPlan workPlan){
		return officeDao.findCurrentUserOfficesById(workPlan);
	}
	
	
}
