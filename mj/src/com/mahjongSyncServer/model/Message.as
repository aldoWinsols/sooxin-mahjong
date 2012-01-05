package com.mahjongSyncServer.model
{

public class Message {
	private var _head:String = null;						//消息标题
	private var _content:Object = null;					//消息内容
	private var _messNum:int = 0;						//信息编号
	
	

	public function get messNum():int
	{
		return _messNum;
	}

	public function set messNum(value:int):void
	{
		_messNum = value;
	}

	public function get content():Object
	{
		return _content;
	}

	public function set content(value:Object):void
	{
		_content = value;
	}

	public function get head():String
	{
		return _head;
	}

	public function set head(value:String):void
	{
		_head = value;
	}

}
}
