using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;
using Toybox.FitContributor;
using Toybox.ActivityRecording;
using Toybox.Math;

var record;
var RHR_field;

class SaveMenu_MenuDelegate extends WatchUi.MenuInputDelegate{

	function initialize(){
		MenuInputDelegate.initialize();
	}
	function onMenuItem(item){
		if(item == :item_1){
			//saveHR();
			//RHR_field.setData(global_bestAverage);
			//System.println("done");
			record.stop();
			record.save();
			System.println("saved");
			System.exit();
		}else if(item == :item_2){
			System.println("2");
			//Discard
			System.exit();
		}
	}
}

function createSaveMenu(){
	var menu = new WatchUi.Menu();
	var titleString = "RHR = " + global_bestAverage;
	menu.setTitle(titleString);
	menu.addItem("Save and Exit", :item_1);
	menu.addItem("Discard and Exit", :item_2);
	return menu;
}

/*function saveHR(){
	var RHR_FIELD_ID = 17;
	record = ActivityRecording.createSession(
		{	:name=>"RHR_SessionName",
			:sport=>ActivityRecording.SPORT_GENERIC,
			:subSport=>ActivityRecording.SUB_SPORT_GENERIC
		}	
	);
	record.start();
	var RHR_field;
	RHR_field = record.createField(
		"RHR",
		RHR_FIELD_ID,
		FitContributor.DATA_TYPE_SINT16,
		{:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"bpm"}
	);
	RHR_field.setData(global_bestAverage);

	
	System.println("saved (apparently)");
	
	
}*/