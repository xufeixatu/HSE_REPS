/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catalog.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course_catalog.entity.CourseCatalog;
import com.thinkgem.jeesite.modules.course_catalog.dao.CourseCatalogDao;

/**
 * 课件类别管理Service
 * @author 曹洪运
 * @version 2017-06-01
 */
@Service
@Transactional(readOnly = true)
public class CourseCatalogService extends TreeService<CourseCatalogDao, CourseCatalog> {

	public CourseCatalog get(String id) {
		return super.get(id);
	}
	
	public List<CourseCatalog> findList(CourseCatalog courseCatalog) {
		if (StringUtils.isNotBlank(courseCatalog.getParentIds())){
			courseCatalog.setParentIds(","+courseCatalog.getParentIds()+",");
		}
		return super.findList(courseCatalog);
	}
	
	@Transactional(readOnly = false)
	public void save(CourseCatalog courseCatalog) {
		super.save(courseCatalog);
	}
	
	@Transactional(readOnly = false)
	public void delete(CourseCatalog courseCatalog) {
		super.delete(courseCatalog);
	}
	
}