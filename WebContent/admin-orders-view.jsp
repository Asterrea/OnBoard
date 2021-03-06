<%-- 
    Document   : admin-orders-view
    Created on : Mar 25, 2015, 10:08:55 AM
    Author     : Theresa
--%>

<%@page import="Model.Model"%>
<%@page import="jspBeans.Organization"%>
<%@page import="java.util.ArrayList"%>
<%@page import="jspBeans.Item"%>
<!DOCTYPE html>
<html lang="en">
<head>
	 <meta charset="utf-8">
      <title>Admin | View Orders </title>
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
  ArrayList<Item> listItems = new ArrayList();
  session = request.getSession();
  Organization org = (Organization) session.getAttribute("admin");
  if (org == null)
      response.sendRedirect("login.jsp");
  else
  {
    orgName = org.getOrg_name();
    listItems = Model.getAllItems(org.getOrg_id());
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
                      <h2>YOUR PROJECTS</h2>
                      <hr>
                       <div class="pagecontent">
                           <% if (listItems.size() == 0) {%>  
                           <p>You don't have any items!</p>
                           <% } else {%>
                          <div class="row" style="padding-left:30px; margin-right:0px;">
                            <table class="table-bordered table-revieworders">
                              <thead>
                                <tr>
                                  <td class="col-sm-1">Item Code</td>
                                  <td class="col-sm-1">Status</td>
                                  <td class="col-sm-2">Item Name</td>
                                  <td class="col-sm-1">Num. of Orders</td>
                                  <td class="col-sm-1">Remarks</td>
                                </tr>
                              </thead>
                              <tbody>
                                <%for (int i = 0; i < listItems.size(); i++) {%>  
                                <tr>
                                  <td><%=listItems.get(i).getItem_id()%></td>
                                  <td><%=listItems.get(i).getItem_details()%></td>
                                  <td><button class="btn btn-default btn-xs" data-toggle="modal" data-target="#open-msg" type="button"><%=listItems.get(i).getItem_name()%></button></td>
                                  <td><%=listItems.get(i).getTotalOrders()%></td>
                                  <td><a href="admin-item-order.jsp?item=<%=listItems.get(i).getItem_id()%>">Details</a></td>
                                </tr>
                                <% } %>
                              </tbody>
                            </table>

                            <div class="modal modal-alert-custom fade" id="open-msg" tabindex="-1" role="dialog" aria-labelledby="checkerLabel1" aria-hidden="true">
                              <div class="modal-dialog">
                                <div class="modal-content">
                                <div class="modal-header">
                                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"></span></button>
                                  <h4 class="modal-title" id="checkerLabel1">> HALLO ITEM NAME</h4>
                                </div>
                                <div class="modal-body">
                                  <p>// Conversation here</p>
                                  <textarea rows="5" cols="50"></textarea>
                                  <button type="button" class="btn btn-default" data-dismiss="modal">Reply</button>
                                </div>
                                <div class="modal-footer">
                                  <center>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                  </center>
                                </div>
                              </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                          </div><!-- /.modal -->
                          </div>
                          <% } %>
                        </div>
                        <h6><a style="color:orange"href="admin.jsp">BACK TO DASHBOARD</a></h6>
                    </div>
          </div>
        </div><!--/span-->

      </div><!--/row-->
      <hr>
    </div><!--/.fluid-container-->

    <div id="footer">
      <div class="wrap">
        <p>FOOTER</p>
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
