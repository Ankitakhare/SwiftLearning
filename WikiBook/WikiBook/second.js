var index=1;
var iAmClicked=function(event){
    if(confirm("add this content in your notebook.")){
        event.target.style.backgroundColor="yellow";
        event.target.style.border = "1px solid red";
        event.target.dataIndex=index++;
        event.target.dataMarked=true;
    }
    event.stopPropagation();
};

var init=function(){
    var a=document.getElementsByTagName("a");
    for(i=0;i<a.length;i++){
        a[i].href="#";
    }
    var x=document.getElementsByTagName("p");
    for(i=0;i<x.length;i++){
        x[i].onclick=iAmClicked;
    }
    var imgTagElement=document.getElementsByTagName("img");
    var imgTagLength=document.getElementsByTagName("img").length;
    for (var j=0;j<imgTagLength;j++) {
        imgTagElement[j].onclick=iAmClicked;
    }
};
var getKeys=function(obj){
    var keys = [];
    for (var key in obj) {
        keys.push(key);
    }
    return keys;
};
var getData=function(){
    var all = {};
    var x=document.getElementsByTagName("p");
    for(i=0;i<x.length;i++){
        if(x[i].style.backgroundColor=="yellow"){
            all[x[i].dataIndex]=x[i].innerText;
        }
    }
    var img=document.getElementsByTagName("img");
    for(j=0;j<img.length;j++){
        if(img[j].dataMarked){
            all[img[j].dataIndex]= ((img[j].dataIndex==1)?"":":::")+"[Image]"+img[j].src+":::";
        }
    }
    var strAll="";
    var keys=getKeys(all);
    for(var i=0;i<keys.length;i++){
        strAll+=all[keys[i]]+"\n";
    }
    return strAll;
};