$(function(){ 'use strict';
//Begin...
	$('img, image, picture, object, iframe, embed, figure, video').attr('src','data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==');
	setTimeout(function(){ $("img, image, picture, object, iframe, embed, figure, video").each(function(){ $(this).attr("src",$(this).attr("data-src")); }); },1000);
	$('img, image, picture, object, iframe, embed, figure, video').attr('loading','lazy');
	$('.baselogo, .bannerImg').attr('loading','auto');
	//var empty = true;$('input[type="text"]').each(function(){if(!$(this).val().trim()){empty = false;return false;}});
function fallback(url){ location.replace(url);return false; }
//SearchAction	

//Dependent List Category Action
	if($('.ajaxForm').length > 0){
		$('select[name="scales"]').on('change', function(e) {
		  e.preventDefault();
		  var scale = $(this).val();
		  if(scale != 0)
		  {
			  switch (scale) {
			    case 'shirtscale':
			      var x = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL', '4XL', '5XL', '6XL', '7XL', '8XL', '9XL', '10XL'];appendVal(x);
			      break;
			    case 'ringscale':
			      var x = ['3', '3.5', '4', '4.5', '5', '5.5', '6', '6.5', '7', '7.5', '8', '8.5', '9', '9.5', '10', '10.5', '11', '11.5', '12', '12.5'];appendVal(x);
			      break;
			    case 'shoescale':
			      var x = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];appendVal(x);
			      break;
			    case 'waistscale':
			      var x = ['1', '2', '3', '4', '5', '6', '7'];appendVal(x);
			      break;
			    case 'wristscale':
			      var x = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];appendVal(x);
			      break;
			    case 'bustscale':
			      var x = ['(24-36) A', '(24 - 36) B', '(24 - 36) C', '(24 - 36) D', '(24 - 36) E', '(24 - 36) F', '(24 - 36) G'];appendVal(x);
			      break; 
			    case 'weightscale':
			      var x = ['1g','2g','5g','10','15g','20g','25g','30g','40g','50g','100g','200g','250g','300g','400g','500g','1KG','2KG','5KG','10KG','20KG','50KG','100KG','500KG','1T'];appendVal(x);
			      break; 			                       
			    default:
			  }
		  }
		  return false;
		});
		function appendVal(x) {
		  $("#xe").html('');// remove previous dom
		  let elem = ''
		  $.each(x, function(index, value) {
		    elem += "<label for='"+index+"'>"+value+"</label><input id='"+index+"' type='checkbox' name='psize[]' value='"+value+"'>";// create dom string taking each value from the arrat
		  });
		  $("#xe").append(elem); // append the final dom string
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
			$('.previewImg').html('');
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
					$("#dcharge").find('option').first().remove();
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
				data:'id='+value,	
				beforeSend:function(){ $('.loader').show(); }	
			}).done(function(response){	
				clearTimeout();
				setTimeout(function(){
					$("#dcharge").find('option').first().remove();
					response = JSON.parse(response);
					response.forEach(function(value){				
						//$('#dcharge').append('<option value="'+value.dcharge+'">'+value.dcharge+'</option>');
						$('#dcharge').val(value.dcharge);
						console.log(value.dcharge);
					});
					$('.loader').hide();
				}, 200);		
			}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		});		
	}
