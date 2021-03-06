<%-- 
    Document   : admin-item-order
    Created on : Mar 25, 2015, 10:15:08 AM
    Author     : Theresa
--%>

<%@page import="jspBeans.Order"%>
<%@page import="Model.Model"%>
<%@page import="jspBeans.Organization"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspBeans.Item"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="utf-8">
      <title>Admin | View Item Order</title>
      <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
      <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="">
      <meta name="author" content="">

    <!-- Le styles -->
      <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">
      </script>
      <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js">
      </script>

      <link href="http://fonts.googleapis.com/css?family=Roboto:400,300,700" rel="stylesheet" type="text/css">
      <link href="css/bootplus.css" rel="stylesheet">
      <style type="text/css">
      body {
       
        padding-bottom: 40px;
      }
      .hero-unit {
          padding: 60px;
      }
      @media (max-width: 980px) {
        /* Enable use of floated navbar text */
        .navbar-text.pull-right {
          float: none;
          padding-left: 5px;
          padding-right: 5px;
        }
      }
      </style>
      <link href="css/bootplus-responsive.css" rel="stylesheet">
      <link rel="stylesheet" type="text/css" href="styles.css">
      <link rel="stylesheet" type="text/css" href="css/footer_style.css">

 </head>
 <body>
     
       
<%
  String orgName = null;
  ArrayList<Order> listOrders = new ArrayList();
  session = request.getSession();
  Organization org = (Organization) session.getAttribute("admin");
  String itemDisplay = request.getParameter("item");
  Item item = Model.getItem(Integer.valueOf(itemDisplay));
  if (org == null)
      response.sendRedirect("login.jsp");
  else
  {
    orgName = org.getOrg_name();
    listOrders = Model.getAllOrgOrders(itemDisplay);
  }
