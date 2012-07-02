package com.panda.services;

import java.util.List;

import com.panda.dao.Room;
import com.panda.dao.RoomDAO;

public class RoomService {
	private RoomDAO roomDao;
	public List<Room> getRooms() {
		// TODO Auto-generated method stub
		return roomDao.findAll();
	}
	public RoomDAO getRoomDao() {
		return roomDao;
	}
	public void setRoomDao(RoomDAO roomDao) {
		this.roomDao = roomDao;
	}

}
