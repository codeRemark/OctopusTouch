var   VkInterrupter = {
    type: "macintosh",
    process : function(key) {
      switch (key){
          case "Music":
              KeyListener.music();
              break;
          case "Video":
              KeyListener.video();
              break;
          case "FaceTime":
              KeyListener.facetime();
              break;
          case "Wake":
              KeyListener.wake();
              break;
          case "Sleep":
              KeyListener.sleep();
              break;
          case "On":
              KeyListener.screenOn();
              break;
          case "Off":
              KeyListener.screenOff();
              break;
          case "Down":
               KeyListener.onDown();	
              break;
          case "Up":
              KeyListener.onUp();
              break;
          case "Left":
              KeyListener.onLeft();
              break;
          case "Right":
              KeyListener.onRight();
              break;
          default:
              KeyListener.onKeyPress(key);

                   
   		 } 
    
    }
}
 

