package com.stock.control
{
	import com.milkmangames.nativeextensions.ios.StoreKit;
	import com.milkmangames.nativeextensions.ios.events.StoreKitErrorEvent;
	import com.milkmangames.nativeextensions.ios.events.StoreKitEvent;
	import com.stock.model.Alert;
	import com.stock.view.Chongzhi;

	public class ChongzhiControl
	{
		private var chongzhi:Chongzhi;
		public function ChongzhiControl(chongzhi:Chongzhi)
		{
			this.chongzhi = chongzhi;
			
			StoreKit.create();
			
			if (!StoreKit.storeKit.isStoreKitAvailable())
			{
				//				Alert.show("Store is disable on this device.");
				return;
			}
			
			// add listeners here
			StoreKit.storeKit.addEventListener(StoreKitEvent.PRODUCT_DETAILS_LOADED,onProductsLoaded);
			StoreKit.storeKit.addEventListener(StoreKitEvent.PURCHASE_SUCCEEDED,onPurchaseSuccess);
			StoreKit.storeKit.addEventListener(StoreKitEvent.PURCHASE_CANCELLED,onPurchaseUserCancelled);
			StoreKit.storeKit.addEventListener(StoreKitEvent.TRANSACTIONS_RESTORED,onTransactionsRestored);
			
			// adding error events. always listen for these to avoid your program failing.
			StoreKit.storeKit.addEventListener(StoreKitErrorEvent.PRODUCT_DETAILS_FAILED,onProductDetailsFailed);
			StoreKit.storeKit.addEventListener(StoreKitErrorEvent.PURCHASE_FAILED,onPurchaseFailed);
			StoreKit.storeKit.addEventListener(StoreKitErrorEvent.TRANSACTION_RESTORE_FAILED,onTransactionRestoreFailed);
			
			
			// the list of ids is passed in as an as3 vector (typed Array.)
			var productIdList:Vector.<String>=new Vector.<String>();
			productIdList.push("com.sooxin.mahjongM.d6");
			productIdList.push("com.sooxin.mahjongM.d12");
			productIdList.push("com.sooxin.mahjongM.d18");
			productIdList.push("com.sooxin.mahjongM.d25");
			productIdList.push("com.sooxin.mahjongM.d30");
			productIdList.push("com.sooxin.mahjongM.d50");
			productIdList.push("com.sooxin.mahjongM.d100");
			
			
			// when this is done, we'll get a PRODUCT_DETAILS_LOADED or PRODUCT_DETAILS_FAILED event and go on from there...
			StoreKit.storeKit.loadProductDetails(productIdList);
			//---------------------------------------------------------------------------
		}
		
		//----------------------------------------------------
		private function onProductsLoaded(e:StoreKitEvent):void
		{
			log("products loaded.");
			// save the products that were loaded locally  for later use.
			this.loadedProducts=e.validProducts;
			
			// if any of the product ids we tried to pass in were not found on the server,
			// we won't be able to by them so something is wrong.
			if (e.invalidProductIds!=null)
			{
				if (e.invalidProductIds.length>0)
				{
					log("[ERR]: these products not valid:"+e.invalidProductIds.join(","));
					return;
				}
			}
		}
		
		
		public function restoreTransactions():void
		{
			// apple reccommends you provide a button in your ui to restore purchases,
			// for users who mightve uninstalled then reinstalled your application, etc.
			log("requesting transaction restore...");
			StoreKit.storeKit.restoreTransactions();
		}
		
		//
		// Events
		//	
		
		
		private function onProductDetailsFailed(e:StoreKitErrorEvent):void
		{
			log("ERR loading products:"+e.text);
		}
		
		private function onPurchaseSuccess(e:StoreKitEvent):void
		{
			//			log("Successful purchase of '"+e.productId+"'");
			
			// update our sharedobject with the state of this inventory item.
			// this is just an example to make the process clear.  you will
			// want to make your own inventory manager class to handle these
			// types of things.
			//				var inventory:Object=sharedObject.data["inventory"];
			switch(e.productId)
			{
				case "com.sooxin.mahjongM.d6":
					MainPlayerService.getInstance().chongzhi(600,e.receipt);
					break;
				case "com.sooxin.mahjongM.d12":
					MainPlayerService.getInstance().chongzhi(1300,e.receipt);
					break;
				case "com.sooxin.mahjongM.d18":
					MainPlayerService.getInstance().chongzhi(2000,e.receipt);
					break;
				case "com.sooxin.mahjongM.d25":
					MainPlayerService.getInstance().chongzhi(2900,e.receipt);
					break;
				case "com.sooxin.mahjongM.d30":
					MainPlayerService.getInstance().chongzhi(3800,e.receipt);
					break;
				case "com.sooxin.mahjongM.d50":
					MainPlayerService.getInstance().chongzhi(7000,e.receipt);
					break;
				case "com.sooxin.mahjongM.d100":
					MainPlayerService.getInstance().chongzhi(15000,e.receipt);
					break;
				default:
					// we don't do anything for unknown items.
			}
			
			// save state!
			//				sharedObject.flush();
			
			// update the message on screen
			//				updateInventoryMessage();
		}
		
		private function onPurchaseFailed(e:StoreKitErrorEvent):void
		{
			log("Failure purchasing '"+e.productId+"', reason:"+e.text);
		}
		
		private function onPurchaseUserCancelled(e:StoreKitEvent):void
		{
			log("the user canceled the purchase for '"+e.productId+"'");
		}
		
		private function onTransactionsRestored(e:StoreKitEvent):void
		{
			log("transactions restored.");
			//				updateInventoryMessage();
		}
		
		private function onTransactionRestoreFailed(e:StoreKitErrorEvent):void
		{
			log("an error occurred in restore purchases:"+e.text);		
		}
		//----------------------------------------------------
		
		public function log(s:String):void{
			Alert.show(s);
		}
	}
}