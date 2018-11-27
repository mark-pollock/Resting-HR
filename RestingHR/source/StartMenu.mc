using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;



class StartMenu extends WatchUi.View {

	function initialize(){
		View.initialize();
	}
	
	function onUpdate(dc){
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		dc.drawText(dc.getWidth() / 2, 20, Graphics.FONT_LARGE, "Press start", Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(dc.getWidth() / 2, 60, Graphics.FONT_LARGE, "to commence", Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(dc.getWidth() / 2, 100, Graphics.FONT_LARGE, "resting heart rate", Graphics.TEXT_JUSTIFY_CENTER);
		dc.drawText(dc.getWidth() / 2, 140, Graphics.FONT_LARGE, "test.", Graphics.TEXT_JUSTIFY_CENTER);
	}
}


class StartMenu_BehaviorDelegate extends WatchUi.BehaviorDelegate{
	function initialize(){
		BehaviorDelegate.initialize();
	}

	function onKeyPressed(keyEvent){
		if(keyEvent.getKey() == WatchUi.KEY_ENTER ||
			keyEvent.getKey() == WatchUi.KEY_START){
			WatchUi.switchToView(new MainView(), new MainView_BehaviorDelegate(), WatchUi.SLIDE_LEFT);
		}
	}
}