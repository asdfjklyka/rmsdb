<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>


<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="images/ribrage.png" type="image/png">

    <title>Customer | RMS</title>

    <link rel="stylesheet" href="css/style.default.css" />

    <link rel="stylesheet" href="css/bootstrap-timepicker.min.css" />
    <link rel="stylesheet" href="css/jquery.tagsinput.css" />
    <link rel="stylesheet" href="css/colorpicker.css" />
    <link rel="stylesheet" href="css/dropzone.css" />
    <!--dynamic table-->
	<link href="js/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- Custom styles for this template -->

</head>

<body style="background: #040404;">
    <div id="preloader">
        <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
    </div>
    <!--sidebar end-->
    <!--main content start-->
    
    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                           url="jdbc:mysql://localhost/rmsdb"
                           user="root"  password=""/>
    
    
    <sql:query dataSource="${db}" var="area">
           SELECT * FROM rms_area;
        </sql:query>
    
    <section>

        <div class="leftpanel">

            <div class="logopanel" style="background: #040404">
                <h4><img src="images/ribrage.png" style="width: 90px; height: 80px;" alt="">
                    <span style="font-color:#1caf9a">RibRage Diner</span></h4>
            </div>
            <!-- logopanel -->

            <div class="leftpanelinner">

                <!-- This is only visible to small devices -->
                <div class="visible-xs hidden-sm hidden-md hidden-lg">
                    <div class="media userlogged">
                        <img alt="" src="images/photos/loggeduser.png" class="media-object">
                        <div class="media-body">
                            <h4></h4>
                        </div>
                    </div>
                </div>

                <ul class="nav nav-pills nav-stacked nav-bracket">
                    <li class=""><a href="Home.jsp"><i class="fa fa-home"></i> <span>Dashboard</span></a></li>
                    <li class="active"><a href="System_setup.jsp"><i class="fa fa-home"></i> <span>System Setup</span></a></li>
                    <li class=""><a href="Inventory.jsp"><i class="fa fa-home"></i> <span>Inventory</span></a></li>
                    <li class=""><a href="Requisition.jsp"><i class="fa fa-home"></i> <span>Requisition</span></a></li>
                    <li class=""><a href="Account_setting.jsp"><i class="fa fa-home"></i> <span>Account setting</span></a></li>
                </ul>
            </div>
            <!-- leftpanelinner -->
        </div>
        <!-- leftpanel -->
        <div class="mainpanel">

            <div class="headerbar">
                <div class="header-right">
                    <ul class="headermenu">
                        <li>
                            <div class="btn-group">
                                <button class="btn btn-default dropdown-toggle tp-icon" data-toggle="dropdown">
                <i class="glyphicon glyphicon-bell"></i>
                <span class="badge">5</span>
              </button>

                            </div>
                        </li>
                        <li>
                            <div class="btn-group">
                                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="color: black">
                <img src="images/photos/loggeduser.png" alt="" />
                John Doe
              </button>
                            </div>
                        </li>

                    </ul>
                </div>
            </div>
           
            <div class="contentpanel" id="table">
                <section class="panel">
                    <header class="panel-heading">
                        <h2 class="panel-title">Available Area</h2>
                    </header>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <section class="panel">
                                    <div class="panel-body">
                                        <div class="adv-table">
                                            <table class="display table table-bordered table-striped" id="dynamic-table">
                                                <thead>
                                                    <tr>
                                                        <th>Area</th>
                                                        <th>Description</th>
                                                        <th>Status</th>
                                                        <th>Time In</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="table" >
                                                <c:set var="count" value="0" scope="page" />
                                                  	<c:forEach var="row" items="${area.rows}" >
														
															<tr>
									                        <td><c:out value="${row.Area_Name}"/></td>
										                      <td><c:out value="${row.area_desc}"/></td>
										                      <td id="area-status-${count}"><c:out value="${row.area_status}"/></td>
										                    <td><c:out value="${row.reserved_at}"/></td>  
					                                     
					                                     	<td style="display: flex">
					                                     	<input type="hidden" id="area-${count}" value="${row.area_id}">
					                                     	<c:if test="${row.area_status == 'Available'}">
					                                     		<a class="btn btn-warning" id="available-${count}" style="width:48px; margin-left: 1%" data-toggle="modal" data-target=".bs-example-modal-lg-3" onclick="setIndex(${count});"><i class="fa fa-glass"></i></a>					                                     	
						                                     	<a class="btn btn-success"  id="order-${count}" style="width:48px; display:none;  margin-left: 1%" href="category.jsp" onclick="saveToLocalStorage(${row.area_id})"><i class="fa fa-plus"  ></i></a>
						            							<a class="btn btn-default" id="billout-${count}" style="width:48px; display:none; margin-left: 1%" target="_blank" href="official_receipt.jsp" onclick="saveToLocalStorage(${row.area_id})"><i class="fa fa-usd"></i></a>
						            							<a class="btn btn-black" id="cancel-${count}"  style="width:48px; display:none; margin-left: 1%" onclick="customerOut(${count});"><i class="fa fa-times"></i></a>
						            							<a class="btn btn-info" id="paid-${count}"  style="width:48px; display:none; margin-left: 1%" onclick="paid(${count});"><i class="fa fa-undo"></i></a> 
					                                     	</c:if>
					                                     	<c:if test="${row.area_status == 'Unavailable'}">
					                                     		<a class="btn btn-warning" id="available-${count}" style="width:48px; display:none" data-toggle="modal" data-target=".bs-example-modal-lg-3" onclick="setIndex(${count});"><i class="fa fa-glass"></i></a>					                                     	
						                                     	<a class="btn btn-success"  id="order-${count}" style="width:48px; margin-left: 1%" href="category.jsp" onclick="saveToLocalStorage(${row.area_id})"><i class="fa fa-plus"  ></i></a>
						            							<a class="btn btn-default" id="billout-${count}" style="width:48px; display:none; margin-left: 1%" target="_blank" href="official_receipt.jsp" onclick="saveToLocalStorage(${row.area_id})"><i class="fa fa-usd"></i></a>
						            							<a class="btn btn-info" id="cancel-${count}"  style="width:48px; margin-left: 1%" onclick="customerOut(${count});"><i class="fa fa-undo"></i></a>
						            							<a class="btn btn-black" id="paid-${count}"  style="width:48px; display:none; margin-left: 1%" onclick="paid(${count});"><i class="fa fa-times"></i></a> 
					                                     	</c:if>
					                                     	</td> 
									                   </tr>
									                   <c:set var="count" value="${count + 1 }" scope="page" />
													</c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </section>

  
    <form method="post" id="form-data">
        <div class="modal fade bs-example-modal-lg-3" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="margin-top: 10%">
            <div class="modal-dialog modal-lg">
                <div class="modal-content" id="sad">
                    <div class="modal-header" style="background-color: #941822">
                        <button aria-hidden="true" data-dismiss="modal" class="close fa fa-times" type="button" style="color: white"></button>
                        <h4 class="modal-title" style="color: white">Customer Details</h4>
                    </div>
                    <div class="modal-body">
                        <div class="input-group">
                            <span class="input-group-addon"><i style="height: 57%"/></i></span>
                            <input type="number" class="form-control" placeholder="Guest Count" name="guestcount" id="guestcount" />
                        </div><br/>
                         <div class="input-group">
                            <span class="input-group-addon"><i class=""><img src="" alt=""  style="height: 57%"/></i></span>
                            <input type="text" class="form-control" placeholder="Remarks" name="remarks" id="remarks" />
                        </div><br/>
                        <div>
                            <button class="btn btn-primary pull-right" id="submit" type="button" data-dismiss="modal">Add Customer</button></div><br><br>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/jquery-migrate-1.2.1.min.js"></script>
    <script src="js/jquery-ui-1.10.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/modernizr.min.js"></script>
    <script src="js/jquery.sparkline.min.js"></script>
    <script src="js/toggles.min.js"></script>
    <script src="js/retina.min.js"></script>
    <script src="js/jquery.cookies.js"></script>

    <script src="js/jquery.autogrow-textarea.js"></script>
    <script src="js/bootstrap-timepicker.min.js"></script>
    <script src="js/jquery.maskedinput.min.js"></script>
    <script src="js/jquery.tagsinput.min.js"></script>
    <script src="js/jquery.mousewheel.js"></script>
    <script src="js/select2.min.js"></script>
    <script src="js/dropzone.min.js"></script>
    <script src="js/colorpicker.js"></script>

    <script src="js/custom.js"></script>
    <script src="js/select2.min.js"></script>
    <!--Validation-->
    <script src="js/jquery.validate.min.js"></script>
    <!--Tables-->
    <script src="js/jquery.datatables.min.js"></script>
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript">
    
    	
    
    	var idIndex = 0;
    	
    	
        function setIndex(id){
        	idIndex = id;
        }
        
        function saveToLocalStorage(area_id)
        {
        	localStorage.setItem("area_id", area_id);
        	
        	document.getElementById("order-"+idIndex).style.display = "block";
            document.getElementById("paid-"+idIndex).style.display = "block";
            document.getElementById("billout-"+idIndex).style.display = "block";
            document.getElementById("available-"+idIndex).style.display = "none";
            document.getElementById("cancel-"+idIndex).style.display = "none";
        	
        }
        
        function paid(id)
        {
        	swal({
      		  title: "Are you sure you want to terminate transaction?",
      		  text: "Make sure the bill has been paid first.",
      		  icon: "warning",
      		  buttons: true,
      		  dangerMode: true,
      		}, function(data){
      			if(data == true){
                  	idIndex = id;
                  	
  					  document.getElementById("order-"+idIndex).style.display = "none";
                      document.getElementById("billout-"+idIndex).style.display = "none";
                      document.getElementById("cancel-"+idIndex).style.display = "none";
                      document.getElementById("available-"+idIndex).style.display = "block";            
                   
  	          		var area_id = $("#area-"+idIndex).val();
  	          		
  	          		$.ajax({
  	          				type:'POST',
  	          				data:{
  	          					area_id: area_id
  	          					},
  	          				url:'Timeout',
  	          				success: function(data){
  	          					console.log(data);
  	                		    swal("Area is now available!", {
  	                  		      icon: "success",
  	                  		    });
  	                        setTimeout(function() 
  	                        {
  	                            window.location=window.location;
  	                        },500);
  	          				}
  	          			});

      				
      			}
      		});
        }
        
        function customerOut(id)
        {
        	swal({
      		  title: "Are you sure you want to cancel?",
      		  text: "Once cancel, area is available.",
      		  icon: "warning",
      		  buttons: true,
      		  dangerMode: true,
      		}, function(data){
      			if(data == true){
                  	idIndex = id;
                  	
  					  document.getElementById("order-"+idIndex).style.display = "none";
                      document.getElementById("billout-"+idIndex).style.display = "none";
                      document.getElementById("cancel-"+idIndex).style.display = "none";
                      document.getElementById("available-"+idIndex).style.display = "block";            
                   
  	          		var area_id = $("#area-"+idIndex).val();
  	          		
  	          		$.ajax({
  	          				type:'POST',
  	          				data:{
  	          					area_id: area_id
  	          					},
  	          				url:'Timeout',
  	          				success: function(data){
  	          					console.log(data);
  	                		    swal("Area is now available!", {
  	                  		      icon: "success",
  	                  		    });
  	                        setTimeout(function() 
  	                        {
  	                            window.location=window.location;
  	                        },500);
  	          				}
  	          			});

      				
      			}
      		});
        }
        
  /*     
        	
        	

        
        
        function customerOut(id)
        {

        	swal({
        		  title: "Are you sure?",
        		  text: "Once closed, area is available.",
        		  icon: "warning",
        		  buttons: true,
        		  dangerMode: true,
        		})
        		.then((data) => {
        			if(data == true){
                    	idIndex = id;
                    	
    					document.getElementById("order-"+idIndex).style.display = "none";
                        document.getElementById("billout-"+idIndex).style.display = "none";
                        document.getElementById("cancel-"+idIndex).style.display = "none";
                        document.getElementById("available-"+idIndex).style.display = "block";            
                     
    	          		var area_id = $("#area-"+idIndex).val();
    	          		
    	          		$.ajax({
    	          				type:'POST',
    	          				data:{
    	          					area_id: area_id
    	          					},
    	          				url:'Timeout',
    	          				success: function(data){
    	          					console.log(data);
    	                		    swal("Area is now available!", {
    	                  		      icon: "success",
    	                  		    });
    	                        setTimeout(function() 
    	                        {
    	                            window.location=window.location;
    	                        },1000);
    	          				}
    	          			});

        				
        				}
        			 else {
        		    	swal("Action can't be undone.");
        		  }
        		});
        	
        	
        	
        	
        	swal({
        		  title: "Are you sure?",
        		  text: "Once closed, area is available.",
        		  icon: "warning",
        		  buttons: true,
        		  dangerMode: true,
        		}, function(data){
        			if(data == true){
                    	idIndex = id;
                    	
    					document.getElementById("order-"+idIndex).style.display = "none";
                        document.getElementById("billout-"+idIndex).style.display = "none";
                        document.getElementById("cancel-"+idIndex).style.display = "none";
                        document.getElementById("available-"+idIndex).style.display = "block";            
                     
    	          		var area_id = $("#area-"+idIndex).val();
    	          		
    	          		$.ajax({
    	          				type:'POST',
    	          				data:{
    	          					area_id: area_id
    	          					},
    	          				url:'Timeout',
    	          				success: function(data){
    	          					console.log(data);
    	                		    swal("Area is now available!", {
    	                  		      icon: "success",
    	                  		    });
    	                        setTimeout(function() 
    	                        {
    	                            window.location=window.location;
    	                        },1000);
    	          				}
    	          			});

        				
        			}
        		});
        	
        
        }// end customerOut*/
        
        
        $("#submit").click(function(){
            document.getElementById("order-"+idIndex).style.display = "block";
            document.getElementById("cancel-"+idIndex).style.display = "block";
            document.getElementById("paid-"+idIndex).style.display = "none";
            document.getElementById("billout-"+idIndex).style.display = "none";
            document.getElementById("available-"+idIndex).style.display = "none";
            
            var guestcount = $("#guestcount").val();
    		var remarks = $("#remarks").val();
    		var area_id = $("#area-"+idIndex).val();
    		
    		console.log(area_id);

    		if (guestcount != "" &&  remarks != "") 
    	    {
    					$.ajax({
    						type:'POST',
    						data:{
    							guestcount: guestcount,
    							remarks: remarks,
    							area_id: area_id
    							},
    						url:'AddCustomer',
    						success: function(data){
    							console.log(data);
    							
    							$("#area-status-"+idIndex).html("Unavailable");
    							swal("Successfully Added!","", "success");
    							// 	alert(data2); 
    	                    setTimeout(function() 
    	                    {
    	                        window.location=window.location;
    	                    },1000);
    						}
    					});
    	    }
    		
            var guestcount = $("#guestcount").val("");
    		var remarks = $("#remarks").val("");
    		
    		
    	});	
    	
        
    	
    	
    	
    	
    	
        jQuery(document).ready(function() {

            "use strict";

            // Select2
            jQuery(".select2").select2({
                width: '100%',
                minimumResultsForSearch: -1
            });
            // Validation with select boxes

            // Date Picker
            jQuery('#datepicker').datepicker();


            jQuery('#datepicker-multiple').datepicker({
                numberOfMonths: 3,
                showButtonPanel: true
            });

        });
        
       

        
        
        
    </script>
</body>


</html>