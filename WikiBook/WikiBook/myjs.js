var clicked=function(event){
    alert(event.target.innerText);
    event.target.style.backgroundColor="red";
};
var init=function(){
    alert("came here");
    var paras=document.getElementsByTagName("p");
    for(var i=0;i<paras.length;i++){
        paras[i].onclick=clicked;
    }
};
var getData=function(){
    var arr =new Array();
    var paras=document.getElementsByTagName("p");
    for(var i=0;i<paras.length;i++){
        if(paras[i].style.backgroundColor=="red")
        arr.push(paras[i].innerText);
    }
    return arr.join(":::");
};
