function GetCookie(sName)
{
    var aCookie = document.cookie.split("; ");
    for (var i=0; i < aCookie.length; i++)
    {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0])
        {
            return aCrumb[1];
        }
    }
    return null;
}

function SetCookie(name, value, time, domain)
{
    var expdate = new Date();
    var expires = time;
    if(expires!=null){
      expdate.setTime(expdate.getTime() + ( expires * 1000 ));
      expd = "expires="+expdate.toGMTString()+";";
    }else
      expd = "";
    if (domain)
    {
        domain = "domain="+ domain +"; path=/; ";
    }
    document.cookie = name + "=" + escape (value) + "; " + expd + domain;
}
var cookieTag = "nd_skin";
var vSkin = GetCookie(cookieTag);

//皮肤撤销初始化皮肤
if(vSkin=="yx_subject0708" || vSkin==null){setSkinColor('ISCSSobjects_style5');}
//alert(vSkin);

function setSkinColor(vSkinNum)
{
    SetCookie(cookieTag, vSkinNum, 60*60*24*30,"");
    if(vSkinNum=="yx_subject0708"){vSkinNum="blue";}
    document.getElementById("skinCss").href = "jsp/public/"+vSkinNum+".css";
}

if( vSkin && vSkin!="Style" )
{
    document.getElementById("skinCss").href = "jsp/public/"+vSkin+".css";
}