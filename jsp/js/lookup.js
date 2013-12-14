<!--Begin

//if (document.layers)
//  document.captureEvents(Event, KEYPRESS);

//document.onkeypress =
//  function (evt) {
//    var c = document.layers ? evt.which
//            : document.all ? event.keyCode
//            : evt.keyCode;
//    alert('Pressed: '+String.fromCharCode(c)+c);
//    return true;
//  };

//Initialize the source list
function initSourceList(OrgList) {
  srcList = window.document.forms[0].srcList; 
  // should be sorted by database select
  // so that infoList is syncnized-sorted also
  // OrgList.sort(); 
  var len = OrgList.length;
  for (var i=0; i< len; i++) {
    srcList.options[i] = new Option(OrgList[i]);
  }  
  firstAdd = true;
}

//Initialize the content list
function initContentList(OrgList) {
  contentList = window.document.forms[0].contentList; 

  var len = OrgList.length;
  for (var i=0; i< len; i++) {
    contentList.options[i] = new Option(OrgList[i]);
  }  
  firstAdd = true;
}

// Add the selected items in the parent by calling method of parent
function addSelectedItemsToParent(replace) {
  self.opener.addToParentTextM(window.document.forms[0].destList, replace);
  window.close();
}

function addCheckedItemsToParent() {
  len = document.forms[0].elements.length;
  var num_checked = 0, i=0;
  for (i=0; i<len; i++) {
    if (document.listForm.elements[i].name == 'item' && document.listForm.elements[i].checked) {
       if (num_checked > 0)
          itemStr += ", " + document.listForm.elements[i].value;
       else
          itemStr = document.listForm.elements[i].value;
       num_checked++;
    }
  }
  if (itemStr != null && itemStr.length > 0) {
     self.opener.addToParentText1(itemStr);
  }
  window.close();
}

function addCheckedItemToParent(thischkbox) {
  if (thischkbox.checked) {
     self.opener.addToParentText1(thischkbox.value);
  }
}

function addSelectedToParent() {
  idx = window.document.forms[0].srcList.selectedIndex;
  selectedStr = window.document.forms[0].srcList.options[idx].text;
  if (selectedStr != null && selectedStr.length > 0)
     self.opener.addToParentText1(selectedStr);
  window.close();
}

function addSelectedToParentCrossed() {
  idx = window.document.forms[0].srcList.selectedIndex;
  selectedStr = window.document.forms[0].contentList.options[idx].text;
  if (selectedStr != null && selectedStr.length > 0)
     self.opener.addToParentText1(selectedStr);
  window.close();
}

// Add the selected items from the source to destination list
function addSrcToDestList() {
  destList = window.document.forms[0].destList;
  srcList = window.document.forms[0].srcList; 
  if (firstAdd) {
     if (destList.length > 0)
       destList.options[destList.length-1] = null;
     firstAdd = false;
  }
  var len = destList.length;

  var srcLen = srcList.length;
  for(var i = 0; i < srcLen; i++) {
    if ((srcList.options[i] != null) && (srcList.options[i].selected)) {
    //Check if this value already exist in the destList or not
    //if not then add it otherwise do not add it.
      var found = false;
      for(var count = 0; count < len; count++) {
        if (destList.options[count] != null) {
          if (srcList.options[i].text == destList.options[count].text) {
            found = true;
            break;
          }
        }
      }
      if (found != true) {
        destList.options[len] = new Option(srcList.options[i].text); 
        srcList.options[i] = null;
        len++;
      }
    }
  }
}
// Deletes from the destination list.
function deleteFromDestList() {
  var destList  = window.document.forms[0].destList;
  var tmpList = new Array();
  var srcLen = srcList.options.length;
  for (var i = 0; i < srcLen; i++) {
    tmpList[i] = srcList.options[i].text;
  }
  var len = destList.options.length;
  for(var i = (len-1); i >= 0; i--) {
    if ((destList.options[i] != null) && (destList.options[i].selected == true)) {
       //srcLen = srcList.options.length;
       tmpList[srcLen] = destList.options[i].text;
       destList.options[i] = null;
       srcLen++;
    }
  }
  tmpList.sort();
  for (var i = 0; i < tmpList.length; i++) {
    srcList.options[i] = new Option(tmpList[i]);
  }
}
function jumpToSelectM() {
  textBox = window.document.forms[0].textbox;
  srcList = window.document.forms[0].srcList;
  var subStr = window.document.forms[0].textbox.value;
  var len = srcList.options.length;
  trueIdx = new Array();
  var lenTrue = 0;
  for (var i = 0; i<len; i++) {
    if (srcList.options[i].selected == true) {
       trueIdx[lenTrue] = i;
       lenTrue++;
    }   
    srcList.options[i].selected = false;
  }
  re = new RegExp("^"+subStr, "i");
  var i = 0;
  var found = false;
  while ( !found && i < len ) {
    if (srcList.options[i].text.search(re) != -1) {
       found = true;
       srcList.options[i].selected = true;
    }
    i++;
  }
  if (!found) {
     for (var i = 0; i < lenTrue; i++) {
       srcList.options[trueIdx[i]].selected = true;
     }
  } 
}
function jumpToSelect1() {
  textBox = window.document.forms[0].textbox;
  srcList = window.document.forms[0].srcList;
  infoArea = window.document.forms[0].info;
  var subStr = window.document.forms[0].textbox.value;
  var len = srcList.options.length;
  trueIdx = new Array();
  var lenTrue = 0;
  for (var i = 0; i<len; i++) {
    if (srcList.options[i].selected == true) {
       trueIdx[lenTrue] = i;
       lenTrue++;
    }   
    srcList.options[i].selected = false;
  }
  re = new RegExp("^"+subStr, "i");
  var i = 0;
  var found = false;
  while ( !found && i < len ) {
    if (srcList.options[i].text.search(re) != -1) {
       found = true;
       srcList.options[i].selected = true;
       infoArea.value = infoList[i];
    }
    i++;
  }
  if (!found) {
     for (var i = 0; i < lenTrue; i++) {
       srcList.options[trueIdx[i]].selected = true;
       infoArea.value = infoList[trueIdx[i]];
     }
  } 
}

function display() {
  var selectedItem = document.forms[0].srcList.selectedIndex;
  var selectedText = document.forms[0].srcList.options[selectedItem].text;
  var selectedValue = document.forms[0].srcList.options[selectedItem].value;
  document.forms[0].textbox.value = selectedText;
  document.forms[0].info.value = infoList[selectedItem];
}

function display2() {
  var selectedItem = document.forms[0].srcList.selectedIndex;
  document.forms[0].contentList.options[selectedItem].selected = true;

  var selectedText = document.forms[0].contentList.options[selectedItem].text;
  document.forms[0].textbox.value = selectedText;
}
// End -->