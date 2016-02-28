
Qt.include("allposts.js");

var themeColor;

// 首先创建一个helper方法连接数据库
function getDatabase() {
    return openDatabaseSync("mykuaidi", "1.0", "postinfo", 10000);

}


// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // 如果表存在，则跳过此步
                    tx.executeSql('CREATE TABLE IF NOT EXISTS meekuaidi(id integer primary key AutoIncrement,postnum TEXT,kuaidi_en TEXT,description TEXT,savetime TEXT);');

                });
    if(checkColumnExists("savetime") == "false"){
        updateTable();
    }
}


var saveResult;
// 插入数据
function setKuaidi(postnum, kuaidi_en,description) {
    var db = getDatabase();
    try{
        db.transaction(function(tx) {

            var rs = tx.executeSql('INSERT OR REPLACE INTO meekuaidi(postnum,kuaidi_en,description,savetime) VALUES (?,?,?,?);', [postnum,kuaidi_en,description,getCurrentTime()]);
            if (rs.rowsAffected > 0) {
                saveResult = "OK";
            } else {
                saveResult = "Error";
            }
        });}
    catch(e){
        db.transaction(
                    function(tx) {
                        tx.executeSql('ALTER TABLE meekuaidi ADD column savetime TEXT;');

                    });
        saveResult = "Error";
    }
    return saveResult;

}

// 清除数据
function clearKuaidi(id) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from meekuaidi where id =?;',[id]);
        //console.log("ID::::::"+id);
        //console.log(rs.rowsAffected);
        if (rs.rowsAffected > 0) {

            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

//根据kuaidi_en删除
function clearByname(kuaidi_en) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from  meekuaidi where kuaidi_en =?;',[kuaidi_en]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}



//根据id更新
function updateKuaidi(id,postnum,description) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('update meekuaidi set postnum = ? ,description=? where id =?;',[postnum,description,id]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

// 获取查询列表
function getKuaidi(all,fillmodel) {

    var sql='SELECT * FROM meekuaidi order by id desc;';
    if(all === "five"){
        sql = 'SELECT * FROM meekuaidi order by id desc limit 5;';

    }

    var db = getDatabase();
    var res="";
    fillmodel.clear()
    try{
        db.transaction(function(tx) {
            var rs = tx.executeSql(sql);
            if (rs.rows.length > 0) {
                for(var i = 0; i < rs.rows.length; i++){
                    //console.log(JSON.stringify(rs.rows.item(i)))
                    fillmodel.append({
                                         "id":rs.rows.item(i).id,
                                         "postnum":rs.rows.item(i).postnum,
                                         "kuaidi_en":rs.rows.item(i).kuaidi_en,
                                         "kuaidi_cn":dictnames(rs.rows.item(i).kuaidi_en),
                                         "description":rs.rows.item(i).description,
                                         "savetime":rs.rows.item(i).savetime,
                                         "cardcolor":Math.floor(Math.random()*6)
                                     })
                }
            }
        })}
    catch(e){
        //console.log("error...reget")

    }
}

var description;
// 获取单条查询记录
function getKuaidiInfo(id) {
    progress.visible=true;
    var db = getDatabase();
    var kuaidi_en="";
    var postnum="";


    var res="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM meekuaidi where id =?;',[id]);
        if (rs.rows.length > 0) {
            postnum = rs.rows.item(0).postnum;
            kuaidi_en = rs.rows.item(0).kuaidi_en;

            description = rs.rows.item(0).description;
            load(kuaidi_en,postnum);

        } else {
            description =  "无";
            res = "查询出错了，(⊙o⊙)…";

        }
    });

    return description;
}


// 判断是否已经存在
function isExist(postnum) {
    var exist;
    //console.log("postnum:"+postnum);
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql("SELECT count(1) as count FROM meekuaidi where postnum = ?",[postnum.toString()]);
        //console.log("COUNT:"+rs.rows.item(0).count);
        if (rs.rows.item(0).count > 0) {
            exist = "true";
        } else {
            exist = "false";
        }

    });
    return exist;

}







function load(type,postnum) {

    var xhr = new XMLHttpRequest();
    var url="http://m.kuaidi100.com/query?type="+type+"&postnum="+postnum+"&id=1&valicode=&temp="+getRandom();
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');

                loaded(jsonObject);


            }
        }
    }
    xhr.send();
}



function loaded(jsonObject){
    var alltext="<br>";
    var tmptext="<br>"
    if(jsonObject.status != "200" ){
        alltext = jsonObject.message;

    }
    else{
        for ( var process in jsonObject.data   ){
            //最近物流根据主题高亮
            if( process == 0 ){

                tmptext = jsonObject.data[process].time+"<br>"+jsonObject.data[process].context;
            }else{

                alltext += jsonObject.data[process].time+"<br>"+jsonObject.data[process].context+"<br><br>";
            }
        }

    }
    progress.visible = false;
    postinfo = alltext;
    highlightedpostinfo = tmptext;
    //return alltext;
}

//快递字典


function dictnames(kuaidi_en){

    try{
        for ( var i in allpost   ){
            if(kuaidi_en == allpost[i].value){
                return allpost[i].label
            }
        }
    }
    catch(e){
        return "error"
    }

}

// 修改表结构
function updateTable() {
    var db = getDatabase();
    db.transaction(function(tx) {
        var rs = tx.executeSql('ALTER TABLE meekuaidi ADD column savetime TEXT;');
    });
    db.transaction(function(tx) {
        var rs = tx.executeSql('update meekuaidi set savetime = " ";');
    });

}

function checkColumnExists(columnName){
    var flag = "true";
    var sql = 'select * from sqlite_master where kuaidi_en = "kuaidi" and sql like "%'+columnName+'%";';
    //console.log("SQL:"+sql)
    try{
        var db = getDatabase();
        db.transaction(function(tx){
          var rs =  tx.executeSql(sql);
            if(rs.rows.length > 0) {
               flag = "true";
            }else {
               flag = "false";
            }
        });
    }catch(e){
        console.log("exception:"+e.message)
    }
    return flag;
}

