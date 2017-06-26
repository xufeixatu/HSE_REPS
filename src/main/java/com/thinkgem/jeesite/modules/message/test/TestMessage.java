package com.thinkgem.jeesite.modules.message.test;

import java.util.List;

import org.junit.Test;

import com.thinkgem.jeesite.modules.message.dao.MessageDao;
import com.thinkgem.jeesite.modules.message.dao.MessageDaoImpl;
import com.thinkgem.jeesite.modules.message.model.Message;
import com.thinkgem.jeesite.modules.message.msg.Producer;
import com.thinkgem.jeesite.modules.message.utils.Constant;
import com.thinkgem.jeesite.modules.message.utils.MsgUtils;

import redis.clients.jedis.Jedis;

public class TestMessage {
	MessageDao md = new MessageDaoImpl();
	Message m = new Message();
//	@Test
//	public void getList() {
//		List<HMessage> list=md.getMessageByReceivedId("3");
//		System.out.println(list);
//	}
	@Test
	public void getList() {
		List<Message> lists = md.getAllMessage();
		for(Message list:lists){
			System.out.println(list);
		}
	}
//	public static void main(String[] args) {
//		Producer p = new Producer(new Jedis(Constant.host),"1");
//		p.publish("some cool message");
//	}
}