//ImageZoom Preview
	if($('.previews').length > 0){
	//Load First Default Image in PreviewPane	
		$('.previews').css('background-image','url('+$('.imgkey').first().attr('data-src')+')');
	//Mini image click function to change previewPane image			
		$('.imgkey').on('mouseover mouseenter',function(){ $('.previews').css('background-image','url('+$(this).attr('data-src')+')'); });
	//PreviewPane Mouse Move Function
		//$('.previews').on('mousemove touchmove',function(ev){
		//	ev.preventDefault();
		//	$('#zoomer').show().css('display','inline-block');
	//Insert Lens on mouseOver
		//	$(this).html('<div class="lens"></div>');			
	//Offset is outside of the element
		//	var $offset = $(this).offset();
	//Get Image Url for Zoomer
		//	var imgSrc = $(this).css('background-image').replace(/^url\(['"](.+)['"]\)/, '$1');
	//Adjust the mouse			
		//	var posX = ev.originalEvent.touches ?  ev.originalEvent.touches[0].pageX : ev.pageX - $offset.left - 70;			
		//	var posY = ev.originalEvent.touches ?  ev.originalEvent.touches[0].pageY : ev.pageY - $offset.top - 70;
			// var posX = ev.offsetX ? (ev.offsetX) : ev.pageX - $offset.left - 70;
			// var posY = ev.offsetY ? (ev.offsetY) : ev.pageY - $offset.top - 70;
	//prevent lens move outside of the previewPane
			// if(posX > $(this).width() - $('.lens').width()){posX = $(this).width() - ($('.lens').width() + 1) + 'px';}
			// if(posX < 0){posX = 0;}
			// if(posY > $(this).height() - $('.lens').height()){posY = $(this).height() - ($('.lens').height() + 1) + 'px';}
			// if(posY < 0){posY = 0;}
    //Tweak the lens here
		//	$('.lens').css('left', posX);
		//	$('.lens').css('top', posY);
	//Set zoomer background position				
		//	$('#zoomer').css('background-position',((-posX * 2) + "px " + (-posY * 2) + "px"));			
	//Set image to zoomer
		//	$('#zoomer').css('background-image','url('+imgSrc+')');	
		//	return false;		
		//});
	//PreviewPane Mouse Out Function
	//	$('.previews').on('mouseleave',function(){ $('.lens, #zoomer').hide(); });
	}
//Quantity Counter
	if($('.pqty').length > 0){
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
	if($('.vcqt').length > 0){
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
//AddCart Action
	$('.addcart').on('click', function(e){
		e.preventDefault();
		var color, price, size, shipcost, discount, productid, quantity, sizeVal;
		productid = $(this).attr('data-id');
		quantity = $('.qty').val();
		color = $('.pcolor li').filter('.colorbrd').attr('data-value');
		price = parseInt($('.price').text());
		sizeVal = $('.xSize:checked').val();
		if(typeof sizeVal !== 'undefined' && sizeVal.length > 0){size = $('.xSize:checked').val();}else{ size = '0';}
		if($('#shipcharge').attr('data-value')){shipcost = $('#shipcharge').attr('data-value');}else{ shipcost = '0';}
		if($('.discount').text().trim() > 0){ discount = parseInt($('.discount').text()); }else{discount = parseInt(0);}
		$.ajax({
			type: 'POST',
			url: 'index/addcart/',
			//dataType: "json",
			data:{'quantity':quantity,'price':price,'size':size,'color':color,'discount':discount,'productid':productid,'shipingcost':shipcost},	
			beforeSend:function(){ $('.loader').show(); }	
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('.loader').hide();
				console.log(response);
				if($.isNumeric(response) === true){$('.citem').text('[ '+response+' ]');}else{alert(response);}
			}, 200);		
		}).fail(function(){ alert('ERROR: Please reload page and try again!'); }).always(function(){ });
		return false;
	});
	$('.cartdel').on('click', function(e){
		e.preventDefault();
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
							//$('#cart_'+dataid).hide();
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
				},200);
			}).fail(function(){
				alert('ERROR: Unable to perform delete action! Try again...');
			}).always(function(){});
		}else{ return false; }
	});
