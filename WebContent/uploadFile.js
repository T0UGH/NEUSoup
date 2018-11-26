var nextImg=0
function setImg(obj){//用于进行图片上传，返回地址
//	alert(nextImg)
    var f=$(obj).val();
    if(nextImg==4){
        return false;
    }
    if(f == null || f ==undefined || f == ''){
        return false;
    }
    if(!/\.(?:png|jpg|bmp|gif|PNG|JPG|BMP|GIF)$/.test(f))
    {
        $(obj).val('');
        return false;
    }
    var data = new FormData();
    $.each($(obj)[0].files,function(i,file){
        data.append('file', file);
    });
    $.ajax({
        type: "POST",
        url: "/Soup/UploadServlet",//提交的地址
        data: data,
        cache: false,//禁用缓存
        contentType: false,    //不可缺//不懂
        processData: false,    //不可缺//禁止自动转换
        dataType:"json",
        success: function(suc) {
            if(suc.code==0){
                    $("#img_url").attr("value",$("#img_url").attr("value")+suc.message+",")  
                    $("#thumburlShow"+nextImg).attr("src",suc.message);//显示图片
                    nextImg+=1
                }else{
                alert("上传失败");
                $("#url").val("");
                $(obj).val('');
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            alert("上传失败，请检查网络后重试");
            $("#url").val("");
            $(obj).val('');
        }
    });
}
function checkSubmit(){
	document.getElementById("time").setAttribute("value",""+new Date().getTime())
    return true
}