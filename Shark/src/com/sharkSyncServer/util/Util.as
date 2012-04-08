package com.sharkSyncServer.util
{
	import com.sharkSyncServer.model.AllTouzhu;
	import com.sharkSyncServer.services.MainService;
	import com.sharkSyncServer.services.TimerServer;
	
	public class Util {
		
		//获取随机数字
		public static function getRandow():Number {
			var randowNO:Number = 0;
			randowNO = Math.round(Math.random() * 24); // 随机 0-24
	
			if (randowNO == 24) {
				randowNO += Math.round(Math.random() * 3);
			}
			return randowNO;
		}
		
		//获得吃大赔小的数字
		public static var randowNO:Vector.<int>;
		public static function getOnlyWinRandow():Number {
			randowNO = new Vector.<int>();
			var n:int = 0;
			//获得所有包赢的数字，并存储randowNO
			for(var i:int = 0; i < 27; i++){
				if(getPei(i)){
					randowNO.push(i);
				}
			}
			//随机返回一个稳赢的数字
			return randowNO[int(Math.random()*randowNO.length)];
		}
		
		//吃大赔小算法
	
		public static function getPei(ran:int):Boolean{
			var allTouzhu:AllTouzhu = MainService.getAllTouzhu(TimerServer.players);
			var resAnimal:String = "";
	
			var pValue:int = 0;
			var peiMoney:int = 0;
			
			if(ran == 0 || ran == 6 ||ran == 19 ){
				resAnimal = "xiongmao";
				pValue = 8;
				peiMoney = pValue * allTouzhu.xiongmaoAll + 2* allTouzhu.zoushouAll;
			}else if(ran == 1|| ran == 10){
				resAnimal = "shizi";
				pValue = 12;
				peiMoney = pValue * allTouzhu.shiziAll + 2* allTouzhu.zoushouAll;
			}
			else if(ran == 3|| ran == 8 || ran == 14 || ran == 21){
				resAnimal = "houzi";
				pValue = 6;
				peiMoney = pValue * allTouzhu.houziAll + 2* allTouzhu.zoushouAll;
			}
			else if(ran == 4|| ran == 11 || ran == 17){
				resAnimal = "laohu";
				pValue = 8;
				peiMoney = pValue * allTouzhu.laohuAll + 2* allTouzhu.zoushouAll;
			}
			else if(ran == 2|| ran == 9 || ran ==15 || ran == 20){
				resAnimal = "yanzi";
				pValue = 6;
				peiMoney = pValue * allTouzhu.yanziAll + 2* allTouzhu.feiqinAll;
			}
			else if(ran == 5|| ran == 16 || ran == 23){
				resAnimal = "kongque";
				pValue = 8;
				peiMoney = pValue * allTouzhu.kongqueAll + 2* allTouzhu.feiqinAll;
			}
			else if(ran == 7|| ran == 12 || ran == 18){
				resAnimal = "gezi";
				pValue = 8;
				peiMoney = pValue * allTouzhu.geziAll + 2* allTouzhu.feiqinAll;
			}
			else if(ran == 13|| ran == 22){
				resAnimal = "laoyin";
				pValue = 12;
				peiMoney = pValue * allTouzhu.laoyingAll + 2* allTouzhu.feiqinAll;
			}
			else if(ran == 24|| ran == 26 ){
				resAnimal = "dabaisha";
				pValue = 24;
				peiMoney = pValue * allTouzhu.dabaishaAll;
			}
			else if(ran == 25|| ran == 27 ){
				resAnimal = "lieqiang";
				peiMoney = 0;
			}
			
			if(peiMoney >= allTouzhu.allTouzhuNum()){
				return false;
			}
			
			//System.out.println("peiMoney:"+peiMoney +"  "+"allTouzhu.allTouzhuNum:"+allTouzhu.allTouzhuNum());
			
			
			return true;
		}
		
		public static function getResultAnimal(ran:int):String{
			var resAnimal:String = "";
			
			if(ran == 0 || ran == 6 ||ran == 19 ){
				resAnimal = "熊猫";
			}else if(ran == 1|| ran == 10){
				resAnimal = "狮子";
			}
			else if(ran == 3|| ran == 8 || ran == 14 || ran == 21){
				resAnimal = "猴子";
			}
			else if(ran == 4|| ran == 11 || ran == 17){
				resAnimal = "老虎";
			}
			else if(ran == 2|| ran == 9 || ran ==15 || ran == 20){
				resAnimal = "燕子";
			}
			else if(ran == 5|| ran == 16 || ran == 23){
				resAnimal = "孔雀";
			}
			else if(ran == 7|| ran == 12 || ran == 18){
				resAnimal = "鸽子";
			}
			else if(ran == 13|| ran == 22){
				resAnimal = "老鹰";
			}
			else if(ran == 24|| ran == 26 ){
				resAnimal = "大白鲨";
			}
			else if(ran == 25|| ran == 27 ){
				resAnimal = "猎枪";
			}
			return resAnimal;
		}
	}
}
