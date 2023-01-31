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
        <link href="../assets/css/style.css" rel="stylesheet" type="text/css"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.1.0/mdb.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min1.css" rel="stylesheet" >
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
              crossorigin="anonymous" />

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

        </style>


    </head>

    <body>
        <div class="main">
            <div id="header" class="fixed-top" style="top: 0;">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light">
                    <!-- Container wrapper -->
                    <div class="container-fluid">
                        <!-- Toggle button -->
                        <button class="navbar-toggler" type="button" data-mdb-toggle="collapse" data-mdb-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <i class="fas fa-bars"></i>
                        </button>

                        <!-- Collapsible wrapper -->
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <!-- Navbar brand -->

                            <a href="<%=path%>/overview-incomplete" class="navbar-brand mt-2 mt-lg-0">LE.ON - Student</a>


                        </div>
                        <!--Collapsible wrapper--> 

                        <!--Right elements--> 
                        <div class="d-flex align-items-center">


                            <!--Notifications--> 
                            <div class="dropdown">
                                <a class="text-reset me-3 dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLink" role="button" data-mdb-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-bell"></i>
                                    <span class="badge rounded-pill badge-notification bg-danger">1</span>
                                </a>

                            </div>
                            <!--Avatar--> 
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
                                            <a href="#" style="color: #6e6e6e; font-size: 16px;text-decoration: none">Send feedback</a>
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
                        <!--Right elements--> 
                    </div>
                    <!-- Container wrapper -->
                </nav>
                <!-- Navbar -->
            </div>

            <div class="content" style="margin-top: 50px;">
                <section style="background-color: rgb(209, 209, 209);" >
                    <div class="container py-5">
                        <div class="row">
                            <div class="col">
                                <nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
                                    <ol class="breadcrumb mb-0">
                                        <c:choose>
                                            <c:when test="${account.getRole() == 1 }">
                                                <li class="breadcrumb-item"><a href="<c:url value="/class"/>" style="text-decoration: none;">Home</a></li>
                                                </c:when>    
                                                <c:otherwise>
                                                <li class="breadcrumb-item"><a href="<c:url value="/overvew"/>" style="text-decoration: none;">Home</a></li>
                                            </c:otherwise>
                                        </c:choose>

                                        <li class="breadcrumb-item"><a href="<c:url value="/profile"/>" style="text-decoration: none;">User</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Change Password</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>

                        <div class="row d-flex flex-column align-items-center">

                            <div class="col-lg-9">
                                <div class="card mb-4 ">
                                    <div class="card-body ">
                                        <div class=" p-3 py-5 justify-content-center">

                                            <form action="#" method="post">
                                                <div class="">
                                                    <h4 class="text-left">Change Password</h4>
                                                </div>
                                                <div class="row mt-3 col-6">

                                                    <div class="input-group mb-3 " x-data="{ showPassword: false }">
                                                        <input x-bind:type="showPassword ? 'text' : 'password'" class="form-control" placeholder="Old password" aria-label="Old password" aria-describedby="basic-addon2">
                                                        <span class="input-group-text" x-on:click="showPassword = ! showPassword" id="basic-addon2"><i
                                                                class="fa"
                                                                x-bind:class="[showPassword ? 'fa-eye' : 'fa-eye-slash']"
                                                                aria-hidden="true"></i></span>
                                                    </div>
                                                    <div class="input-group mb-3" x-data="{ showPassword: false }">
                                                        <input x-bind:type="showPassword ? 'text' : 'password'" class="form-control" placeholder="New password" aria-label="New password" aria-describedby="basic-addon2">
                                                        <span class="input-group-text" x-on:click="showPassword = ! showPassword" id="basic-addon2"><i
                                                                class="fa"
                                                                x-bind:class="[showPassword ? 'fa-eye' : 'fa-eye-slash']"
                                                                aria-hidden="true"></i></span>
                                                    </div>

                                                    <div class="input-group mb-3" x-data="{ showPassword: false }">
                                                        <input x-bind:type="showPassword ? 'text' : 'password'" class="form-control" placeholder="Re-enter New password" aria-label="Re-enter New password" aria-describedby="basic-addon2">
                                                        <span class="input-group-text" x-on:click="showPassword = ! showPassword" id="basic-addon2"><i
                                                                class="fa"
                                                                x-bind:class="[showPassword ? 'fa-eye' : 'fa-eye-slash']"
                                                                aria-hidden="true"></i></span>
                                                    </div>
                                                </div>

                                                <div class="mt-4 text-center col-6">
                                                    <input class="btn btn-primary profile-button" type="submit" value="Change password">
                                                    </input>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <div class="footer">

            </div>
        </div>
        <!-- MDB -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.1.0/mdb.min.js"></script>
        <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
    </body>

</html>