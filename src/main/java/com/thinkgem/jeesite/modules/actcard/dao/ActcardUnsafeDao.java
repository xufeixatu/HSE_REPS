/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.actcard.entity.ActcardUnsafe;

/**
 * actcard_unsafe关联表DAO接口
 * @author 岳鑫
 * @version 2017-06-07
 */
@MyBatisDao
public interface ActcardUnsafeDao extends CrudDao<ActcardUnsafe> {

	List<ActcardUnsafe> findListByActcardId(String actcardId);
	
}