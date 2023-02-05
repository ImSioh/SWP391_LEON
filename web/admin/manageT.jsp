<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file= "template/header.jsp" %>

<c:set scope="page" var="pageNumber" value="${param.page != null ? param.page : 1}"/>
<c:if test="${!(pageNumber >= 1 && pageNumber <= accountDAO.totalPage)}">
    <c:redirect url="${baseUrl}"/>
</c:if>

<div id="content">
    <h1>Teachers Management</h1>

    <!--Search-->
    <form action="<c:url value="/SearchAccount"/>" method="get" style="">
        <span class="button-action" style="display: flex;">
            <select name="optionSearch" class="form-select" style="width: 18%; height: 10%; margin: 0 10px 0 55%; text-align: center">
                <option value="name" ${optionSearch eq "name"?"selected":""}>Name</option>
                <option value="email" ${optionSearch eq "email"?"selected":""}>Email</option>
                <option value="phoneNumber" ${optionSearch eq "phoneNumber"?"selected":""}>PhoneNumber</option>
            </select>
            <input type="hidden" name="searchFor" value="1">
            <input type="text" value="${keyword}" name="keyword" id="" class="form-control" placeholder="Input something..." style="width: 45%; height: 10%; margin: 0"> 
            <input type="submit" value="SEARCH" id="search" class="btn-info" 
                   style="margin: 5px 0 5px 10px; width: 10%; height: 15%; border-radius: 0.25em!important; border: 1px solid #e3f2fd !important;">
        </span>
    </form>

    <!--Sort-->
    <form action="<c:url value="/"/>" method="get" style="margin-top: 10px;">
        <span class="button-action" style="display: flex;">
            <select name="optionSearch" class="form-select" style="width: 30%; height: 10%; margin: 0 0 0 55%; text-align: center">
                <option value="name" ${optionSearch eq "name"?"selected":""}>Name</option>
                <option value="email" ${optionSearch eq "email"?"selected":""}>Email</option>
                <option value="phoneNumber" ${optionSearch eq "phoneNumber"?"selected":""}>PhoneNumber</option>
            </select>
            <input type="hidden" name="sortBy" value="1">
            <!--<input type="text" value="${keyword}" name="keyword" id="" class="form-control" placeholder="Input something..." style="width: 45%; margin: 32px">--> 
            <input type="submit" value="SORT" id="sort" class="btn-info" 
                   style="margin: 5px 0 5px 15%; width: 10%; height: 15%; border-radius: 0.25em!important; border: 1px solid #e3f2fd !important;">
        </span>
    </form>

    <!--Show items-->
    <form action="<c:url value="${baseUrl}?page=${pageNumber}&element=${element}"/>" method="get" style="margin-top: 0;">
        <span class="button-action" style="display: flex;">
            Show 
            <select name="element" style="width: 5%; height: 5%; margin: 5px; text-align: center;
                    border: 3px solid #e3f2fd; border-radius: 0.25em;">
                <c:forEach items="${elementOption}" var="eO">
                    <c:if test="${eO == element}">
                        <option value="${eO}" selected>${eO}</option>
                    </c:if>
                    <c:if test="${eO != element}">
                        <option value="${eO}">${eO}</option>
                    </c:if>
                </c:forEach>
                <!--                <option value="2">2</option>
                                <option value="5">5</option>
                                <option value="10">10</option>
                                <option value="25">25</option>-->
            </select>
            entries
            <!--<input type="text" value="${keyword}" name="keyword" id="" class="form-control" placeholder="Input something..." style="width: 45%; margin: 32px">--> 
            <input type="submit" value="SHOW" id="show" class="btn-info" 
                   style="margin: 5px 5px; width: 5%; height: 5%; border-radius: 0.25em!important; border: 1px solid #e3f2fd !important;">
        </span>
    </form>

    <div class="table">
        <table class="table table-light table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>PhoneNumber</th>
                    <th>CreateTime</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="account" items="${accountDAO.getItemsInPage(pageNumber)}" >
                <%--<c:forEach var="account" items="${accountList}" >--%>
                    <tr>
                        <td>
                            <a href="">${account.getAccountId()}</a>
                        </td>
                        <td>${account.getName()}</td>
                        <td>${account.getEmail()}</td>
                        <td>${account.getAddress()}</td>
                        <td>${account.getPhoneNumber()}</td>
                        <td>${account.getCreateTime()}</td>
                        <c:if test="${account.isLocked()}">
                            <td><a href="#"><i class="fa-solid fa-lock"></i></a></td>
                                </c:if>
                                <c:if test="${account.isLocked()!=true}">
                            <td><a href="#"><i class="fa-solid fa-lock-open"></i></a></td>
                                </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
                 
    <c:url value="admin/teacher-account-list" var="baseUrl">

    </c:url>
    <c:import url="/template/pagination-bar.jsp">
        <c:param name="page" value="${pageNumber}"/>
        <c:param name="modelDAOName" value="accountDAO"/>
        <c:param name="basePath" value="/${baseUrl}"/>
    </c:import>

</div>

<%@include file="template/footer.jsp" %>
