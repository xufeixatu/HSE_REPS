/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.adm.dao;


import com.thinkgem.jeesite.common.persistence.CrudDao;

import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import com.thinkgem.jeesite.modules.adm.entity.ShopAdmin;


/**
 * 管理员DAO接口
 * @author 小文
 * @version 2017-05-21
 */

@MyBatisDao

public interface ShopAdminDao extends CrudDao<ShopAdmin> {

	
}