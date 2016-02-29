Qt.include("allposts.js");
var themeColor;

function sendWebRequest(url, callback, method, postdata) {
    var xmlhttp = new XMLHttpRequest();
    //console.log(url)
    xmlhttp.onreadystatechange = function() {
                switch(xmlhttp.readyState) {
                case xmlhttp.OPENED:break;
                case xmlhttp.HEADERS_RECEIVED:
                  if (xmlhttp.status != 200){
                    }
                  break;
                case xmlhttp.DONE:if (xmlhttp.status == 200) {
                        try {
                            //console.log("Server Msg:"+xmlhttp.responseXML);
                            callback(xmlhttp.responseText);
                            //signalcenter.loadFinished();
                        } catch(e) {
                            //signalcenter.loadFailed(qsTr("loading erro..."));
                        }
                    } else {
                        //signalcenter.loadFailed("");
                    }
                    break;
                }
            }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}

var autopostModel=[];
function getPostname(postnum,callbackfun){
    var url="http://m.kuaidi100.com/autonumber/auto?num="+postnum;
    sendWebRequest(url,callbackfun,"GET","");
}

function loadPostname(oritxt){
    var obj=JSON.parse(oritxt);
    autopostModel.clear();
    for(var i in obj){
        autopostModel.concat([obj[i].comCode,getLabel(obj[i].comCode)])
    }
    if(autopostModel.length>0){

    }
}


//查询快递
function load(type,postid) {
    progress.visible = true;
    listModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://m.kuaidi100.com/query?type="+type+"&postid="+postid+"&id=1&valicode=&temp="+getRandom();
    console.log(url)
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function(){
        if ( xhr.readyState == xhr.DONE){
            if ( xhr.status == 200){
                //console.log(xhr.responseText)
                var jsonObject = eval('(' + xhr.responseText + ')');
                loaded(jsonObject)

            }else{
                listModel.append({
                                 "sort":"",
                                 "time":"Error: " +xhr.status,
                                 "maintext":"网络问题，请检查手机网络后再试^_^"
                          });
                progress.visible = false;
            }
        }
    }
    xhr.send();
}



function loaded(jsonObject){
    savebutton.enabled = true;
    if(jsonObject.status == 200){
        for ( var process in jsonObject.data   ){
            listModel.append({
                         "sort":process,
                         "time" : jsonObject.data[process].time,
                         "maintext" : jsonObject.data[process].context
                     });
        }
    }else{
        listModel.append({
                         "sort":"",
                         "time":"Error: " +jsonObject.status,
                         "maintext":jsonObject.message+"\n请检查快递公司和单号是否正确！\n如果都正确，可能存在快递延误,请保存订单稍后再试^_^"
                  });
    }
    progress.visible = false;
}
