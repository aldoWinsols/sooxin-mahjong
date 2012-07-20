package com.mahjongSyncServer.util;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.red5.server.api.IAttributeStore;
import org.red5.server.api.IBasicScope;
import org.red5.server.api.IClient;
import org.red5.server.api.IScope;
import org.red5.server.api.event.IEvent;
import org.red5.server.api.service.IPendingServiceCallback;
import org.red5.server.api.service.IServiceCall;
import org.red5.server.api.service.IServiceCapableConnection;

/**
 * 机器人使用的连接对象，这里只是用于连接不能NULL
 * @author Administrator
 *
 */
public class ServiceConnection implements IServiceCapableConnection {

	@Override
	public void close() {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean connect(IScope arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean connect(IScope arg0, Object[] arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Iterator<IBasicScope> getBasicScopes() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public IClient getClient() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getClientBytesRead() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Map<String, Object> getConnectParams() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getDroppedMessages() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Encoding getEncoding() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getHost() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getLastPingTime() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getPath() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getPendingMessages() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long getReadBytes() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long getReadMessages() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getRemoteAddress() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> getRemoteAddresses() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getRemotePort() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public IScope getScope() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getSessionId() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getType() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public long getWrittenBytes() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public long getWrittenMessages() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void initialize(IClient arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean isConnected() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void ping() {
		// TODO Auto-generated method stub

	}

	@Override
	public Boolean getBoolAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Byte getByteAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Double getDoubleAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getIntAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<?> getListAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long getLongAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<?, ?> getMapAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Set<?> getSetAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Short getShortAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getStringAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getAttribute(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object getAttribute(String arg0, Object arg1) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Set<String> getAttributeNames() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getAttributes() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean hasAttribute(String arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeAttribute(String arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void removeAttributes() {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean setAttribute(String arg0, Object arg1) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void setAttributes(Map<String, Object> arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setAttributes(IAttributeStore arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void dispatchEvent(IEvent arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean handleEvent(IEvent arg0) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void notifyEvent(IEvent arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void invoke(IServiceCall arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void invoke(String arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void invoke(IServiceCall arg0, int arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void invoke(String arg0, IPendingServiceCallback arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void invoke(String arg0, Object[] arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void invoke(String arg0, Object[] arg1, IPendingServiceCallback arg2) {
		// TODO Auto-generated method stub

	}

	@Override
	public void notify(IServiceCall arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void notify(String arg0) {
		// TODO Auto-generated method stub

	}

	@Override
	public void notify(IServiceCall arg0, int arg1) {
		// TODO Auto-generated method stub

	}

	@Override
	public void notify(String arg0, Object[] arg1) {
		// TODO Auto-generated method stub

	}

}
