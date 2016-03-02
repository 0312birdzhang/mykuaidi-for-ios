Qt.include("allposts.js");
var themeColor;
var signalcenter;
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
    console.log("url:"+url)
    sendWebRequest(url,loadPostname,"GET","");
}

function loadPostname(oritxt){
    var obj=JSON.parse(oritxt);
    autopostModel.clear();
    for(var i in obj){
        autopostModel.append({
                          "value":obj[i].comCode,
                          "label":getLabel(obj[i].comCode)
                        });
    }
    if(autopostModel.length>0){

    }
    console.log("autopostModel:"+autopostModel)
}


var showlistModel;
//查询快递
function getPostdetail(type,postid){
    var url="http://m.kuaidi100.com/query?type="+type+"&postid="+postid+"&id=1&valicode=&temp="+getRandom();
    console.log("detail url :"+url)
    sendWebRequest(url,loadPostdetail,"GET","");
}


function loadPostdetail(oritxt){
    var obj=JSON.parse(oritxt);
    showlistModel.clear();
    if(obj.status == 200){

        for ( var i in obj.data   ){
            showlistModel.append({
                         "sort":i,
                         "time" : obj.data[i].time,
                         "maintext" : obj.data[i].context
                     });
        }
    }else{
        showlistModel.append({
                         "sort":"",
                         "time":"Error: " +obj.status,
                         "maintext":obj.message+"\n请检查快递公司和单号是否正确！\n如果都正确，可能存在快递延误,请保存订单稍后再试^_^"
                  });
    }

}
