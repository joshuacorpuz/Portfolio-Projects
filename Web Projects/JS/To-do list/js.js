var click = document.getElementById("click");
var input = document.getElementById("userInput");
var ul = document.querySelector("ul");

function inputLength(){
	return input.value.length;
} 

function createTask() {
	var li = document.createElement("li"); // creates an element "li"
	li.appendChild(document.createTextNode(input.value)); //makes text from input field the li text
	ul.appendChild(li); //adds li to ul
	input.value = ""; //Reset text input field


	//START STRIKETHROUGH
	// because it's in the function, it only adds it for new items
	function finished() {
		li.classList.toggle("done");
	}

	li.addEventListener("click",finished);
	//END STRIKETHROUGH


	// START ADD DELETE BUTTON
	var delButton = document.createElement("button");
	delButton.appendChild(document.createTextNode("X"));
	li.appendChild(delButton);
	delButton.addEventListener("click", deleteTask);
	// END ADD DELETE BUTTON


	//ADD CLASS DELETE (DISPLAY: NONE)
	function deleteTask(){
		li.classList.add("delete")
	}
	//END ADD CLASS DELETE
}

function clickAddList(){
	if (inputLength() > 0) { //makes sure that an empty input field doesn't create a li
		createTask();
	}
}

function enterAddList(event) {
	if (inputLength() > 0 && event.which ===13) { //this now looks to see if you hit "enter"/"return"
		//the 13 is the enter key's keycode, this could also be display by event.keyCode === 13
		createTask();
	} 
}

click.addEventListener("click",clickAddList);

input.addEventListener("keypress", enterAddList);

