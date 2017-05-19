package com.thinkgem.jeesite.modules.message.dao;

import com.thinkgem.jeesite.modules.message.model.HUser;
public interface UserDao {
	/**
	 * 用户模块处理信息
	 */
	//获取用户
	public abstract HUser getUser(String userId);
	//插入用户
	public abstract boolean insertUser(HUser user);
	//更新信息
	public abstract boolean updateUser(HUser user);
	//删除用户
	public abstract boolean deleteUser(String userId);
}
