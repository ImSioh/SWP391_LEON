<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.*" %>
<%@page import="controllers.*" %>
<%@page import="dto.*" %>
<%@page import="java.util.*" %>
<% String path =request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
    <!--header chung--> 

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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" 
              rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" 
              crossorigin="anonymous" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <link href="<c:url value="/assets/css/css-main.css"/>" rel="stylesheet" type="text/css"/>
        <link rel="icon" href="<c:url value="/assets/img/leon-icon.png"/>">
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
                margin: 10px 18px 20px 18px;
            }

            #header-notification {
                width: 440px;
                max-width: 40vw;
                max-height: 50vh;
                overflow-y: scroll;
                padding: 0.25rem;
            }

            #header-notification * {
                margin: 0;
            }

            #header-notification::-webkit-scrollbar {
                width: 8px;
                padding: 0 4px;
            }

            #header-notification::-webkit-scrollbar-thumb {
                background-color: #ddd;
                border-radius: 4px;
            }

            #header-notification::-webkit-scrollbar-thumb:hover {
                background-color: #bbb;
            }

            #header-notification::-webkit-scrollbar-track {
                background-color: white;
                border-top-right-radius: 4px;
                border-bottom-right-radius: 4px;
            }

            #header-notification > * {
                cursor: pointer;
            }

            #header-notification > a {
                text-decoration: none;
            }

            #header-notification .dropdown-item {
                white-space: normal;
                align-items: center;
                gap: 1rem;
                padding: 0.5rem 1rem;
                border-radius: 4px;
            }

            .header-noti-info {
                width: 100%;
            }

            .header-noti-thumbnail {
                width: 64px;
                height: 64px;
                border-radius: 50%;
                overflow: hidden;
            }

            .header-noti-thumbnail > div {
                width: 100%;
                height: 0;
                padding-top: 100%;
                background-position: center;
                background-size: cover;
            }

            .header-noti-title {
                font-weight: 500;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: pre;
            }

            .header-noti-content {
                font-size: 1rem;
                overflow: hidden;
                text-overflow: ellipsis;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                line-clamp: 2;
                -webkit-box-orient: vertical;
                white-space: pre-wrap;
            }

            .header-noti-time {
                user-select: none;
                font-size: 0.85rem;
                opacity: 0.5;
            }
        </style>
        <script defer>
            const wsUrl = location.origin.replace('http', 'ws') + '<c:url value="/wsendpoint"/>'
            window.generalWS = (function () {
                const listener = {}
                console.log(listener);
                return {
                    init: () => {
                        const socket = new WebSocket(wsUrl)
                        socket.addEventListener('message', e => {
                            const data = JSON.parse(e.data)
                            const listenerArr = listener[data.type]
                            if (listenerArr) {
                                listenerArr.forEach(l => l(data.data))
                            }
                        })
                    },
                    on: (type, cb) => {
                        const listenerArr = listener[type]
                        if (listenerArr) {
                            listenerArr.push(cb)
                        } else {
                            listener[type] = [cb]
                        }
                    },
                    off: (type, cb) => {
                        const listenerArr = listener[type]
                        if (listenerArr) {
                            const index = listenerArr.indexOf(cb)
                            if (index > -1) {
                                listenerArr.splice(index, 1)
                            }
                        }
                    }
                }
            })()
        </script>
    </head>

    <body>
        <div class="main">
            <div id="header" class="fixed-top" style="top: 0;">
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-light ${account.getRole() == 1 ? "bg-info" : "bg-light"}"">
                    <!-- Container wrapper -->
                    <div class="container-fluid">
                        <!-- Toggle button -->
                        <button class="navbar-toggler" type="button" data-mdb-toggle="collapse" data-mdb-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <i class="fas fa-bars"></i>
                        </button>

                        <!-- Collapsible wrapper -->
                        <div class="collapse navbar-collapse " id="navbarSupportedContent">
                            <!-- Navbar brand -->


                            <c:choose>
                                <c:when test="${account.getRole() == 1 }">
                                    <a href="<c:url value="/teacher/class"/>" class="navbar-brand mt-2 mt-lg-0 text-light">LE.ON - Teacher </a>
                                </c:when>    
                                <c:otherwise>
                                    <a href="<c:url value="/student/overview"/>" class="navbar-brand mt-2 mt-lg-0">LE.ON -Student </a>
                                </c:otherwise>
                            </c:choose>



                            <!-- Collapsible wrapper -->

                            <!-- Left links -->
                            <c:choose>
                                <c:when test="${account.getRole() == 1 }">
                                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0">

                                        <li class="nav-item">
                                            <a class="nav-link" href="<%=path%>/teacher/class" style="color: #E0F7FA; font-size: 15px; font-weight: 600;">Class</a>
                                        </li>
                                    </ul>
                                </c:when>    
                                <c:otherwise>
                                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0 ">
                                        <li class="nav-item navbariteam">
                                            <c:if test="${hglO}">
                                                <a class="nav-link " href="<%=path%>/student/overview" style="color:#1e88e5 !important; font-size: 15px; font-weight: 600; ">Overview</a>
                                            </c:if>
                                            <c:if test="${!hglO}">
                                                <a class="nav-link " href="<%=path%>/student/overview" style=" font-size: 15px; font-weight: 600;">Overview</a>
                                            </c:if>
                                        </li>
                                        <li class="nav-item navbariteam">
                                            <c:if test="${hglV}">
                                                
                                                <a class="nav-link" href="<%=path%>/student/class" style="color:#1e88e5 !important; font-size: 15px; font-weight: 600;">Class</a>
                                            </c:if>
                                            <c:if test="${!hglV}">
                                                <a class="nav-link" href="<%=path%>/student/class" style=" font-size: 15px; font-weight: 600;">Class</a>
                                            </c:if>
                                        </li>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <!--Right elements--> 
                        <div class="d-flex align-items-center">


                            <!--Notifications--> 
                            <div class="dropdown" style="margin-right: 15px;">
                                <a class="text-reset me-3 dropdown-toggle hidden-arrow" href="#" id="navbarDropdownMenuLink" role="button" data-mdb-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-bell" style="font-size: 22px; text-decoration: none; color: ${account.getRole() == 1 ? "white" : "black"}"; margin-left: 14px;"></i>
                                    <span class="badge rounded-pill badge-notification bg-danger"></span>
                                </a>
                                <ul id="header-notification" class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuAvatar"></ul>
                            </div>
                            <!--Avatar--> 
                            <div class="dropdown">
                                <span class="dropdown-toggle d-flex align-items-center hidden-arrow" href="#" id="navbarDropdownMenuAvatar" role="button" data-mdb-toggle="dropdown" aria-expanded="false" style="text-decoration: none;">
                                    <i class="far fa-user-circle" style="font-size: 24px; text-decoration: none; color: ${account.getRole() == 1 ? "white" : "black"}"; margin-left: 10px;"></i>
                                </span>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuAvatar">
                                    <a href="<c:url value="/${account.getRole() == 1 ? 'teacher' : 'student'}/profile"/>" style="font-size: 16px;text-decoration: none">
                                        <div class="d-flex bd-highlight dropdown-item">
                                            <span class="p-2 flex-shrink-1 bd-highlight">
                                                <i class="far fa-user"></i>
                                            </span>
                                            <span class="p-2 w-100 bd-highlight" style="color: #6e6e6e;">
                                                Profile
                                            </span>
                                        </div>
                                    </a>

                                    <a href="<c:url value="/${account.getRole() == 1 ? 'teacher' : 'student'}/sendfeedback"/>" style="font-size: 16px;text-decoration: none">
                                        <div class="d-flex bd-highlight dropdown-item">
                                            <span class="p-2 flex-shrink-1 bd-highlight">
                                                <i class="far fa-paper-plane"></i>
                                            </span>
                                            <span class="p-2 w-100 bd-highlight" style="color: #6e6e6e;">
                                                Send feedback
                                            </span>
                                        </div>
                                    </a>

                                    <a href="<c:url value="/logout"/>" style="font-size: 16px;text-decoration: none">
                                        <div class="d-flex bd-highlight dropdown-item">
                                            <span class="p-2 flex-shrink-1 bd-highlight">
                                                <i class="fas fa-sign-out-alt"></i>
                                            </span>
                                            <span class="p-2 w-100 bd-highlight" style="color: #6e6e6e;">
                                                Log Out
                                            </span>
                                        </div>
                                    </a>
                                </ul>
                            </div>
                        </div>
                        <!--Right elements--> 
                    </div>
                    <!-- Container wrapper -->
                </nav>
                <!-- Navbar -->
            </div>
            <script>
                function insertNotificationHeader(n) {
                    if (n.accountId === '${account.accountId}') return
                    const nList = document.getElementById('header-notification')
                    const divWrap = document.createElement('div')
                    divWrap.classList.add('d-flex', 'dropdown-item')

                    const divInfo = document.createElement('div')
                    divInfo.classList.add('header-noti-info')
                    divWrap.append(divInfo)

                    const pTitle = document.createElement('p')
                    pTitle.classList.add('header-noti-title')
                    pTitle.textContent = n.title
                    divInfo.append(pTitle)

                    const pContent = document.createElement('p')
                    pContent.classList.add('header-noti-content')
                    pContent.textContent = n.content
                    divInfo.append(pContent)

                    const pTime = document.createElement('p')
                    pTime.classList.add('header-noti-time')
                    pTime.textContent = n.createTime
                    divInfo.append(pTime)

                    if (n.redirectUrl) {
                        const anchorWrap = document.createElement('a')
                        if (n.redirectUrl.startsWith('/class')) {
                            n.redirectUrl = '${account.role == 1 ? "/teacher" : "/student"}' + n.redirectUrl
                        }
                        anchorWrap.href = '${pageContext.request.contextPath}' + n.redirectUrl
                        nList.insertBefore(anchorWrap, nList.children[0])
                        anchorWrap.append(divWrap)
                    } else {
                        nList.insertBefore(divWrap, nList.children[0])
                    }
                }
                generalWS.on('init-notification', notifications => {
                    notifications.forEach(n => insertNotificationHeader(n))
                })
                generalWS.on('notification', insertNotificationHeader)
            </script>

