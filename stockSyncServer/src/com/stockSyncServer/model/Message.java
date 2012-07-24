package com.stockSyncServer.model;

public class Message {
	private String head = null;						//消息标题
	private Object content = null;					//消息内容
	private int messNum = 0;						//信息编号
	
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public Object getContent() {
		return content;
	}
	public void setContent(Object content) {
		this.content = content;
	}
	
	/**
	 * 获得信息编号
	 * @return
	 */
	public int getMessNum() {
		return messNum;
	}
	/**
	 * 设置信息编号
	 * @param messNum
	 */
	public void setMessNum(int messNum) {
		this.messNum = messNum;
	}

}
