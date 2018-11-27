using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;

class StopMenu_MenuDelegate extends WatchUi.MenuInputDelegate{
	
	function initialize(){
		MenuInputDelegate.initialize();
	}

	function onMenuItem(item){
		if(item == :item_1){
			System.println("1");
		}else if(item == :item_2){
			// restart view
			WatchUi.popView(WatchUi.SLIDE_LEFT);
			WatchUi.switchToView(new MainView(), new MainView_BehaviorDelegate(), WatchUi.SLIDE_LEFT);
			System.println("2");
		}else if(item == :item_3){
			WatchUi.pushView(createSaveMenu(), new SaveMenu_MenuDelegate(), WatchUi.SLIDE_LEFT);
			System.println("3");
		}
	}
}

