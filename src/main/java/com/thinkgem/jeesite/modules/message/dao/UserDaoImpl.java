package com.thinkgem.jeesite.modules.message.dao;

import com.thinkgem.jeesite.modules.message.db.BaseDAO;
import com.thinkgem.jeesite.modules.message.model.HUser;

public class UserDaoImpl extends BaseDAO<HUser> implements UserDao {

	@Override
	public HUser getUser(String userId) {
		String sql="select *from msg_user where userId=?";
		return (HUser)get(HUser.class,sql,userId);
	}
	@Override
	public boolean insertUser(HUser user) {
		String sql="INSERT INTO msg_user (userId,userName,loginName,password,avatarUrl,"
				+ "avatarUrlNative,avatarFile,groupId,remark,token) VALUES" 
				+"(?,?,?,?,?,?,?,?,?,?)";
		return update(sql,user.getUserId(),user.getUserName(),user.getLoginName(),user.getPassword(),user.getAvatarUrl(),
				user.getAvatarUrlNative(),user.getAvatarFile(),user.getGroupId(),user.getRemark(),user.getToken());
	}

	@Override
	public boolean updateUser(HUser user) {
	 String sql="update msg_user set userName=?,loginName=?,password=?,avatarUrl=?,avatarUrlNative=?"
				+ ",avatarFile=?,groupId=?, remark=?,token=?where userId=?";
	 update(sql,user.getUserName(),user.getLoginName(),user.getPassword(),user.getAvatarUrl(),
				user.getAvatarUrlNative(),user.getAvatarFile(),user.getGroupId(),user.getRemark(),user.getToken(),user.getUserId());
	 return true;
	}

	@Override
	public boolean deleteUser(String userId) {
		 String sql="delete from msg_user where userId=?";
		 update(sql,userId);
		 return true;
	}

}
