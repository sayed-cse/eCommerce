$(function(){ 'use strict';
//Begin...
	$('a[target=_blank]').attr('rel', 'noopener noreferrer');
	$('figure img, img, image, picture, object, iframe, embed, video, figure').attr('src','data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==');
	setTimeout(function(){ $(":not(.baselogo, .bannerImg),figure img, img, image, picture, object, iframe, embed, figure, video").each(function(){ $(this).attr("src",$(this).attr("data-src")); }); },100);
	$(':not(.baselogo, .bannerImg),figure img, img, image, picture, object, iframe, embed, figure, video').attr('loading','lazy');
	$('.baselogo, .bannerImg, figure img, img, image, picture, object, iframe, embed, figure, video').attr('fetchpriority','high');
	$('.baselogo, .bannerImg').attr('loading','auto');
	var empty = true;$('input[type="text"]').each(function(){if(!$(this).val().trim()){empty = false;return false;}});
	//$('input, textarea').bind('copy paste cut',function(e){ e.preventDefault(); });
	function fallback(url){location.replace(url);}
//RatedStars
	if($('.rateE').data('value') == $('#avgRating').val()){$('.rateA, .rateB, .rateC, .rateD, .rateE').css('color','#903');}
	if($('.rateD').data('value') == $('#avgRating').val()){$('.rateA, .rateB, .rateC, .rateD').css('color','#903');}
	if($('.rateC').data('value') == $('#avgRating').val()){$('.rateA, .rateB, .rateC').css('color','#903');}
	if($('.rateB').data('value') == $('#avgRating').val()){$('.rateA, .rateB').css('color','#903');}
	if($('.rateA').data('value') == $('#avgRating').val()){$('.rateA').css('color','#903');}
//ScreenShot	
//Tags
//ZoomImage
if($('.zoom').length){
	$('.zoom').css('background-image','url("'+$('.imgkey').first().data('src')+'")');
	$('.zoom').append('<img alt="'+$('.imgkey').first().attr('alt')+'" src="'+$('.imgkey').first().data('src')+'" data-src="'+$('.imgkey').first().data('src')+'"/>');
	$('.imgkey').on('mouseover, mouseenter',function(){ 
		$('.zoom').empty();
		$('.zoom').css('background-image','url("'+$(this).data('src')+'")');
		$('.zoom').append('<img alt="'+$(this).attr('alt')+'" src="'+$(this).data('src')+'" data-src="'+$(this).data('src')+'"/>');
	});
	$('.zoom').on('mousemove touchmove', function(e){
		e.stopPropagation(); e.preventDefault();
		let zoomer,offsetX,offsetY,x,y,touchX,touchY;	
		zoomer = e.currentTarget;
		offsetX = $(this).offset().left;
		offsetY = $(this).offset().top;
		touchX = e.touches ? e.touches[0].pageX : e.pageX - offsetX;
		touchY = e.touches ? e.touches[0].pageY : e.pageY - offsetY;
		// if(e.pageX === undefined || e.pageX === null) { //mobile
		// 	var a = e.originalEvent.touches[0]; var b = e.originalEvent.changedTouches[0];
		//     touchX = a.pageX || b.pageX ? a.pageX - offsetX : b.pageX - offsetX;
		// }
		// if(e.pageY === undefined || e.pageY === null) { //mobile
		// 	var a = e.originalEvent.touches[0]; var b = e.originalEvent.changedTouches[0];
		//     touchY = a.pageY || b.pageY ? a.pageY - offsetY : b.pageY - offsetY;
		// }
		e.offsetX ? offsetX = e.offsetX : offsetX = e.touchX;
		e.offsetY ? offsetY = e.offsetY : offsetY = e.touchY;
		x = offsetX/zoomer.offsetWidth*100;
		y = offsetY/zoomer.offsetHeight*100;
		zoomer.style.backgroundPosition = x + '% ' + y + '%';
	});
}	
//Dependent List Category Action
// 	if($('.ajaxForm').length){
// 		$('select[name="scales"]').on('change', function(e) {
// 		 e.stopPropagation(); e.preventDefault();
// 		  var scale = $(this).val();
// 		  if(scale !== 0)
// 		  {
// 			switch (scale) 
// 			{
// 				case '1':
// 				  var x = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL', '4XL', '5XL', '6XL', '7XL', '8XL', '9XL', '10XL'];appendVal(x,scale);
// 				  break;
// 				case '2':
// 				  var x = ['3', '3.5', '4', '4.5', '5', '5.5', '6', '6.5', '7', '7.5', '8', '8.5', '9', '9.5', '10', '10.5', '11', '11.5', '12', '12.5'];appendVal(x,scale);
// 				  break;
// 				case '3':
// 				  var x = ['5', '6', '7', '8', '9', '10', '11'];appendVal(x,scale);
// 				  break;
// 				case '4':
// 				  var x = ['1', '2', '3', '4', '5', '6', '7'];appendVal(x,scale);
// 				  break;
// 				case '5':
// 				  var x = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];appendVal(x,scale);
// 				  break;
// 				case '6':
// 				  var x = ['(24-36) A', '(24 - 36) B', '(24 - 36) C', '(24 - 36) D', '(24 - 36) E', '(24 - 36) F', '(24 - 36) G'];appendVal(x,scale);
// 				  break; 
// 				case '7':
// 				  var x = ['1g','2g','5g','10g','15g','20g','25g','30g','40g','50g','100g','150g','200g','250g','300g','400g','500g','1KG','2KG','5KG','10KG','20KG','50KG','100KG','500KG','1T'];appendVal(x,scale);
// 				  break; 			                       
// 				default:
// 			}
// 		  }
// 		  return false;
// 		});
// 		function appendVal(x,scale) {
// 		// remove previous dom	
// 		$("#xe").html('');

// 		let elem = ''
// // $('.old').each(function(index,value){
// // 	const z = $(this).val();
// // });

// 		$('#scaletype').val(scale);
// 		let Y = $('#dataArr').val().split(',');
// 		//let Y = $('#dataArr').val().toString();

// 		let dataScale = $('#xe').data('class');

// 		// create dom string taking each value from the array
// 		$.each(x, function(index, value) {
// //console.log(dataScale+scale); // 
// 		const status = $.inArray(value,Y) !== -1 && dataScale == scale ? 'checked="checked"':'';

// elem += "<label for='"+index+"'>"+value+"</label><input id='"+index+"' type='checkbox' name='psize[]' value='"+value+"' "+status+" />";

// //elem += `<label for="${index}">${value}</label><input id="${index}" type="checkbox" name="psize[]" value="${value}" ${Y.includes(value)?"checked":""} >`;


// 		  });

// 		// append the final dom string  
// 			$("#xe").append(elem); 
// 		}

	if ($('.ajaxForm').length) {
	    $('select[name="scales"]').on('change', function (e) {
	        e.stopPropagation();
	        e.preventDefault();
	        var scale = $(this).val();
	        if (scale !== 0) {
	            $.getJSON('data.json', function (data) {
	                var x = data[scale];
	                if (x !== undefined) {
	                    appendVal(x, scale);
	                }
	            });
	        }
	        return false;
	    });
	    function appendVal(x, scale) {
	        $("#xe").html('');
	        $('#scaletype').val(scale);
	        let Y = $('#dataArr').val().split(',');
	        let dataScale = $('#xe').data('class');
	        let elem = '';
	        $.each(x, function (index, value) {
	            const status = $.inArray(value, Y) !== -1 && dataScale == scale ? 'checked="checked"' : '';
	            elem += "<label for='" + index + "'>" + value + "</label><input id='" + index + "' type='checkbox' name='psize[]' value='" + value + "' " + status + " />";
	        });
	        $("#xe").append(elem);
	    }

		$("select[name='category']").on("change", function(e){
			e.preventDefault();
			var value = $(this).val();
			if(value === '0'){$("select[name='subcategory']").attr("disabled", true); $("select[name='ssc']").attr("disabled", true);}else{$("select[name='subcategory']").attr("disabled", false);} 
			$.ajax({
				type: "POST",
				url: "back/index/getSubcategory",
				data:'id='+value,		
				beforeSend:function(){ $('.loader').show(); }
			}).done(function(response){
				clearTimeout();
				setTimeout(function(){ 
					$("#subcategory").find('option').not(":first").remove();
					$("#ssc").find('option').not(":first").remove();
					response = JSON.parse(response);
					response.forEach(function(value){
						$('#subcategory').append('<option value="'+value.id+'">'+value.subcategory+'</option>');
					});
					$('.loader').hide();
				}, 200);
			}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		});
	//Dependent List Sub-Category Action
		$("select[name='subcategory']").on('change', function(e){
			e.preventDefault();
			var value = $(this).val();
			if(value === '0'){$("select[name='ssc']").attr("disabled", true);}else{$("select[name='ssc']").attr("disabled", false);} 	
			$.ajax({
				type: "POST",
				url: "back/index/getssc",
				data:'id='+value,	
				beforeSend:function(){ $('.loader').show(); }
			}).done(function(response){	
				clearTimeout();
				setTimeout(function(){
					$("#ssc").find('option').not(":first").remove();
					response = JSON.parse(response);
					response.forEach(function(value){
						$('#ssc').append('<option value="'+value.id+'">'+value.ssctitle+'</option>');
					});
					$('.loader').hide();
				}, 200);		
			}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		});
	//preview Uploaded multiple Image OnUpload
		$('#uploads').on('change', function(e){
			e.preventDefault();
			if(this.files.length>6){this.value = '';alert('More than 6 file not allowed!');}
			var files = e.target.files;
			var filesLength = files.length;
			for(var i = 0; i < filesLength; i++)
			{
				var fReader = new FileReader();
				fReader.onload = (function(e){ $('.previewImg').append("<img class='float_left width80x height80x' src='"+e.target.result+"'>"); });
				fReader.readAsDataURL(files[i]);
			}
		});
	//Dependent List Region Action
		$("#sregion").on("change", function(e){
			e.preventDefault();
			var value = $(this).val();
			if(value === '0'){$("#scity").attr("disabled", true); $("#sarea").attr("disabled", true);}else{$("select[name='scity']").attr("disabled", false);} 
			$.ajax({
				type: "POST",
				url: "index/getcity",
				data:'id='+value,		
				beforeSend:function(){ $('.loader').show(); }
			}).done(function(resp){
				clearTimeout();
				setTimeout(function(){ 
					$("#scity").find('option').not(":first").remove();
					$("#sarea").find('option').not(":first").remove();
					//$("#dcharge").find('option').first().remove();
					resp = JSON.parse(resp);
					resp.forEach(function(values){
						$('#scity').append('<option value="'+values.cid+'">'+values.city+'</option>');
					});
					$('.loader').hide();
				}, 200);
			}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		});
	//Dependent List City Action
		$("select[name='scity']").on('change', function(e){
			e.preventDefault();
			var value = $(this).val();
			if(value === '0'){$("select[name='sarea']").attr("disabled", true);}else{$("select[name='sarea']").attr("disabled", false);} 	
			$.ajax({
				type: "POST",
				url: "index/getarea",
				data:'id='+value,	
				beforeSend:function(){ $('.loader').show(); }
			}).done(function(response){	
				clearTimeout();
				setTimeout(function(){
					$("#sarea").find('option').not(":first").remove();
					$("#dcharge").find('option').first().remove();
					response = JSON.parse(response);
					response.forEach(function(value){
						$('#sarea').append('<option value="'+value.aid+'">'+value.area+'</option>');
					});
					$('.loader').hide();
				}, 200);		
			}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		});	
	//Dependent List Delivery_Charge Action	
		$("select[name='sarea']").on('change', function(e){
			e.preventDefault();
			var value = $(this).val();
			//if(value === '0'){$("select[name='dcharge']").attr("disabled", true);}else{$("select[name='dcharge']").attr("disabled", false);} 
			$.ajax({
				type: "POST",
				url: "index/getdelivery",
				data:{'xid':value},
				beforeSend:function(){ $('.loader').show(); }
			}).done(function(response){	
				clearTimeout();
				setTimeout(function(){
					//$("#dcharge").find('option').first().remove();
					response = JSON.parse(response);
					response.forEach(function(value){
						var dcost = parseInt(value.dcharge);
						//$('#dcharge').append('<option value="'+value.dcharge+'">'+value.dcharge+'</option>');
						$('#dcharge').val(dcost);
					});
					$('.loader').hide();
				}, 200);		
			}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		});		
	}
//ImageZoom Preview
	// if($('.previews').length){
	// //Load First Default Image in PreviewPane
	// 	$('.previews').css('background-image','url('+$('.imgkey').first().attr('data-src')+')');
	// //Mini image click function to change previewPane image			
	// 	$('.imgkey').on('mouseover mouseenter',function(){ $('.previews').css('background-image','url('+$(this).attr('data-src')+')'); });
	// //PreviewPane Mouse Move Function
	// 	$('.previews').on('mousemove touchmove',function(ev){
	// 		ev.preventDefault();
	// 		$('#zoomer').show().css('display','inline-block');
	// //Insert Lens on mouseOver
	// 		$(this).html('<div class="lens"></div>');
	// //Offset is outside of the element
	// 		var $offset = $(this).offset();
	// //Get Image Url for Zoomer
	// 		var imgSrc = $(this).css('background-image').replace(/^url\(['"](.+)['"]\)/, '$1');
	// //Adjust the mouse			
	// 		var posX = ev.originalEvent.touches ?  ev.originalEvent.touches[0].pageX : ev.pageX - $offset.left - 70;
	// 		var posY = ev.originalEvent.touches ?  ev.originalEvent.touches[0].pageY : ev.pageY - $offset.top - 70;
	// 		// var posX = ev.offsetX ? (ev.offsetX) : ev.pageX - $offset.left - 70;
	// 		// var posY = ev.offsetY ? (ev.offsetY) : ev.pageY - $offset.top - 70;
	// //prevent lens move outside of the previewPane
	// 		if(posX > $(this).width() - $('.lens').width()){posX = $(this).width() - ($('.lens').width() + 1) + 'px';}
	// 		if(posX < 0){posX = 0;}
	// 		if(posY > $(this).height() - $('.lens').height()){posY = $(this).height() - ($('.lens').height() + 1) + 'px';}
	// 		if(posY < 0){posY = 0;}
    // //Tweak the lens here
	// 		$('.lens').css('left', posX);
	// 		$('.lens').css('top', posY);
	// //Set zoomer background position
	// 		$('#zoomer').css('background-position',((-posX * 2) + "px " + (-posY * 2) + "px"));			
	// //Set image to zoomer
	// 		$('#zoomer').css('background-image','url('+imgSrc+')');	
	// 		return false;
	// 	});
	// //PreviewPane Mouse Out Function
	// 	$('.previews').on('mouseleave',function(){ $('.lens, #zoomer').hide(); });
	// }

 

//Quantity Counter
	if($('.pqty').length){
		var qty=1;
	    $('.ico-plus').click(function(e){
	        e.preventDefault();
	        var qty = parseInt($('.qty').val());
	        $('.qty').val(qty + 1);   
	        return false;     
	    });
	    $('.ico-minus').click(function(e){
	        e.preventDefault();
	        var qty = parseInt($('.qty').val());
	        if(qty > 1){$('.qty').val(qty - 1); }else{alert('Minimum 1 Required');}
	        return false;
	    });
	}
	if($('.vcqt').length){
		$('.ico-plus').on('click', function(e){
			e.preventDefault();
			var i = $(this).attr('data-id');
			var qty = parseInt($('#qty_'+i).val());
			$('#qty_'+i).val(qty + 1);
			if(qty > 0){var data_value = $('#qty_'+i).val();
				$.ajax({
					type: 'POST',
					url: 'index/updatecart',
					data:{'value':data_value,'id':i,},
					beforeSend:function(){$('.loader').show();}
				}).done(function(response){
					clearTimeout();
					setTimeout(function(){
						response = JSON.parse(response);
						response.forEach(function(value){
							if(i == value.id){
						$('.subtotals').text(value.subtotal);
						$('.gtotal').text('BDT '+(parseFloat(value.subtotal + value.shipingcost)));
						}else{alert('ERROR: Please reload page and try again!');}
						});
						$('.loader').hide();
					}, 200);
				}).fail(function(){
					$('.loader').show();
				}).always(function(){ });
			}else{alert('Minimum 1 required');}
			return false;
		});		
		$('.ico-minus').on('click', function(e){
			e.preventDefault();
			var i = $(this).attr('data-id');
			var qty = parseInt($('#qty_'+i).val());
			if(qty > 1){$('#qty_'+i).val(qty - 1);var data_value = $('#qty_'+i).val();
			$.ajax({
				type: 'POST',
				url: 'index/updatecart',
				data:{'value':data_value,'id':i,},
				beforeSend:function(){$('.loader').show();}
			}).done(function(response){
				clearTimeout();
				setTimeout(function(){
					response = JSON.parse(response);
					response.forEach(function(value){
						if(i == value.id){
						$('.subtotals').text(value.subtotal);
						$('.gtotal').text('BDT '+(parseFloat(value.subtotal + value.shipingcost)));
					}else{alert('ERROR: Please reload page and try again!');}
					});
					$('.loader').hide();
				}, 200);			
			}).fail(function(){
				$('.loader').show();
			}).always(function(){ });
			}else{alert('Minimum 1 required');}
			return false;
		}); 
	}

	$('.cartdel').on('click', function(){
		var dataid = $(this).data('id');
		if(confirm('Are you sure to delete this? This cannot be undone!')){	
			$.ajax({
				type: 'POST',
				url: 'index/cartdel/',
				data: {'id':dataid},
				cache: false,
				beforeSend:function(){ $('.loader').show(); }
			}).done(function(response){
				clearTimeout();
				setTimeout(function(){
					response = JSON.parse(response);
					response.forEach(function(value){
						$('.subtotals').text(value.subtotal);
						$('.shiptotal').text(parseFloat(value.shipingcost));
						$('.gtotal').text(parseFloat(value.subtotal) + parseFloat(value.shipingcost));
						if($.isNumeric(value.ccount) === true){
							$('.citem').text('[ '+value.ccount+' ]');
							$('#cart_'+dataid).remove();
							$('.loader').hide();
						}else{
							$('#cart_'+dataid).remove();
							$('.citem').text('[ '+'0'+' ]'); 
							$('.subtotals').text('0');
							$('.shiptotal').text('0');
							$('.gtotal').text('0');
							$('.loader').hide();
							fallback('index/viewcart/'+value.id);
						}
					 });
					$('.loader').hide();
				},200);
			}).fail(function(){
				alert('ERROR: Unable to perform delete action! Try again...');
			}).always(function(){});
		}else{ return false; }
	});
//AddCart Action
	$('.addcart').on('click', function(e){
		e.preventDefault();
		var color, price, size, shipcost, discount, productid, quantity, sizeVal, shop;
		productid = $(this).data('id');
		quantity = $('.qty').val();
		//size = $(".psize input[name='psize']:checked").data('value');
		//sizeVal = $('.xSize:checked').val();//$('.xSize').prop('checked', true).val();
		sizeVal = $('.xSize:checked').val();
		if($('.xSize').length && typeof sizeVal !== 'undefined'){size = sizeVal;}else{ size = '0';}
		price = parseInt($('.price').text());
		shipcost = $('#shipcharge').data('value');
		shop = $('#shopid').data('value');
		if($('.discount').text().trim() > 0){ discount = parseInt($('.discount').text()); }else{discount = parseInt(0);}
		color = $('.pcolor li').filter('.colorbrd').data('value');
		$.ajax({
			type: 'POST',
			url: 'index/addcart/',
			//dataType: "json",
			data:{'quantity':quantity,'price':price,'psize':size,'color':color,'discount':discount,'productid':productid,'delivery':shipcost,'shopno':shop},	
			beforeSend:function(){ $('.loader').show(); }
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('.loader').hide();
				if($.isNumeric(response) === true){$('.citem').text('[ '+response+' ]');}else{alert(response);}
			}, 200);		
		}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		return false;
	});	
//BuyNow	
	$('.buynow').on('click',function(e){
		e.preventDefault();
		var color, price, size, shipcost, discount, productid, quantity, sizeVal, shop, uri;
		productid = $(this).data('id');
		quantity = $('.qty').val();
		sizeVal = $('.xSize:checked').val();
		if($('.xSize').length && typeof sizeVal !== 'undefined'){size = sizeVal;}else{ size = '0';}
		price = parseInt($('.price').text());
		shipcost = $('#shipcharge').data('value');
		if($('.discount').text().trim() > 0){ discount = parseInt($('.discount').text()); }else{discount = parseInt(0);}
		color = $('.pcolor li').filter('.colorbrd').data('value');
		shop = $('#shopid').data('value');
		uri = 'index/getship';
		$.ajax({
			type: 'POST',
			url: 'index/buychoose/',
			//dataType: "json",
			data:{'quantity':quantity,'price':price,'size':size,'color':color,'discount':discount,'productid':productid,'delivery':shipcost,'shopno':shop},	
			beforeSend:function(){ $('.loader').show(); }
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('.loader').hide();
				if($.isNumeric(response) === true || response === 'Y'){fallback(uri);}else{alert(response);}
			}, 200);		
		}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		return false;
	});
	$('#checkoutbtn').on('click',function(e){
		e.preventDefault();
		var url = 'index/checkout/';
    	fallback(url);
    	return false;
	});	
	$('#continuebtn').on('click', function(e){
		e.preventDefault();
		var uri = 'index/';
    	fallback(uri);
		return false;
	});
	$('#updshipbtn').on('click', function(e){
		e.preventDefault();
		var uri = 'index/getship/';
		fallback(uri);
		return false;
	});
	$('#orderbtn').on('click',function(e){
		e.preventDefault();
		var url = 'index/payment/';
    	location.replace(url);
    	return false;
	});	
	$('#all').on('change',function(e){
		e.preventDefault();
		const url = 'index/subCategory/'+$(this).val();
    	fallback(url);
    	return false;
	});			
	// if($('#orderbtn').length){
	// 	$('#orderbtn').on('click',function(e){
	// 		e.preventDefault();
	// 		var orders = [];
	// 		$('.oid').each(function(){ return orders.push($(this).text()); });
	// 		var uri = 'index/order/';
	// 		var load = 'index/payment/';
	// 		$.ajax({
	// 			type: "POST",
	// 			url: uri,
	// 			data:{'orders':orders},
	// 			beforeSend:function(){ $('.loader').show(); }	
	// 		}).done(function(response){	
	// 			clearTimeout();
	// 			setTimeout(function(){
	// 				$('.loader').hide();
	// 				if(response === 'Y'){fallback(load);}else{console.log(response);}
	// 			}, 200);		
	// 		}).fail(function(){ }).always(function(){ });
	//     	return false;		
	// 	});	
	// }

	$('.pcolor li').on('click',function(e){
		e.preventDefault();
		if($('.pcolor li').hasClass('colorbrd')){$('.pcolor li').removeClass('colorbrd');}
		$(this).addClass('colorbrd');
		return false;
	});
	$('.psize').on('click',function(e){
		e.preventDefault();
		$(this).find("input:radio").prop('checked', true);
		var selected = $(".psize input[name='psize']:checked");
		$('.psize').removeClass('bg444 colorFFF bold');
		selected.parent().addClass('bg444 colorFFF bold');
		return false;
	});	
	$('#login').on('click', function(e){e.preventDefault();$('.login').fadeIn(500);return false;});
	$('.close').on('click', function(e){e.stopPropagation();e.preventDefault();$('.login, #paybox').fadeOut(500);return false;});
	$('#couponTips').on('click', function(e){e.preventDefault();alert('100% will make delivery cost free.');});
	$('.pay').on('click', function(){
		var Imgdata = $(this).attr('data-id');
		var Imgsrc = $(this).attr('data-src');
		$('#pimg').attr('src',Imgsrc);
		$('#pimg').attr('alt',Imgdata);
		$('#paybox').attr('data-id',Imgdata);
		if(Imgdata === 'cashon'){$('#paymsg').hide();$('#cashmsg').show();}else{$('#cashmsg').hide();$('#paymsg').show();}
		$('#paybox').fadeIn(500);
	});
	$('#paybt').on('click',function(e){
		e.preventDefault();
		var paytype = $('#paybox').data('id');
		var trxid = $('#trxno').val();
		var pamount = $('#pamount').val();
		//console.log(trxid);
		$.ajax({
			type: "POST",
			url: "index/payprocess",
			data:{'paytype':paytype,'trxid':trxid,'pamount':pamount},
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('#paybox').fadeOut();
				if(response === 'Y'){fallback('index/thanks');}else{alert(response);}
			}, 200);		
		}).fail(function(){ }).always(function(){ });
		return false;
	});
	$('#cashbt').on('click',function(e){
		e.preventDefault();
		var paytype = $('#paybox').data('id');
		var trxid = $('#autotrxno').val();
		var pamount = $('#pamount').val();
		$.ajax({
			type: "POST",
			url: "index/payprocess",
			data:{'paytype':paytype,'trxid':trxid,'pamount':pamount},
		}).done(function(response){
			clearTimeout();
			setTimeout(function(){
				$('#paybox').fadeOut();
				if(response === 'Y'){fallback('index/thanks');}else{alert(response);}
			}, 200);		
		}).fail(function(){console.log(response);}).always(function(){ });
		return false;
	});
	$('#getcoupon').on('click',function(e){
		e.preventDefault();
		var getdata = $('#coupon').val();
		$.ajax({
			type: "POST",
			url: "index/coupon",
			//dataType: "json",
			data:{'couponcode':getdata},
			beforeSend:function(){ $('.loader').show(); }
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('.loader').hide();
				//alert(response);
			}, 200);		
		}).fail(function(){ console.log('ERROR: Please reload page and try again!'); }).always(function(){ });
		return false;
	});
	if($('.invo').length){
		$('.invo').on('click', function(e){
			e.preventDefault();
			const id = $(this).data('id');
			var url = 'back/index/doPrint'+'/'+id;
	    	fallback(url);
			return false;
		});
	}
	// $('#invoice').on('click', function(){
		
	// });
//RatingStars	
	if($('.rating').length){	
		$('.star').on('mouseover',function(){
			let onStar,stars,i;
			onStar = parseInt($(this).data('value'));
			$(this).parent().children('.star').each(function(e){
			  if(e < onStar) {$(this).addClass('hover');}else{$(this).removeClass('hover');}
			});
			}).on('mouseout', function(){ $(this).parent().children('.star').each(function(e){$(this).removeClass('hover');}); 
		});
		$('.star').on('click',function(){
			let star,pid,uid;
			pid = $("#pid").val();
			star = parseInt($(this).data('value'));
			$(this).parent().children('.star').each(function(e){
				if(e < star) {$(this).addClass('selected');}else{$(this).removeClass('selected');}
			});
			$.ajax({
				type: "POST",
				url: "index/rating",
				data:{'rating':star,'pid':pid},
				beforeSend:function(){ $('.loader').show(); }
			}).done(function(response){	
				clearTimeout();
				setTimeout(function(){
					$('.loader').hide();
					if(response === 'Y'){alert('Thank You!');}else if(response === 'N'){alert('Try again!');}else{alert('Thanks!');}
				}, 200);		
			}).fail(function(){ console.log('ERROR: Please reload page and try again!'); }).always(function(){ });
		});
	}
	if($('#pass').length){
		$('#pass').on('click',function(){
			$(this).toggleClass('ico-eyeOn ico-eyeOff');$('#lpasswd').attr('type') === 'password' ? $('#lpasswd').attr("type", "text") : $('#lpasswd').attr("type", "password");
		});
	}
	// $('.location').on('load', function(){
	// 	var lat = position.coords.latitude;
	// 	var long = position.coords.longitude;
	//     if(navigator.geolocation){
	//         navigator.geolocation.getCurrentPosition(lat, long);
	//     }else{ 
	//         $('#location').html('Geolocation is not supported by this browser.');
	//     }		
	// });
//End...
});
//Check if document visible or hidden
//if(document.visibilityState === 'visible'){console.log('Now Visible');}else{console.log('InVisible');}
//ClipBoard
// let urI = window.location.href;
// let urL = document.querySelector('.class');
// function clipboard()
// {
// 	url.select(); //TextField
// 	url.setSelectionRange(0,99999); //MobileDevice
// 	return navigator.clipboard.writeText(urL);
// }

