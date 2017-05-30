package com.thinkgem.jeesite.modules.message;

import java.io.IOException;
import java.util.concurrent.TimeoutException;

import com.rabbitmq.client.AMQP.Queue.DeclareOk;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

public class Program {
	private final static String QUEUE_NAME = "hello";
    public static void main(String[] args) throws IOException, TimeoutException {
    	ConnectionFactory factory = new ConnectionFactory();
	    factory.setHost("127.0.0.1");
	    Connection connection = factory.newConnection();
	    Channel channel = connection.createChannel();
	    channel.queueDeclare(QUEUE_NAME, true, false, false, null);
	    String message = "Hello World!";
	    
	    channel.basicPublish("", QUEUE_NAME, null, message.getBytes("UTF-8"));
	    System.out.println("P [x] Sent '" + message + "'");
	    channel.close();
	    connection.close();
	    
    }

}