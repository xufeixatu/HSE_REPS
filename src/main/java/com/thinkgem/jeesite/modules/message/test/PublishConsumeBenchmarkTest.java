package com.thinkgem.jeesite.modules.message.test;

import java.io.IOException;
import java.util.Calendar;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.thinkgem.jeesite.modules.message.msg.Consumer;
import com.thinkgem.jeesite.modules.message.msg.Producer;

import redis.clients.jedis.Jedis;

public class PublishConsumeBenchmarkTest extends Assert {
    @Before
    public void setUp() throws IOException {
        Jedis jedis = new Jedis("localhost");
        jedis.flushAll();
        jedis.disconnect();

    }

//    @Test
//    public void publish() {
//        final String topic = "fo";
//        final String message = "hello ld!";
//        final int MESSAGES = 10000;
//        Producer p = new Producer(new Jedis("localhost"), topic);
//
//        long start = Calendar.getInstance().getTimeInMillis();
//        for (int n = 0; n < MESSAGES; n++) {
//            p.publish(message);
//        }
//        long elapsed = Calendar.getInstance().getTimeInMillis() - start;
//        System.out.println(((1000 * MESSAGES) / elapsed) + " ops");
//    }

    @Test
    public void consume() {
        final String topic = "foo";
        final String message = "hello world!";
        final int MESSAGES = 10;
        Producer p = new Producer(new Jedis("localhost"), topic);
        Consumer c = new Consumer(new Jedis("localhost"), "consumer", "foo");
        for (int n = 0; n < MESSAGES; n++) {
            p.publish(message);
        }

        long start = Calendar.getInstance().getTimeInMillis();
        String m = null;
        do {
            m = c.consume();
            System.out.println(c.consume());
        } while (m != null);
        long elapsed = Calendar.getInstance().getTimeInMillis() - start;

        System.out.println(((1000 * MESSAGES) / elapsed) + " ops");
    }
}