function calendar(elementId)
{
      var returnValue = window.showModalDialog('../common/calendar.htm',"","dialogHeight:250px;dialogWidth:190px;status:no;scroll:no");
	  var date = document.getElementById(elementId);
	  if(returnValue != "")
		  date.value = returnValue;	 
}
function calendarMonth(elementId)
{
      var returnValue = window.showModalDialog('../common/calendar.htm',"","dialogHeight:250px;dialogWidth:190px;status:no;scroll:no");
	  var date = document.getElementById(elementId);
	  if(returnValue != "")
        {
            var dateArray = returnValue.split("-");
            date.value = dateArray[0]+"-"+dateArray[1];
         }
}
function setDefaultDate()
{
	  var date = document.getElementById('date');
	  var currentDate = new Date();
	  var month = currentDate.getMonth()+1;
	  var dateNow = currentDate.getDate();
	  if(month < 10)
		  month = '0'+month;
	  if(dateNow <10)
		  dateNow = '0'+dateNow;
	  date.value = currentDate.getYear()+'-'+month+'-'+dateNow;
}
function calendar1(elementId)
{
      var returnValue = window.showModalDialog('../common/calendar.htm',"","dialogHeight:250px;dialogWidth:190px;status:no;scroll:no");
	  var date1 = document.getElementById(elementId);
	  if(returnValue != "")
		  date1.value = returnValue;	 
}
function calendar2(elementId)
{
      var returnValue = window.showModalDialog('../common/calendar.htm',"","dialogHeight:250px;dialogWidth:190px;status:no;scroll:no");
	  var date2 = document.getElementById(elementId);
	  if(returnValue != "")
		  date2.value = returnValue;	 
}
function calendar3(elementId)
{
      var returnValue = window.showModalDialog('../common/calendar.htm',"","dialogHeight:250px;dialogWidth:190px;status:no;scroll:no");
	  var date3 = document.getElementById(elementId);
	  if(returnValue != "")
		  date3.value = returnValue;	 
}
function isDate(oDateTime)
{
    //对日期格式进行验证 要求为2000-2099年  格式为 yyyy-mm-dd[ hh:mi:ss]  并且可以正常转换成正确的日期
    var pat_hd=/^(20\d{2}-((0[1-9]{1})|(1[0-2]{1}))-((0[1-9]{1})|([1-2]{1}[0-9]{1})|(3[0-1]{1}))){1}(\s\d{2}:\d{2}:\d{2})?$/;
 try{
   if(!pat_hd.test(oDateTime)) throw "日期非法！";
   var arr_dt=oDateTime.split(" ");
   if(arr_dt[0]=='') throw "日期非法！";
   var oDate=arr_dt[0];
   var arr_hd=oDate.split("-");
   var dateTmp;
   dateTmp= new Date(arr_hd[0],parseFloat(arr_hd[1])-1,parseFloat(arr_hd[2]));
   if(dateTmp.getFullYear()!=parseFloat(arr_hd[0]) || dateTmp.getMonth()!=parseFloat(arr_hd[1]) -1 || dateTmp.getDate()!=parseFloat(arr_hd[2])) throw "日期非法！";
            if(arr_dt[1] && arr_dt[1]!='')
            {
               var oTime=arr_dt[1];
               var arr_ht=oTime.split(":");
               dateTmp.setHours(arr_ht[0],arr_ht[1],arr_ht[2]);
      if(dateTmp.getHours()!=parseFloat(arr_ht[0]) || dateTmp.getMinutes()!=parseFloat(arr_ht[1]) || dateTmp.getSeconds()!=parseFloat(arr_ht[2])) throw "日期非法！";
            }
  }
 catch(ex)
  {
   if(ex.description)
   {return false;}
   else
    {return false;}
  }
 return true;
}
function getNowDate()
{
  var currentDate = new Date();
	  var month = currentDate.getMonth()+1;
	  var dateNow = currentDate.getDate();
	  if(month < 10)
		  month = '0'+month;
	  if(dateNow <10)
		  dateNow = '0'+dateNow;
	 return currentDate.getYear()+'-'+month+'-'+dateNow;

}
function tick()   
{   
var hours,minutes,seconds,ap;   
var intHours,intMinutes,intSeconds;   
var today;   
today=new Date();    
intHours=today.getHours();   
intMinutes=today.getMinutes();   
intSeconds=today.getSeconds();   
//获取系统时间的小时数   
if(intHours==0)   
{   
hours=intHours+":";   
ap="凌晨";   
}   
else if(intHours<12)   
{   
hours=intHours+":";   
ap="早晨";   
}   
else if(intHours==12)   
{   
hours=intHours+":";   
ap="中午";   
}   
else  
{   
intHours=intHours-12;   
hours=intHours+":";   
ap="下午";   
}   
//获取系统时间的分数   
if(intMinutes<10)   
{   
minutes="0"+intMinutes+":";   
}   
else  
{   
minutes=intMinutes+":";   
}   
//获取系统时间的秒数   
if(intSeconds<10)   
{   
seconds="0"+intSeconds+" ";   
}   
else  
{   
seconds=intSeconds+" ";   
}   
timeString=ap+hours+minutes+seconds;   
document.getElementById("Clock").innerHTML=timeString;   
//每隔0.1秒钟执行一次tick函数   
window.setTimeout("tick()",100);   
}  
function ChangeDate(obj)
{
	//将YYYYMMDD型日期转换为yyyy-mm-dd型日期
	if(obj.value.length==8)
	{
		var temp=obj.value.substr(0,4)+"-"+obj.value.substr(4,2)+"-"+obj.value.substr(6,2);
		obj.value=temp;
		if(CheckData(obj,"日期非法或"))
			obj.value=temp;
	}else
	{
		if(obj.value.length==10)
		{
			if(CheckData(obj,"日期非法或"))
			   obj.value=obj.value;
		}else  if (obj.value==""||obj.value.indexOf(" ") != -1||obj.value.indexOf("　")!=-1)
        {
		  obj.value="";
          return;
        }else
		{
			alert("输入的日期格式错误！（YYYYMMDD或yyyy-mm-dd）");
			obj.value="";
		}
	}
}