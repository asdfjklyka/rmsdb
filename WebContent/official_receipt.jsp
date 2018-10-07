<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RIBRAGE OFFICIAL RECEIPT</title>
    <link rel="stylesheet" href="css/style.default.css" />
</head>
<body style="background: white">

<div class="container">
	<div class="row">
        <div class="receipt-main col-xs-10 col-sm-10 col-md-6 col-xs-offset-1 col-sm-offset-1 col-md-offset-3">
            <div class="row">
    			<div class="receipt-header">
					<div class="col-xs-6 col-sm-6 col-md-6">
						<div class="receipt-left">
							<img class="" alt="" src="images/ribrage.png" style="width: 71px; border-radius: 43px;">
						</div>
					</div>
					<div class="col-xs-6 col-sm-6 col-md-6 text-right"> 
						<div class="receipt-right">
							<h5>RibRage Diner</h5>
							<p>(02) 358 0110 <i class="fa fa-phone"></i></p>
							<p>ribragediner@gmail.com <i class="fa fa-envelope-o"></i></p>
							<p>Philippines <i class="fa fa-location-arrow"></i></p>
						</div>
					</div>
				</div>
            </div>
			
			<div class="row">
				<div class="receipt-header receipt-header-mid">
					<div class="col-xs-8 col-sm-8 col-md-8 text-left">
						<div class="receipt-right">
							<h5>Johan Dietrich Eugenio <small>  |   Owner</small></h5>
							<p>Phone Number: (02) 358 0110</p>
							<p>Email : ribragediner@gmail.com</p>
							<p>Address : 183 D Maginhawa, Brgy, Lungsod Quezon, 1101 Kalakhang Maynila</p>
						</div>
					</div>
					<div class="col-xs-4 col-sm-4 col-md-4">
						<div class="receipt-left">
							<h1>Receipt</h1>
						</div>
					</div>
				</div>
            </div>
			
            <div>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody id="contents">
                    </tbody>
                </table>
            </div>
			
			<div class="row" id="paid_at">
				<div class="receipt-header receipt-header-mid receipt-footer">
					<div class="col-xs-8 col-sm-8 col-md-8 text-left">
						<div class="receipt-right">
							<p><b>Date :</b> </p>
							<h5 style="color: rgb(140, 140, 140);">Thank you! Come again.</h5>
						</div>
					</div>
					<div class="col-xs-4 col-sm-4 col-md-4">
						<div class="receipt-left">
							<h3>Signature</h3>
						</div>
					</div>
				</div>
            </div>
			
        </div>    
	</div>
</div>

<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
$(function(){
	console.log(localStorage.getItem("area_id"));

	$.ajax({
		type:'GET',
		data:{
	    	area_id: localStorage.getItem("area_id")
		},
		url:'GetOrderData',
		success: function(data) {
			console.log(data);
		    $("#contents").html(data);
		    
		    
		}
	});
	
});

	
</script>
</body>
</html>