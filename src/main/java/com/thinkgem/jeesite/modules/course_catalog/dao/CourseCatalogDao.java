/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catalog.dao;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.course_catalog.entity.CourseCatalog;

/**
 * 课件类别管理DAO接口
 * @author 曹洪运
 * @version 2017-06-01
 */
@MyBatisDao
public interface CourseCatalogDao extends TreeDao<CourseCatalog> {
	
}