//BuyNow	
	$('.buynow').on('click',function(e){
		e.preventDefault();
		var color, price, size, shipcost, discount, productid, quantity, sizeVal, uri;
		productid = $(this).attr('data-id');
		quantity = $('.qty').val();
		sizeVal = $('.xSize:checked').val();
		if(typeof sizeVal !== 'undefined' && sizeVal.length > 0){size = $('.xSize:checked').val();}else{ size = '0';}
		price = parseInt($('.price').text());
		shipcost = $('#shipcharge').data('value');;
		if($('.discount').text().trim() > 0){ var discount = parseInt($('.discount').text()); }else{var discount = parseInt(0);}
		color = $('.pcolor li').filter('.colorbrd').data('value');	
		uri = 'index/getship';	
		$.ajax({
			type: 'POST',
			url: 'index/buychoose/',
			//dataType: "json",
			data:{'quantity':quantity,'price':price,'size':size,'color':color,'discount':discount,'productid':productid,'dcharge':shipcost},	
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
	$('#paybtn').on('click',function(e){
		e.preventDefault();
		var url = 'index/thanks/';
    	fallback(url);
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
		var url = 'index/';
    	fallback(url);		
		return false;
	});
	$('#updshipbtn').on('click', function(e){
		e.preventDefault();
		var url = 'index/getship/';
		fallback(url);
		return false;
	});
	$('#orderbtn').on('click',function(e){
		e.preventDefault();
		var orders = [];
		$('.oid').each(function(){
			return orders.push($(this).text());
		});
		var uri = 'index/order/';
		$.ajax({
			type: "POST",
			url: uri,
			data:{'orders':orders},
			beforeSend:function(){ $('.loader').show(); }	
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('.loader').hide();
				if(response === 'Y'){fallback("index/payment");}else{console.log(response);}
			}, 200);		
		}).fail(function(){ }).always(function(){ });
    	return false;		
	});		
	$('.pcolor li').on('click',function(e){
		e.preventDefault();
		if($('.pcolor li').hasClass('colorbrd')){$('.pcolor li').removeClass('colorbrd');}
		$(this).addClass('colorbrd');
		return false		
	});
	$('.psize').on('click',function(e){
		e.preventDefault();
		$(this).find("input:radio").prop('checked', true);
		var selected = $(".psize input[name='psize']:checked");
		$('.psize').removeClass('bg444 colorFFF bold');
		selected.parent().addClass('bg444 colorFFF bold');
		return false;
	});
	$('#login').on('click', function(e){
		e.preventDefault();
		$('.login').fadeIn(500);
		return false;
	});
	$('.close').on('click', function(e){
		e.preventDefault();
		$(this).parent().fadeOut(500);
		return false;
	});
	$('.pay').on('click', function(e){
		e.preventDefault();
		var Imgdata = $(this).find('img').attr('data-id'); 
		var Imgsrc = $(this).find('img').attr('data-src');
		$('#pimg').attr('src',Imgsrc);
		$('#pt').val(Imgdata);
		$('#paybox').attr('data-id',Imgdata);
		if(Imgdata === 'cashon'){$('#paymsg').hide();$('#cashmsg').show();}else{$('#cashmsg').hide();$('#paymsg').show();}
		$('#paybox').fadeIn(500);		
		return false;
	});
	$('#paybt').on('click',function(e){
		e.preventDefault();
		var paytype = $('#paybox').attr('data-id');	
		var trxid = $('#trxno').val();
		var pamount = $('#pamount').val();		
		$.ajax({
			type: "POST",
			url: "index/payprocess",
			data:{'paytype':paytype,'trxid':trxid,'pamount':pamount},	
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('#paybox').fadeOut();
				if(response === 'Y'){fallback("index/thanks");}else{alert(response);}
			}, 200);		
		}).fail(function(){ }).always(function(){ });
		return false;
	});
	$('#cashbt').on('click',function(e){
		e.preventDefault();
		var paytype = $('#paybox').attr('data-id');	
		var trxid = $('#trxno').val();
		var pamount = $('#pamount').val();
		$.ajax({
			type: "POST",
			url: "index/payprocess",
			data:{'paytype':paytype,'trxid':trxid,'pamount':pamount},	
		}).done(function(response){	
			clearTimeout();
			setTimeout(function(){
				$('#paybox').fadeOut();
				if(response === 'Y'){fallback("index/thanks");}else{alert(response);}
			}, 200);		
		}).fail(function(){ }).always(function(){ });
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
//Rating
	$('.rating li').on('mouseover', function(){
	var onStar = parseInt($(this).data('value'), 10); 
		
	$(this).parent().children('li').each(function(e){
	  if (e < onStar) {$(this).addClass('hover');}
	  else {$(this).removeClass('hover');}
	});

	}).on('mouseout', function(){ $(this).parent().children('li').each(function(e){$(this).removeClass('hover');}); });
	
	// $('.rating li').on('click', function(){
	// var onStar = parseInt($(this).data('value'), 10); 
	// var stars = $(this).parent().children('li');
	// alert(stars);
	// var i;
	// for (i = 0; i < stars.length; i++) {
	//   $(stars[i]).removeClass('selected');
	// }
	// for (i = 0; i < onStar; i++) {$(stars[i]).addClass('selected');}  });
  
	
//End...	
});

