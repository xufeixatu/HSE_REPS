/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.zsk.entity.ZskClass;
import com.thinkgem.jeesite.modules.zsk.dao.ZskClassDao;

/**
 * 知识库分类Service
 * @author 郭凯凯
 * @version 2017-04-20
 */
@Service
@Transactional(readOnly = true)
public class ZskClassService extends TreeService<ZskClassDao, ZskClass> {

	public ZskClass get(String id) {
		return super.get(id);
	}
	
	public List<ZskClass> findList(ZskClass zskClass) {
		if (StringUtils.isNotBlank(zskClass.getParentIds())){
			zskClass.setParentIds(","+zskClass.getParentIds()+",");
		}
		return super.findList(zskClass);
	}
	
	@Transactional(readOnly = false)
	public void save(ZskClass zskClass) {
		super.save(zskClass);
	}
	
	@Transactional(readOnly = false)
	public void delete(ZskClass zskClass) {
		super.delete(zskClass);
	}
	
}