// Tab Nabbing issue
//window.opener.location.replace("http://localhost/f");
//const w = window.open(url, "target=_blank"); w.opener = null;
//FixTouchMove
// document.body.addEventListener("touchstart", function(e){ if (e.target.nodeName == $(this)) { e.preventDefault(); } }, false);
// document.body.addEventListener("touchend", function(e){ if (e.target.nodeName == $(this)) { e.preventDefault(); } }, false);
// document.body.addEventListener("touchmove", function(e){ if (e.target.nodeName == $(this)) { e.preventDefault(); } }, false);
// Disable WriteClick
//document.addEventListener('contextmenu', event => event.preventDefault());
// Disable Key Combination
//document.onkeydown = function(e){ if (e.ctrlKey && (e.keyCode === 85) || e.ctrlKey && (e.shiftKey || e.keyCode === 16)) { return false; } };

//ClickJackPrevention


// $(function(){'use strict';
// $('a[target=_blank]').attr('rel','noopener noreferrer');
// $('figure img,img,image,picture,object,iframe,embed,video,figure').attr('src','data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==');
// setTimeout(function(){$(":not(.baselogo,.bannerImg),figure img,img,image,picture,object,iframe,embed,figure,video").each(function(){$(this).attr("src",$(this).attr("data-src"))});},100);
// $(':not(.baselogo,.bannerImg),figure img,img,image,picture,object,iframe,embed,figure,video').attr('loading','lazy').attr('fetchpriority','high').attr('loading','auto');
// var empty=true;$('input[type="text"]').each(function(){if(!$(this).val().trim()){empty=false;return false;}});
// if($('.rateE').data('value') == $('#avgRating').val()){$('.rateA,.rateB,.rateC,.rateD,.rateE').css('color','#903');}
// if($('.rateD').data('value') == $('#avgRating').val()){$('.rateA,.rateB,.rateC,.rateD').css('color','#903');}
// if($('.rateC').data('value') == $('#avgRating').val()){$('.rateA,.rateB,.rateC').css('color','#903');}
// if($('.rateB').data('value') == $('#avgRating').val()){$('.rateA,.rateB').css('color','#903');}
// if($('.rateA').data('value') == $('#avgRating').val()){$('.rateA').css('color','#903');}
// if($('.zoom').length){
// $('.zoom').css('background-image','url("'+$('.imgkey').first().data('src')+'")').append('<img alt="'+$('.imgkey').first().attr('alt')+'" src="'+$('.imgkey').first().data('src')+'" data-src="'+$('.imgkey').first().data('src')+'"/>');
// $('.imgkey').on('mouseover, mouseenter',function(){$('.zoom').empty().css('background-image','url("'+$(this).data('src')+'")').append('<img alt="'+$(this).attr('alt')+'" src="'+$(this).data('src')+'" data-src="'+$(this).data('src')+'"/>');});
// $('.zoom').on('mousemove touchmove',function(e){
// e.stopPropagation();e.preventDefault();
// let zoomer,offsetX,offsetY,x,y,touchX,touchY;
// zoomer=e.currentTarget;
// offsetX=$(this).offset().left;
// offsetY=$(this).offset().top;
// touchX=e.touches?e.touches[0].pageX:e.pageX-offsetX;
// touchY=e.touches?e.touches[0].pageY:e.pageY-offsetY;
// e.offsetX?offsetX=e.offsetX:offsetX=e.touchX;
// e.offsetY?offsetY=e.offsetY:offsetY=e.touchY;
// x=offsetX/zoomer.offsetWidth*100;
// y=offsetY/zoomer.offsetHeight*100;
// zoomer.style.backgroundPosition=x+'% '+y+'%';});}
// if($('.ajaxForm').length){
// $('select[name="scales"]').on('change',function(e){
// e.stopPropagation();e.preventDefault();
// var scale=$(this).val();
// if(scale!==0){switch(scale){
// case '1':var x=['S','M','L','XL','XXL','XXXL','4XL','5XL','6XL','7XL','8XL','9XL','10XL'];appendVal(x,scale);break;
// case '2':var x=['3','3.5','4','4.5','5','5.5','6','6.5','7','7.5','8','8.5','9','9.5','10','10.5','11','11.5','12','12.5'];appendVal(x,scale);break;
// case '3':var x=['5','6','7','8','9','10','11'];appendVal(x,scale);break;
// case '4':var x=['1','2','3','4','5','6','7'];appendVal(x,scale);break;
// case '5':var x=['A','B','C','D','E','F','G'];appendVal(x,scale);break;
// case '6':var x=['(24-36) A','(24 - 36) B','(24 - 36) C','(24 - 36) D','(24 - 36) E','(24 - 36) F','(24 - 36) G'];appendVal(x,scale);break;
// case '7':var x=['1g','2g','5g','10g','15g','20g','25g','30g','40g','50g','60g','70g','80g','90g','100g','110g','120g','130g','140g','150g','160g','170g','180g','190g','200g'];appendVal(x,scale);break;
// case '8':var x=['30x','35x','40x','45x','50x','55x','60x','65x','70x','75x','80x','85x','90x','95x','100x','105x','110x','115x','120x','125x','130x','135x','140x','145x','150x','155x','160x','165x','170x','175x','180x','185x','190x','195x','200x'];appendVal(x,scale);break;
// default:break;}}else{return false;}});
// var appendVal=function(a,s){$('select[name="attributes"]').empty();$.each(a,function(i,v){$('select[name="attributes"]').append('<option value="'+v+'">'+v+'</option>');});};
// $('select[name="attributes"]').on('change',function(e){
// e.stopPropagation();e.preventDefault();
// var scale=$(this).val();
// if(scale!==0){switch(scale){
// case 'A':$('.price').text('5000');break;
// case 'B':$('.price').text('7500');break;
// case 'C':$('.price').text('10000');break;
// case 'D':$('.price').text('15000');break;
// case 'E':$('.price').text('20000');break;
// case 'F':$('.price').text('25000');break;
// case 'G':$('.price').text('30000');break;
// default:break;}}else{return false;}});}
// if($('.progress-bar').length){$('.progress-bar').each(function(i){if($(this).data('value')<=30){$(this).css('background-color','#f00');}
// else if($(this).data('value')<=50){$(this).css('background-color','#fa0');}
// else if($(this).data('value')<=70){$(this).css('background-color','#ff0');}
// else if($(this).data('value')<=90){$(this).css('background-color','#6f0');}
// else{$(this).css('background-color','#0f0');}});}
// if($('.grid').length){$('.grid').on('click',function(){$(this).toggleClass('grid3').toggleClass('grid4');});}
// if($('.imgkey').length){$('.imgkey').on('click',function(){$('.zoom').empty().css('background-image','url("'+$(this).data('src')+'")').append('<img alt="'+$(this).attr('alt')+'" src="'+$(this).data('src')+'" data-src="'+$(this).data('src')+'"/>');});}
// if($('.pDh,.pDv,.pDn').length){$('.pDh,.pDv,.pDn').on('click',function(){$(this).toggleClass('pDh').toggleClass('pDv').toggleClass('pDn');});}
// if($('.pDx,.pDy,.pDn').length){$('.pDx,.pDy,.pDn').on('click',function(){$(this).toggleClass('pDx').toggleClass('pDy').toggleClass('pDn');});}
// if($('.pDn').length){$('.pDn').on('click',function(){$('.pDx,.pDy').removeClass('pDx').removeClass('pDy').addClass('pDn');});}
// if($('.pDb,.pDf,.pDn').length){$('.pDb,.pDf,.pDn').on('click',function(){$(this).toggleClass('pDb').toggleClass('pDf').toggleClass('pDn');});}
// if($('.pDr,.pDb,.pDf').length){$('.pDr,.pDb,.pDf').on('click',function(){$(this).toggleClass('pDr').toggleClass('pDb').toggleClass('pDf');});}
// if($('.pDr').length){$('.pDr').on('click',function(){$('.pDb,.pDf').removeClass('pDb').removeClass('pDf').addClass('pDr');});}
// if($('.pDl,.pDr,.pDb,.pDf').length){$('.pDl,.pDr,.pDb,.pDf').on('click',function(){$(this).toggleClass('pDl').toggleClass('pDr').toggleClass('pDb').toggleClass('pDf');});}
// if($('.rtl,.ltr').length){$('.rtl').on('click',function(){$('html').attr('dir','rtl');});$('.ltr').on('click',function(){$('html').attr('dir','ltr');});}
// if($('.dark,.light').length){$('.dark').on('click',function(){$('html').attr('theme','dark');});$('.light').on('click',function(){$('html').attr('theme','light');});}
// if($('.ajaxForm').length){$('.ajaxForm').submit(function(e){e.preventDefault();var form=$(this);var url=form.attr('action');var type=form.attr('method');var data=form.serialize();$.ajax({type:type,url:url,data:data}).done(function(data){console.log(data);});});}
// if($('.ajaxLink').length){$('.ajaxLink').on('click',function(e){e.preventDefault();var url=$(this).attr('href');$.ajax({url:url}).done(function(data){console.log(data);});});}
// });

