/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.course_catelog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course_catelog.entity.CourseCatelog;
import com.thinkgem.jeesite.modules.course_catelog.dao.CourseCatelogDao;

/**
 * 课件目录Service
 * @author 王少昌
 * @version 2017-05-17
 */
@Service
@Transactional(readOnly = true)
public class CourseCatelogService extends CrudService<CourseCatelogDao, CourseCatelog> {

	
	public CourseCatelog get(String id) {
		CourseCatelog courseCatelog = super.get(id);
		return courseCatelog;
	}
	
	public List<CourseCatelog> findList(CourseCatelog courseCatelog) {
		return super.findList(courseCatelog);
	}
	
	public Page<CourseCatelog> findPage(Page<CourseCatelog> page, CourseCatelog courseCatelog) {
		return super.findPage(page, courseCatelog);
	}
	
	@Transactional(readOnly = false)
	public void save(CourseCatelog courseCatelog) {
		super.save(courseCatelog);
	}
	
	@Transactional(readOnly = false)
	public void delete(CourseCatelog courseCatelog) {
		super.delete(courseCatelog);
	}
	
}