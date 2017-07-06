/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsk.dao;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zsk.entity.ZskClass;

/**
 * 知识库分类DAO接口
 * @author 郭凯凯
 * @version 2017-04-20
 */
@MyBatisDao
public interface ZskClassDao extends TreeDao<ZskClass> {
	
}