package com.thinkgem.jeesite.modules.sys.utils;

import com.thinkgem.jeesite.common.utils.SpringContextHolder;
import com.thinkgem.jeesite.modules.sys.dao.OfficeDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;

public class OfficeUtil {
	private static OfficeDao officeDao = SpringContextHolder.getBean(OfficeDao.class);
	
	public static Office getOfficeById(String id){
		return officeDao.get(id);
	}
}
