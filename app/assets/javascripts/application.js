// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


function change_href_btn_get_latest(obj,t_mile){
	href_attr = $("#btn_get_latest").attr("href");
	if(t_mile=="m_box")
	{
		str=href_attr.slice(href_attr.search(/get_latest/));
		$("#btn_get_latest").attr("href","/emails/"+encodeURIComponent($(obj).val())+"/"+str);
		$("#btn_show").attr("href","?e_type="+encodeURIComponent($(obj).val()) );		
	}else
	{
	  lgn=encodeURIComponent($("#mail_login").val());
	  pwd=encodeURIComponent($("#pwd").val());
	  $("#btn_get_latest").attr("href",href_attr+"?lgn="+lgn+";pwd="+btoa(pwd));
	}
}