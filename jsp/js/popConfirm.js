//popup confirm for form submission
function confirmSubmit()
{
  var agree=confirm("Are you sure you wish to continue?");
  if (agree)
    return true ;
  else
    return false ;
}

function veriForm() {
        for(j=0; j < document.forms[0].key.length; j++){
            if(document.forms[0].key[j].checked){
                return true;
            }
        }
        if(document.forms[0].key.checked) 
            return true;

        alert("Please make a selection!");

        return false;
}

function confirmDelete(msg) {
}