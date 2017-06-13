/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.actcard.dao;

import java.util.Date;
import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.actcard.entity.Actcard;

/**
 * ACT卡DAO接口
 * @author 岳鑫
 * @version 2017-05-30
 */
@MyBatisDao
public interface ActcardDao extends CrudDao<Actcard> {

	List<Actcard> findActcards(String officeid, Date startTime, Date endTime);
	
}