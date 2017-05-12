package com.thinkgem.jeesite.modules.message.utils;

import java.util.Date;

import com.google.gson.Gson;
import com.thinkgem.jeesite.modules.message.dao.MessageDao;
import com.thinkgem.jeesite.modules.message.dao.MessageDaoImpl;
import com.thinkgem.jeesite.modules.message.model.Message;
import com.thinkgem.jeesite.modules.message.msg.Producer;

import redis.clients.jedis.Jedis;

public class MsgUtils {
	static MessageDao md = new MessageDaoImpl();
	
	public static Jedis setUp() {
		Jedis jedis = new Jedis(Constant.host, Constant.port);
		jedis.flushAll();
		jedis.disconnect();
		return jedis;
	}
	public static void pushMessage(String userId, String[] receivedId, String content)
			throws InterruptedException {
		Gson gson = new Gson();
		Producer p = new Producer(new Jedis(Constant.host, Constant.port), userId);
		 for(int i=0;i<receivedId.length;i++){
		 Message msg = new Message();
		 msg.setMessageId(CommonUtils.uuid());
		 msg.setReceivedId(receivedId[i]);
		 msg.setSendUserId(userId);
		 msg.setSendTime(new Date().toString());
		 msg.setText(content);
		 md.insertMessage(msg);
		 p.publish(gson.toJson(msg));
		 }

	}
	public static void close(String channel) {
		Jedis jedis = new Jedis(Constant.host, Constant.port);
		jedis.publish(channel, "quit");
		jedis.del(channel);//
	}

	public static void main(String[] args) throws InterruptedException {
		setUp();
		pushMessage("1", new String[]{"1","1","1","2"}, "222");
//		Consumer c = new Consumer(new Jedis(Constant.host, Constant.port), "1", "1");
//		
//		long start = Calendar.getInstance().getTimeInMillis();
//		String m = null;
//		c.consume(new Callback() {
//			@Override
//			public void onMessage(String message) {
//				System.out.println(message);
		
//			}
//		});
//		do {
//			m = c.consume();
//			System.out.println("consume------"+c.consume());
//			System.out.println("unreadMessages------"+c.unreadMessages());
//			System.out.println("read---------"+c.read());
//		} while (m != null);
//		long elapsed = Calendar.getInstance().getTimeInMillis() - start;

	}
}
