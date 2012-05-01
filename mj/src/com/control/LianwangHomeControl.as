package com.control
{
	import com.milkmangames.nativeextensions.ios.*;
	import com.milkmangames.nativeextensions.ios.events.StoreKitErrorEvent;
	import com.milkmangames.nativeextensions.ios.events.StoreKitEvent;
	import com.model.Alert;
	
	import com.services.MainPlayerService;
	import com.services.MainSyncService;
	import com.view.LianwangHome;
	
	import flash.events.MouseEvent;
	
	import mx.rpc.events.ResultEvent;

	public class LianwangHomeControl
	{
		public var lianwangHome:LianwangHome;
		private static const D60_PRODUCT_ID:String="com.sooxin.mahjongM.d60";
		private static const D250_PRODUCT_ID:String="com.sooxin.mahjongM.d250";
		private var loadedProducts:Vector.<StoreKitProduct>;
		
		public static var instance:LianwangHomeControl;
		
		public function LianwangHomeControl(lianwangHome:LianwangHome)
		{
			instance = this;
			this.lianwangHome = lianwangHome;
			
			this.lianwangHome.currentState = "log";
			this.lianwangHome.currentState = "main";
			
			MainPlayerService.getInstance();
			
			//-----------------------------------------------------------------
			
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
			productIdList.push(D60_PRODUCT_ID);
			productIdList.push(D250_PRODUCT_ID);
			
			
			// when this is done, we'll get a PRODUCT_DETAILS_LOADED or PRODUCT_DETAILS_FAILED event and go on from there...
			StoreKit.storeKit.loadProductDetails(productIdList);
			//---------------------------------------------------------------------------
		}
		
		
		public function log(s:String):void{
			
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
			log("Successful purchase of '"+e.productId+"'");
			
			// update our sharedobject with the state of this inventory item.
			// this is just an example to make the process clear.  you will
			// want to make your own inventory manager class to handle these
			// types of things.
			//				var inventory:Object=sharedObject.data["inventory"];
			switch(e.productId)
			{
				case D60_PRODUCT_ID:
					MainPlayerService.getInstance().chongzhi(60);
					break;
				case D60_PRODUCT_ID:
					MainPlayerService.getInstance().chongzhi(250);
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
	}
}