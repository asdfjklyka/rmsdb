<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>RMS</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/ribrage.png" type="image/png">

  <title>RMS</title>

  <link href="css/style.default.css" rel="stylesheet">
  <link href="js/plugins/sweetalert/sweetalert.css" rel="stylesheet">
  <style>
  	.item_id, .item-id { display:none }
  	.headerRow {display:none}
  	.itemRow { margin-top: 20px; padding: 10px }
  	.item-decrement, .item-increment, .item-quantity{ float:left; }
  	.item-decrement{ font-weight: 900; font-size: 30px}
  	.item-increment{ font-weight: 900; font-size: 20px}
  	.item-total {clear:both}
  	.itemRow:nth-child(even){background:#cccccc}
  	.itemRow:nth-child(odd){background:#f1ecef}
  </style>
 
</head> 
<body style="background: #040404;">

<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>

<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/rmsdb"
                           user="root"  password=""/>
                           
  <sql:query dataSource="${db}" var="category">
            SELECT * from rms_dish_category order by category_name asc;
        </sql:query>

<sql:query dataSource="${db}" var="dish">
            SELECT * from rms_dishes dishes inner join rms_dish_category cat on dishes.category_id = cat.category_id order by category_name asc;
</sql:query>

<section>

  <div class="mainpanel" style="margin:0 auto; min-height:500px">

    <div class="headerbar">

      <div class="header-right">
        <ul class="headermenu">
          <li>
            <div class="btn-group">
              <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                <img src="images/photos/loggeduser.png" alt="" />
                <%=session.getAttribute("fullname")%> 
              </button>
              
              <ul class="dropdown-menu dropdown-menu-usermenu pull-right">
                <li><a href="Logoutservlet"><i class="glyphicon glyphicon-log-out"></i> Log Out</a></li>
              </ul>
             
            </div>
          </li>
         
        </ul>
      </div><!-- header-right -->

    </div><!-- headerbar -->

    <div class="pageheader">
      <h2><i class="fa fa-list"></i>Order Menu</h2>
      <div class="breadcrumb-wrapper">
        <span class="label"></span>
        <ol class="breadcrumb">
          <li class="active">Order Menu</li>
        </ol>
      </div>
    </div>

 

 	<div class="contentpanel">
	 	<div class="col-sm-10">
	        <div class="panel panel-default">
	        <div class="panel-body" >
	        <!-- Panel Body starts here -->
			<section id="main-content">
	            <section class="wrapper">
	                <!-- page start-->
	                <div class="row">
	
					  <div class="col-md-12">
					    <ul id="categories" style="padding-left:15px">
							<c:forEach var="row" items="${category.rows}">
								<li class="btn btn-default" onclick="getDishes('${row.category_id}')">${row.category_name}</li>
							</c:forEach>
					    </ul>
					  </div>
					  
					  <div class="tab-content" style="display:flex; max-height:1000px; min-height:410px;" id="dishes">
					   	<div class='fade in' style='text-align:center'>PLEASE PICK FROM THE MENU BELOW</div>
					  </div>
					 </div>
	   			</section>
			</section>
			</div> <!-- panel body -->
			</div> <!-- panel default -->
		</div>
		<div class="panel panel-default" style="background: white">
		<div id="orderdetails" class="col-md-2 nav-collapse" style="max-height:500px; min-height: 500px; background:#fcfcfc">
			<div class="card">
				<div class="card-header"><h3>ORDER DETAILS</h3></div>
				<div class="card-block" style="min-height: 300px;max-height:300px;overflow-y:scroll">
				    <div class="simpleCart_items"></div>
            	
				</div>
				<div class="card-footer" style="margin-bottom: 50px; margin-top: 10px">
					SubTotal: <span id="simpleCart_total" class="simpleCart_total"></span> <br />
					-----------------------------<br />
					Total Cost: <span id="simpleCart_grandTotal" class="simpleCart_grandTotal"></span> <br /><br />
					<button class="btn btn-primary pull-right addToOrders">PURCHASE</button>
				</div>
			</div>
        </div>
	</div> <!-- panel content -->
        
	</div>
	</div>
</section>


<script src="js/jquery-1.11.1.min.js"></script>
<script src="js/jquery-migrate-1.2.1.min.js"></script>
<script src="js/jquery-ui-1.10.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/jquery.sparkline.min.js"></script>
<script src="js/toggles.min.js"></script>
<script src="js/retina.min.js"></script>
<script src="js/jquery.cookies.js"></script>

<script src="js/morris.min.js"></script>
<script src="js/raphael-2.1.0.min.js"></script>

<script src="js/custom.js"></script>
<script src="js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="js/cart.js"></script>
<script src="js/moment.js"></script>

<script>
simpleCart.empty();
simpleCart.currency({
    code: "PHP" ,
    name: "Philippine Peso" ,
    symbol: "PHP ",
    delimiter: ",", 
    decimal: ".", 
    after: false,
    accuracy: 2
});

simpleCart({
    cartColumns: [
    	{ attr: "id" , label: "ID" },
        { attr: "name", label: "Name"},
        { view: "currency", attr: "price", label: "Price"},
        { view: "decrement", label: false},
        { attr: "quantity", label: "Qty"},
        { view: "increment", label: false},
        { view: "currency", attr: "total", label: "SubTotal" },
        { view: "remove", text: "Cancel Order", label: false}
    ]
});

</script>
    <script>
    $(".addToOrders").click(function(){
    	
    
    	swal({
  		  title: "Are you sure you want to add order/s?",
  		  text: "The orders will be added.",
  		  type: "warning",
  		  showCancelButton: true,
  		  confirmButtonColor: '#dd6855',
  		  confirmButtonText: 'Yes',
  		  cancelButtonText: 'No',
  		  closeOnConfirm: false,
  		  closeOnCancel: false,
  		  
  		}, function(isConfirm){
  			if(isConfirm){
  		    	
  		    	var area_id = localStorage.getItem("area_id");
  		    	var accountId = "";
  		    	var now = moment.unix(moment()).utc();
  		    	var subtotal = $(".simpleCart_total").text().replace("PHP ", "");
  		    	var total_cost = $(".simpleCart_grandTotal").text().replace("PHP ", "");
  		    	var order_number = now._i;
  		    	
  		    	var orderDetails = {
  		    		order_number: order_number,
  		    		subtotal: subtotal, 
  		    		total_cost: total_cost,
  		    		currency: 'PHP',
  		    		area_id: area_id
  		    	}
  		    	
  		        $.ajax({
  		            
  		            url: "addOrders",
  		            type: "POST",
  		            data: orderDetails,
  		            cache: false,
  		            success: function (order_id) {
  		            	
  		                $(".itemRow").each(function(){
  		                    var dish_id = $(this).find(".item-id").text();
  		                    var dish_name = $(this).find(".item-name").text();
  		                    var dish_price = $(this).find(".item-price").text().replace("PHP ", "");
  		                    var dish_quantity = $(this).find(".item-quantity").text();
  		                    var dish_total_price = $(this).find(".item-total").text().replace("PHP ", "");
  		                    
  		                    var orderItems = {
  		                    	dish_id: dish_id,
  		                    	dish_name: dish_name,
  		                    	dish_price: dish_price,
  		                    	dish_quantity: dish_quantity,
  		                    	dish_total_price: dish_total_price,
  		                    	order_id: order_id
  		                    }

  		                    $.ajax({
  		                        url: "addOrderItems",
  		                        type: "POST",
  		                        data: orderItems,
  		                        cache: false,
  		                        success: function (data) {
  		                        }
  		                    }).then(function(){
  		                    	var pathArray = window.location.pathname.split( '/' );
  		                    	pathArray[pathArray.length-1] = "POS.jsp";
  		                    	swal("Order Saved!");
  		                    	setTimeout(function(){
  		                    		window.location = pathArray.join('/');
  		                    	},1000);
  		                    });            

  		                });
  		            	
  		            }
  		        });
  			}
			else{
  				swal("Cancelled", "", "error");
  			}
  		});
    });
		
		function getDishes(category_id)
		{
			$.ajax({
				type:'GET',
				data:{
			    	category_id: category_id
				},
				url:'GetDishes',
				
				success: function(data) {
					//console.log(data);
				    $("#dishes").html(data);
				}
			});
		}
		
		

    </script>

</body>
</html>
