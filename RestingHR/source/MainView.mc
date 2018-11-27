using Toybox.WatchUi;
using Toybox.System;
using Toybox.Graphics;
using Toybox.Sensor;

using Toybox.ActivityRecording;
using Toybox.FitContributor;


var global_bestAverage;
var global_avgPeriod = 10;


class MainView extends WatchUi.View {
    var string_HR;
    var HR_graph;
    var field1Height;
    var field2Height;
    var field3Height;
    var field4Height;
    
    var label1Height;
    var label2Height;
    var label3Height;
    var label4Height;
    
    
    var HR_min;
    var HR_bestAvg;
 	var HR_sampleTime;
 
    var string_bestAvg;
    var string_min;
    var string_currentAvg;
    
    var string_label1;
    var string_label2;
    var string_label3;
    var string_label4;
    
    var arr;
    var avgPeriod;
    var inForeground;
    
    function onShow(){
    	inForeground = true;
    }
    
    function onHide(){
    	inForeground = false;
    	global_bestAverage = HR_bestAvg;
    	RHR_field.setData(global_bestAverage);
    }

	function initialize(){
		View.initialize();
		Sensor.setEnabledSensors( [Sensor.SENSOR_HEARTRATE] );
       	
        Sensor.enableSensorEvents( method(:onSnsr) );
        

        string_HR = "---bpm";
        
        label1Height = 0;
        field1Height = 17;
        
        label2Height = 53;
        field2Height = 70;
        
        label3Height = 106;
        field3Height = 123;
        
        label4Height = 159;
        field4Height = 176;
        
        
        HR_min = -1;
        HR_bestAvg = -1;
        
        HR_sampleTime = 1;
        
        avgPeriod = global_avgPeriod;
        
        string_currentAvg = "---bpm";
        string_bestAvg = "---bpm";
        string_min = "---bpm";
        
        string_label1 = "Current";
	    string_label2 = "Current " + avgPeriod + "sec Avg";
	    string_label3 = "Minimum " + avgPeriod + " sec Avg";
	    string_label4 = "Global Minimum";
        
        
        // create array
        arr = new[avgPeriod / HR_sampleTime];
        
        for(var i = 0; i < avgPeriod / HR_sampleTime; i += 1){
        	arr[i] = -1;
        }
        global_bestAverage = -1;       
        //here

        //startRecording();
	}
	
	function onUpdate(dc){
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        
        dc.drawText(dc.getWidth() / 2, label1Height, Graphics.FONT_TINY, string_label1, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, field1Height, Graphics.FONT_LARGE, string_HR, Graphics.TEXT_JUSTIFY_CENTER);
        
        
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, label2Height, Graphics.FONT_TINY, string_label2, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, field2Height, Graphics.FONT_LARGE, string_currentAvg, Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, label3Height, Graphics.FONT_TINY, string_label3, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, field3Height, Graphics.FONT_LARGE, string_bestAvg, Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Graphics.COLOR_PURPLE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, label4Height, Graphics.FONT_TINY, string_label4, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, field4Height, Graphics.FONT_LARGE, string_min, Graphics.TEXT_JUSTIFY_CENTER);
	}
	
	function onSnsr(sensor_info){
		if(inForeground){
	        var HR = sensor_info.heartRate;
	        var bucket;
	        
	        var currentAvg = 0;
	        var valid = true;
	        
	        for(var i = 1; i < avgPeriod / HR_sampleTime; i += 1){
	        	if(arr[i] > 0){
	        		currentAvg += arr[i];
	        	}else{
	        		valid = false;
	        	}
	        	arr[i-1] = arr[i];
	        }
	
	        
	        
	        if( sensor_info.heartRate != null )
	        
	        {
		        arr[avgPeriod / HR_sampleTime - 1] = HR;
		        currentAvg += HR;
		        
		        if (valid){
		        	currentAvg = currentAvg / (avgPeriod / HR_sampleTime);
		        	string_currentAvg = currentAvg.toString() + "bpm";
		        }else{
		        	currentAvg = - 1;
	            	string_currentAvg = "---bpm";
		        }
	        
	        	if((currentAvg < HR_bestAvg || HR_bestAvg == -1) && currentAvg != -1){
	        		HR_bestAvg = currentAvg;
	        		//here
	        		//RHR_field.setData(global_bestAverage);
	        		string_bestAvg = HR_bestAvg.toString() + "bpm";
	        	}
	        	
	        	
	        	if(HR < HR_min || HR_min == -1){
	        		HR_min = HR;
	        		string_min = HR_min.toString() + "bpm";
	        	}
	        	
	        	string_HR = HR.toString() + "bpm";
	        }
	        else
	        {
	        	arr[avgPeriod / HR_sampleTime - 1] = -1;
	            string_HR = "---bpm";
	            string_currentAvg = "---bpm";
	        }
			for(var i = 0; i < avgPeriod / HR_sampleTime; i += 1){
				System.print(arr[i] + ", ");
			}
			System.println("");
			
			WatchUi.requestUpdate();
		}else{
			for(var i = 1; i < avgPeriod / HR_sampleTime; i += 1){
				arr[i-1] = arr[i];
			}
			arr[avgPeriod / HR_sampleTime - 1] = -1;
			
			for(var i = 0; i < avgPeriod / HR_sampleTime; i += 1){
				System.print(arr[i] + ", ");
			}
			System.println("");
		}
    }
    
}




class MainView_BehaviorDelegate extends WatchUi.BehaviorDelegate{
	function initialize(){
		BehaviorDelegate.initialize();
	}
	function onKeyPressed(keyEvent){
		if(keyEvent.getKey() == WatchUi.KEY_ENTER ||
			keyEvent.getKey() == WatchUi.KEY_START){
			
			WatchUi.pushView(new Rez.Menus.StopMenu(), new StopMenu_MenuDelegate(), WatchUi.SLIDE_LEFT);
		}
	}
}


function startRecording(){

	var RHR_FIELD_ID = 0;
	record = ActivityRecording.createSession(
		{	:name=>"RHR_SessionName",
			:sport=>ActivityRecording.SPORT_GENERIC,
			:subSport=>ActivityRecording.SUB_SPORT_GENERIC
		}	
	);
	record.start();

	RHR_field = record.createField(
		"RHR",
		RHR_FIELD_ID,
		FitContributor.DATA_TYPE_SINT16,
		{:mesgType=>FitContributor.MESG_TYPE_SESSION, :units=>"bpm"}
	);


	
	System.println("session started");

}