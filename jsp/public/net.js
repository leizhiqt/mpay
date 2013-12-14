/* namespacing object */
var net=new Object();

net.READY_STATE_UNINITIALIZED=0;
net.READY_STATE_LOADING=1;
net.READY_STATE_LOADED=2;
net.READY_STATE_INTERACTIVE=3;
net.READY_STATE_COMPLETE=4;
/*--- content loader object for cross-browser requests ---*/
net.ContentLoader=function(url,on_load,on_error,method,params,contentType){
    this.req=null;
    this.on_load=on_load;
    this.on_error=(on_error) ? on_error : this.defaultError;
    this.loadXMLDoc(url,method,params,contentType);
}
net.ContentLoader.prototype.loadXMLDoc=function(url,method,params,contentType){
    if (!method)
    {
method="GET";
    }
    if (!contentType && method=="POST")
    {
contentType='application/x-www-form-urlencoded';
    }
    if (window.XMLHttpRequest)
    {
this.req=new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    {
     //add try catch;
     try {
        this.req = new ActiveXObject("Msxml2.XMLHTTP");
     }catch (e1){
       try {
        this.req = new ActiveXObject("Microsoft.XMLHTTP");     
        } catch (e2){
      }
     }
       //
//this.req=new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (this.req)
    {
try
{
     var loader=this;
     this.req.onreadystatechange=function()
     {
    net.ContentLoader.onReadyState.call(loader);
     }
     this.req.open(method,url,true);
     if (contentType)
     {
      this.req.setRequestHeader('Content-Type', contentType);
     }
     this.req.send(params);
}
catch (err)
{
     this.on_error.call(this);
}
    }
}
net.ContentLoader.onReadyState=function(){
    var req=this.req;
    var ready=req.readyState;
    if (ready==net.READY_STATE_COMPLETE){
var httpStatus=req.status;
if (httpStatus==200 || httpStatus==0){
     this.on_load.call(this);
}else{
     this.on_error.call(this);
}
    }
}
net.ContentLoader.prototype.defaultError=function(){
    alert("error fetching data!"
+"\n\nreadyState:"+this.req.readyState
+"\nstatus: "+this.req.status
+"\nheaders: "+this.req.getAllResponseHeaders());
}