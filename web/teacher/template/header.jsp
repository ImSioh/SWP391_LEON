<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*" %>
<%@page import="controllers.*" %>
<%@page import="dto.*" %>
<%@page import="java.util.ArrayList" %>
<% String path =request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="<c:url value="/assets/css/styles.css"/>" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.1.0/mdb.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
        <!--Bootstrap 5-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
              crossorigin="anonymous" />
        <!--Jquery-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js" integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!--Jquery validate-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        
        <title>LE.ON</title>
        
        <style>
            body {
                min-height: 100vh;
            }
            .sidebarnav a {
                text-transform: unset !important;
                font-size: 1rem !important; 
                
            }
            
            .sidebarnav a.active{
                color: #1e88e5 !important;
                background-color: #e3f2fd !important;
                border-radius: 8px !important;
            }
            .content-main{
                width: 100%;
                display: flex;
                margin-bottom: 20px;
                flex-wrap: wrap;
            }
            .class-content{
                width: calc((100% - 220px)/6);
                border: 1px solid saddlebrown;
                margin: 10px 18px 120px 18px;
            }
        </style>
        
       
    </head>

    <body>
        <div class="main">
            <div id="header" class="fixed-top" style="top: 0;">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-light bg-primary"> <!-- change color 'bg-secondary -->
                    <!-- Container wrapper -->
                    <div class="container-fluid">
                        <!-- Toggle button -->
                        <button class="navbar-toggler" type="button" data-mdb-toggle="collapse" data-mdb-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <i class="fas fa-bars"></i>
                        </button>

                        <!-- Collapsible wrapper -->
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <!-- Navbar brand -->
                            
                            <a href="../teacher/ClassT.jsp" class="navbar-brand mt-2 mt-lg-0">LE.ON - Teacher</a>

                            <!-- Left links -->
                            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                                
                                <li class="nav-item">
                                    <a class="nav-link btn-secondary" href="ClassT.jsp" style="color: #E0F7FA; font-size: 15px;">Class</a>
                                </li>
                            </ul>
                            <!-- Left links -->
                        </div>
                        <!-- Collapsible wrapper -->

                        <!-- Right elements -->
                        <div class="d-flex align-items-center">


                            <!-- Notifications -->
                            <div class="dropdown">
                                <a class="text-reset me-3 dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLink" role="button" data-mdb-toggle="dropdown" aria-expanded="false">
                                    <i class="far fa-bell" style="font-size: 24px; "></i>
                                    <span class="badge rounded-pill badge-notification bg-danger">5</span>
                                </a>

                            </div>
                            <!-- Avatar -->
                            <div class="dropdown">
                                <a class="dropdown-toggle d-flex align-items-center hidden-arrow" href="#" id="navbarDropdownMenuAvatar" role="button" data-mdb-toggle="dropdown" aria-expanded="false">
                                    <i class="far fa-user-circle" style="font-size: 24px; text-decoration: none; color: black; margin-left: 10px;"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuAvatar">
                                    <div class="d-flex bd-highlight dropdown-item">
                                        <li class="p-2 flex-shrink-1 bd-highlight">
                                            <i class="far fa-user"></i>
                                        </li>
                                        <li class="p-2 w-100 bd-highlight">
                                            <a href="<c:url value="/profile"/>" style="color: #6e6e6e; font-size: 16px;text-decoration: none">Profile</a>
                                        </li>
                                    </div>

                                    <div class="d-flex bd-highlight dropdown-item">
                                        <li class="p-2 flex-shrink-1 bd-highlight">
                                            <i class="far fa-paper-plane"></i>
                                        </li>
                                        <li class="p-2 w-100 bd-highlight">
                                            <a href="<c:url value="/logout"/>" style="color: #6e6e6e; font-size: 16px;text-decoration: none">Send feedback</a>
                                        </li>
                                    </div>

                                    <div class="d-flex bd-highlight dropdown-item">
                                        <li class="p-2 flex-shrink-1 bd-highlight">
                                            <i class="fas fa-sign-out-alt"></i>
                                        </li>
                                        <li class="p-2 w-100 bd-highlight">
                                            <a href="<c:url value="/logout"/>" style="color: #6e6e6e; font-size: 16px;text-decoration: none">Log Out</a>
                                        </li>
                                    </div>

                                </ul>
                            </div>
                        </div>
                        <!-- Right elements -->
                    </div>
                    <!-- Container wrapper -->
                </nav>
                <!-- Navbar -->
            </div>
       