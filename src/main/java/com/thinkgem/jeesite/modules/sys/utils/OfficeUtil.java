package com.thinkgem.jeesite.modules.sys.utils;

import java.util.List;

import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;

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
	 * 查找当前用户任负责人的所有部门
	 * @param userid
	 * @return
	 */
	public static List<Office> getCurrentUserOfficeById(String userid){
		return officeDao.findCurrentUserOfficesById(userid);
	}
}
