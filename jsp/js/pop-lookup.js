<!-- Begin
var targetText;

function openLookup(myurl,targetText) {
var newWindow;
var props = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=560,height=460';
newWindow = window.open(myurl, "Add_from_Src_to_Dest", props);
newWindow.focus();
this.targetText = targetText;
}

//ensure input in input box
function validateInput(targetText) {
  if((targetText == null ) || (targetText == "")){
    //error msg
    alert("Please specify an ID in input!");
    return false;	
  }
  return true;
}

// more detailed list popup window
function openLookupLarge(myurl,targetText) {
var newWindow;
var props = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=500,height=650';
newWindow = window.open(myurl, "Add_from_Src_to_Dest", props);
newWindow.focus();
this.targetText = targetText;
}
// Adds the list of selected items selected in the child
// window to its list. It is called by child window to do so.
function addToParentTextM(sourceList, replace) {
//destinationText = window.document.form0.code;
destinationText = eval("window.document."+this.targetText);
if (replace) destinationText.value = "";
// trim leading spaces
while (destinationText.value.length>0 && destinationText.value.charAt(0)=='') {
  destinationText.value = 
    destinationText.value.substring(1,destinationText.value.length);
}
for(var i = 0; i < sourceList.options.length; i++) {
  if (sourceList.options[i] != null)
    if (destinationText.value.length > 0) 
       destinationText.value += "-";
    destinationText.value += sourceList.options[i].text;
  }
}

function addToParentText1(selectedStr) {
//destinationText = window.document.form0.code;
destinationText = eval("window.document."+this.targetText);
destinationText.value = selectedStr;
}

function fillRateCodeToParent(selectedStr) {
//destinationText = window.document.form0.code;
destinationText = eval("window.document."+this.targetText);
destinationText.value = selectedStr;
destinationText.blur();
}

//  End -->