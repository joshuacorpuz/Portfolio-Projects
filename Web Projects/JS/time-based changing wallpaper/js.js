var shinobutime = 23;
var noon = 12;
var senjougaharatime = 24;
var mayoitime = 8;
var kanbarutime = 14;
var hanekawatime = 10;
var nadekotime = 12;
var karentime = 17;
var tsukihitime = 18;
var yotsugitime = 13;
var sodachitime = 15;
var ougitime = 1;
var fighttime;
var evening = 18;

// Getting it to show the current time on the page
var showCurrentTime = function()
{
    // display the string on the webpage
    var clock = document.getElementById('clock');
 
    var currentTime = new Date();
 
    var hours = currentTime.getHours();
    var minutes = currentTime.getMinutes();
    var seconds = currentTime.getSeconds();
    var meridian = "AM";
 
    // Set hours
	  if (hours >= noon)
	  {
		  meridian = "PM";
	  }

	  if (hours > noon)
	  {
		  hours = hours - 12;
	  }
 
    // Set Minutes
    if (minutes < 10)
    {
        minutes = "0" + minutes;
    }
 
    // Set Seconds
    if (seconds < 10)
    {
        seconds = "0" + seconds;
    }
 
    // put together the string that displays the time
    var clockTime = hours + ':' + minutes + ':' + seconds + " " + meridian + "!";
 
    clock.innerText = clockTime;
};

// Getting the clock to increment on its own and change out messages and pictures
var updateClock = function() 
{
  var time = new Date().getHours();
  var messageText;
  var image = "./assets/normal time.jpg";

  var timeEventJS = document.getElementById("timeEvent");
  var normalImageJS = document.getElementById('normalImage');
  
  if (time == fighttime)
  {
    image = "./assets/fight time.jpg";
    messageText = "Apparition Fighting Time!";
  }
  else if (time == shinobutime)
  {
    image = "./assets/shinobu time.jpg";
    messageText = "bring golden chocolate next time!";
  }
  else if (time == senjougaharatime)
  {
    image = "./assets/senjougahara time.jpg";
    messageText = "This is everything I have.";
  }
  else if (time == mayoitime)
  {
    image = "./assets/mayoi time.jpg";
    messageText = "hachikuji!!!!!!!";
  }
  else if (time == kanbarutime)
  {
    image = "./assets/kanbaru time.gif";
    messageText = "learn how to clean it yourself!";
  }
  else if (time == hanekawatime)
  {
    image = "./assets/hanekawa time.png";
    messageText = "I don't know everything. I only know what I know.";
  }
  else if (time == nadekotime)
  {
    image = "./assets/nadeko time.png";
    messageText = "Do you still remember me?";
  }
  else if (time == karentime)
  {
    image = "./assets/karen time.png";
    messageText = "get wrecked!";
  }
  else if (time == tsukihitime)
  {
    image = "./assets/tsukihi time.jpg";
    messageText = "I'm platinum mad!";
  }
  else if (time == yotsugitime)
  {
    image = "./assets/yotsugi time.jpg";
    messageText = "Yay! Peace! Peace!";
  }
  else if (time == sodachitime)
  {
    image = "./assets/sodachi time.jpg";
    messageText = "I hate you!";
  }
  else if (time == ougitime)
  {
    image = "./assets/ougi time.webp";
    messageText = "I only know what you know.";
  }
  else
  {
    image = "./assets/free time.png";
    messageText = "Free Time!";
  }

  console.log(time); 
  timeEventJS.innerText = messageText;
  normalImage.src = image;
  
  showCurrentTime();
};
updateClock();

// Getting the clock to increment once a second
var oneSecond = 1000;
setInterval( updateClock, oneSecond);


// Getting the fight Time Button To Work
var fightButton = document.getElementById("fightTimeButton");

var fightEvent = function()
{
    if (fighttime < 0) 
    {
        fighttime = new Date().getHours();
        fightTimeButton.innerText = "Fight Over!";
        fightTimeButton.style.backgroundColor = "#0A8DAB";
    }
    else
    {
        fighttime = -1;
        fightTimeButton.innerText = "Fight Time!";
        fightTimeButton.style.backgroundColor = "#222";
    }
};

fightButton.addEventListener("click", fightEvent);
fightEvent(); 


// Shinobu Time Selector
var shinobuTimeSelector =  document.getElementById("shinobuTimeSelector");

var shinobuEvent = function()
{
    shinobutime = shinobuTimeSelector.value;
};

shinobuTimeSelector.addEventListener("change", shinobuEvent);


// Senjougahara Time Selector
var senjougaharaTimeSelector =  document.getElementById("senjougaharaTimeSelector");

var senjougaharaEvent = function()
{
    senjougaharatime = senjougaharaTimeSelector.value;
};

senjougaharaTimeSelector.addEventListener("change", senjougaharaEvent);


// Mayoi Time Selector
var mayoiTimeSelector =  document.getElementById("mayoiTimeSelector");

var mayoiEvent = function()
{
    mayoitime = mayoiTimeSelector.value;
};

mayoiTimeSelector.addEventListener("change", mayoiEvent);


// Kanbaru Time selector
var kanbaruTimeSelector =  document.getElementById("kanbaruTimeSelector");

var kanbaruEvent = function()
{
    kanbarutime = kanbaruTimeSelector.value;
};

kanbaruTimeSelector.addEventListener("change", kanbaruEvent);


// Hanekawa Time Selector
var hanekawaTimeSelector =  document.getElementById("hanekawaTimeSelector");

var hanekawaEvent = function()
{
    hanekawatime = hanekawaTimeSelector.value;
};

hanekawaTimeSelector.addEventListener("change", hanekawaEvent);


// Nadeko Time selector
var nadekoTimeSelector =  document.getElementById("nadekoTimeSelector");

var nadekoEvent = function()
{
    nadekotime = nadekoTimeSelector.value;
};

nadekoTimeSelector.addEventListener("change", nadekoEvent);


// Karen Time selector
var karenTimeSelector =  document.getElementById("karenTimeSelector");

var karenEvent = function()
{
    karentime = karenTimeSelector.value;
};

karenTimeSelector.addEventListener("change", karenEvent);


// Tsukihi Time selector
var tsukihiTimeSelector =  document.getElementById("tsukihiTimeSelector");

var tsukihiEvent = function()
{
    tsukihitime = tsukihiTimeSelector.value;
};

tsukihiTimeSelector.addEventListener("change", tsukihiEvent);


// Yotsugi Time selector
var yotsugiTimeSelector =  document.getElementById("yotsugiTimeSelector");

var yotsugiEvent = function()
{
    yotsugitime = yotsugiTimeSelector.value;
};

yotsugiTimeSelector.addEventListener("change", yotsugiEvent);


// Sodachi Time selector
var sodachiTimeSelector =  document.getElementById("sodachiTimeSelector");

var sodachiEvent = function()
{
    sodachitime = sodachiTimeSelector.value;
};

sodachiTimeSelector.addEventListener("change", sodachiEvent);


// Ougi Time selector
var ougiTimeSelector =  document.getElementById("ougiTimeSelector");

var ougiEvent = function()
{
    ougitime = ougiTimeSelector.value;
};

ougiTimeSelector.addEventListener("change", ougiEvent);