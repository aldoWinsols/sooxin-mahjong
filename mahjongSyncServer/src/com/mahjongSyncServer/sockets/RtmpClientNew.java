package com.mahjongSyncServer.sockets;

import java.util.Map;

import org.red5.io.utils.ObjectMap;
import org.red5.server.api.event.IEvent;
import org.red5.server.api.event.IEventDispatcher;
import org.red5.server.api.service.IPendingServiceCall;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.net.rtmp.INetStreamEventHandler;
import org.red5.server.net.rtmp.RTMPClient;
import org.red5.server.net.rtmp.RTMPConnection;
import org.red5.server.net.rtmp.codec.RTMP;
import org.red5.server.net.rtmp.event.Notify;
import org.slf4j.Logger;

import com.mahjongSyncServer.util.UtilProperties;

public class RtmpClientNew extends RTMPClient implements
		INetStreamEventHandler, IPendingServiceCallback, IEventDispatcher {

	private String host = UtilProperties.instance.getMainServerIp();
	private String app = UtilProperties.instance.getMainApp();
	private int port = 1935;
	private Logger log = null; // 日志文件操作类

	public RtmpClientNew() {
		super();

		log = UtilProperties.instance.getLogger(RtmpClientNew.class);

		Map<String, Object> map = makeDefaultConnectionParams(host, port, app);

		connect(host, port, map, this, new String[] { "superAdmin", "",
				"111.92.237.33" });
	}

	@Override
	public void resultReceived(IPendingServiceCall call) {
		// TODO Auto-generated method stub
		Object result = call.getResult();

		if (result instanceof ObjectMap) {
			if ("connect".equals(call.getServiceMethodName())) {
				createStream(this);
				log.info("连接主服务成功!");
			}
		} else {
			if ("createStream".equals(call.getServiceMethodName())) {
				if (result instanceof Integer) {
					// String[] strings = { "gong", "系统测试消息!" };
					// invoke("managerSendAllPlayer", strings, this);
				} else {
					disconnect();
				}
			}
		}

	}
	
	public void sendRoomNum(int roomType, int roomNum){
		String[] strings = {String.valueOf(roomType), String.valueOf(roomNum)};
		this.invoke("sendRoomNum", strings, this);
	}

	@Override
	public void onStreamEvent(Notify arg0) {
		// TODO Auto-generated method stub
	}

	@Override
	public void dispatchEvent(IEvent arg0) {
		// TODO Auto-generated method stub
	}

	@Override
	public void connectionOpened(RTMPConnection conn, RTMP state) {
		// TODO Auto-generated method stub
		super.connectionOpened(conn, state);
	}
}