%>
  
      <nav class="navbar navbar-custom">
                <div class="container-fluid">
                  <div class="dropdown navbar-header">
                    <button class="menu-button dropdown-toggle" type="button" id="categories" data-toggle="dropdown" aria-expanded="true"><span class="glyphicon glyphicon-align-justify"></button>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="categories">
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="admin.jsp">Admin Dashboard</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="#contact">Contact Us</a></li>
                      <li role="presentation"><a role="menuitem" tabindex="-1" href="#settings">Settings</a></li>
                    </ul>
                  </div>
                  <div class="navbar-header">
                      <a class="navbar-link navbar-brand" href="admin.jsp">Onboard</a>
                  </div>
                  <div>
                    
                    
                    <!-- <input type="text" class="navbar-search navbar-searchbar" placeholder="Search">
                     <button type="button" class="navbar-search navbar-searchbutton"><span class="glyphicon glyphicon-search"></span></button> -->
                    <ul class="navbar-right">
                      <li><a class="navbar-acct" href="admin-orders-view.jsp"><span class="glyphicon glyphicon-user navbar-acct"></span> <%=orgName%> </a></li>
                      <li><a class="navbar-acct" href="logout"><span class="glyphicon glyphicon-off navbar-acct"></span>Log Out</a></li>
                    </ul>
                  </div>
                </div>
            </nav>

   <div class="container-fluid">

      <div class="row-fluid">
        
        <div class="span3">
             <div class="sidebar-nav">
               <ul class="nav nav-list">
                 <li><h3>ADMINISTRATOR PANEL</h3></li>
                 <li class="nav-header">PROJECTS</li>
                 <li><a href="post-item.jsp"> Create New</a></li>
                 <li><a href="admin-orders-view.jsp"> View All</a></li>
                 <li class="nav-header">Members</li>
                 <li><a href="access.jsp"> Manage Access</a></li>
                 <li class="nav-header">NOTIFICATIONS</li>
                 <li><a href="inbox.jsp">Inbox <span class="badge">0</span></a></li>
               </ul>
             </div><!--/.well -->
           </div><!--/span-->

            <div class="span9">
              <div class= "row" style="margin-left: 0 px; margin-right: 0px;">
                  <div class="hero-unit">
                    <h2>FROM ORDERS - <%=item.getItem_name()%></h2>
                    <hr>
                                <% if (listOrders.size() == 0) {%>  
                                <p>No orders for this item yet.</p>
                                <% } else {%>
                                  <div class="panel panel-default">
                            	  <div class="panel-heading">
                            	  <form action = "updateOrders" method = "post">
                            	  STATUS: 
                              	  <li style="margin-right: 30px;margin-left: 30px;"><input type="radio" style="margin-right: 10px; margin-top:0;" name = "option" value = "process" class="toggle radio-status">PROCESSING</li>
                              	  <input type="hidden" name="item_id" value="<%=itemDisplay%>"> 
                                  <li> <input type="radio" style="margin-right: 10px; margin-top:0;" name = "option" value = "claim" class="toggle radio-status">CLAIMING</li>
                                  <li style="margin-right: 30px;margin-left: 30px;"><button type = "submit">UPDATE</button></li>
                                  </form>
                                  </div>
                            	  <div class="pagecontent">
                                  <div class="row" style="margin-right:0px; padding-left:30px;">
                                      <table class="table-bordered table-revieworders">
                                        <thead>
                                          <tr>
                                            <td class="col-sm-2">Qty</td>
                                            <td class="col-sm-4">Item</td>
                                            <td class="col-sm-4">Customer Name</td>
                                            <td class="col-sm-3">Contact</td>
                                            <td class="col-sm-2">Remarks</td>
                                          </tr>
                                        </thead>
                                        <tbody>
                                            <%for (int i = 0; i < listOrders.size(); i++) {%> 
                                          <tr>
                                            <td><%=listOrders.get(i).getOrderQty()%></td>
                                            <td><%=listOrders.get(i).getItem().getItem_name()%></td>
                                            <td><%=listOrders.get(i).getUser().getFullName()%></td>
                                            <td class="col-sm-3"><%=listOrders.get(i).getContactno()%></td>
                                            <td>
                                            <% if (listOrders.get(i).getStatus().equals("Pending")) {%>
                                            	<form name="confirmPending" method="POST" action="confirmPending">
    											<input type="hidden" name="order_id" value="<%=listOrders.get(i).getOrderID()%>">
    											<a href="#" onclick="$(this).closest('form').submit()">Confirm</a>
    											</form>						
    											<form name="deletePending" method="POST" action="deletePending">
    											<input type="hidden" name="order_id" value="<%=listOrders.get(i).getOrderID()%>">
    											<a href="#" onclick="$(this).closest('form').submit()">Cancel</a>
												</form>
											<% }
                                             	else if (listOrders.get(i).getStatus().equals("Claiming")){%>
												<form name="confirmClaiming" method="POST" action="claimItem">
    											<input type="hidden" name="order_id" value="<%=listOrders.get(i).getOrderID()%>">
    											<a href="#" onclick="$(this).closest('form').submit()">Claimed!</a>
    											</form>						
    											<!--  <form name="deletePending" method="POST" action="deletePending">
    											<input type="hidden" name="order_id" value="<%=listOrders.get(i).getOrderID()%>">
    											<a href="#" onclick="$(this).closest('form').submit()">Cancel</a>
												</form>-->
											<% } 
												else {%>
												<%=listOrders.get(i).getStatus() %>
											<% } %>	
											</td>
												
                                          </tr>
                                          <% } %>
                                        </tbody>
                                      </table>
                                </div>
                                <% } %>
                            </div>
                    </div>
                      <h6><a style="color:orange"href="admin-orders-view.jsp">BACK TO ORDERS</a></h6>
                  </div>
            </div>
          </div><!--/span-->

          </div><!--/row-->
          <hr>
      </div><!--/.fluid-container-->

    <div id="footer">
      <div class="wrap">
        <p></p>
      </div>
    </div>


    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap-transition.js"></script>
    <script src="js/bootstrap-alert.js"></script>
    <script src="js/bootstrap-modal.js"></script>
    <script src="js/bootstrap-dropdown.js"></script>
    <script src="js/bootstrap-scrollspy.js"></script>
    <script src="js/bootstrap-tab.js"></script>
    <script src="js/bootstrap-tooltip.js"></script>
    <script src="js/bootstrap-popover.js"></script>
    <script src="js/bootstrap-button.js"></script>
    <script src="js/bootstrap-collapse.js"></script>
    <script src="js/bootstrap-carousel.js"></script>
    <script src="js/bootstrap-typeahead.js"></script>


 </body>
</html>
