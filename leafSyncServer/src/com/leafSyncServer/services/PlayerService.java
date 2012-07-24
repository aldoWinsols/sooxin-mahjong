package com.leafSyncServer.services;

import com.leafSyncServer.model.Player;

public class PlayerService {

	private Player player;
	
	public PlayerService(){
		player = new Player();
	}

	public Player getPlayer() {
		return player;
	}

	public void setPlayer(Player player) {
		this.player = player;
	}
	
	
	
}
