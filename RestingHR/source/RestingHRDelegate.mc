using Toybox.WatchUi;

class RestingHRDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new RestingHRMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}