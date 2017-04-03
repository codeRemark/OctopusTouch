
var Keystoke= {
    command: "Command",
    tab: "TAB",
    delete: "DELETE",
    enter: "ENTER",
    escape: "ESCAPE",
	space : "SPACE",
	
    down: "DOWN",
    up: "UP",

}



var KeyListener= {
    type: "Mac",
    onKeyPress : function(key) {
        //alert ( key); return ;
        _ajaxCall('SingleWordAction','','',key);
    },
    onUp :function(){
    	_ajaxCall('SingleWordAction','','','UP');
    },
    onDown :function(){
    	_ajaxCall('SingleWordAction','','','DOWN');
    },
    onLeft :function(){
        _ajaxCall('SingleWordAction','','','LEFT');
    },
    onRight :function(){
        _ajaxCall('SingleWordAction','','','RIGHT');
    },
    
    onCommandComboKey: function (key){
        _ajaxCall('FunctionKeyAction','Command', key, '');
    },
    
    onCommandTabKey: function (){
        _ajaxCall('FunctionKeyAction','Command', 'TAB', '');
    },
    
    onCommandBlankSpaceKey: function (){
        _ajaxCall('FunctionKeyAction','Command', Keystoke.space, '');
    },
	
	SystemEvent: function (){
        
    },
    
    screenOn : function(){
        var params =  "{\"brightness\" : 100}"
        _ajaxPostSysEvent(2, params); // light on
    },
    
    screenOff : function(){
        var params =  "{\"brightness\" : 0}"
        _ajaxPostSysEvent(2, params); // light off
    },
    
    sleep : function(){
        // sleep = 4 
        _ajaxPostSysEvent(4); // sleep
    },
    
    wake : function(){
        // wakeup = 5
        _ajaxPostSysEvent(5); // QTSystemEventWakeup
    },
    
    music : function(){
        // wakeup = 5
        _ajaxPostSysEvent(6); // QTSystemEventMusic
    },
    
    facetime : function(){
        // launch app = 1
         var params =  "{\"appName\" : \"FaceTime\"}";
        _ajaxPostSysEvent(1,params); // QTSystemEventLaunch
    },
    
    video : function(){
        // launch app = 1
        var params =  "{\"appName\" : \"QuickTime Player\"}";
        _ajaxPostSysEvent(1,params); // QTSystemEventLaunch
    }
}

/*
 static NSString* const kFunctionKey = @"functionKey";
 static NSString* const kPlainKey = @"plainKey";
 static NSString* const kContentKey = @"content ";
 
 */
function _ajaxCall (type,functionKey, plainKey, content){
    $.ajax({
           //The URL to process the request
           'url' : 'keyboard.event',
           //The type of request, also known as the "method" in HTML forms
           //Can be 'GET' or 'POST'
           'type' : 'POST',
           //Any post-data/get-data parameters
           //This is optional
           'data' : {
           		'type' : type,
                'functionKey' : functionKey,
                'plainKey' : plainKey,
                'content' : content
           }
      
           });
    
    
}

function _ajaxPostSysEvent (sysEventCode, params){
    $.ajax({
           //The URL to process the request
           'url' : 'keyboard.event',
           //The type of request, also known as the "method" in HTML forms
           //Can be 'GET' or 'POST'
           'type' : 'POST',
           //Any post-data/get-data parameters
           //This is optional
           'data' : {
                'type'  : 'SystemEventAction',
                'sysEventCode' : sysEventCode,
                'sysEventParams' :params   
           }
           
           });
 
}

