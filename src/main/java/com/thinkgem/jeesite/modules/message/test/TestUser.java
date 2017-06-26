package com.thinkgem.jeesite.modules.message.test;

import org.junit.Test;

import com.thinkgem.jeesite.modules.message.dao.UserDao;
import com.thinkgem.jeesite.modules.message.dao.UserDaoImpl;
import com.thinkgem.jeesite.modules.message.model.HGroup;
import com.thinkgem.jeesite.modules.message.model.HUser;



public class TestUser {
	UserDao ud=new UserDaoImpl();
	@Test
	public void addUser(){
		for(int i=0;i<10;i++){
			HUser user = new HUser();
			user.setUserId(String.valueOf(i));
			user.setUserName("username-"+String.valueOf(i));
			user.setLoginName("loginname-"+String.valueOf(i));
			user.setPassword("password-"+String.valueOf(i));
			user.setAvatarFile("avatarFile-"+String.valueOf(i));
			user.setAvatarUrl("avatarUrl-"+String.valueOf(i));
			user.setAvatarUrlNative("avatarUrlNative-"+String.valueOf(i));
//			user.setGroupId(new HGroup());
			user.setToken("token-"+String.valueOf(i));
			user.setRemark("remark-"+String.valueOf(i));
			ud.insertUser(user);
		}
	}
//	@Test
//	public void getUser(){
//		
//		System.out.println("getUser:"+ud.getUser("1"));
//	}
//	@Test
//	public void deleteUser(){
//		System.out.println("delete:"+ud.deleteUser("2"));
//	}
}
