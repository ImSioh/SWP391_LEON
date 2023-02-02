
<%@include file= "./template/header.jsp" %>
<div class="Content">
    <div class="row" style="margin-top: 50px">
        <div class="p-2 col" style="margin: 10px 0px 10px 10px;">
            <form action="<%=path%>/student/search" method="post">
                <input style="border-radius: 34px !important; height: 56px" type="search" name="searchName" class="form-control rounded .col-md-4" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />    
            </form>
        </div>

        <div class="col-md-auto">
            <button type="button" style="border-radius: 34px; padding: 15px; margin: 15px;" class="btn btn-outline-secondary btn-rounded" data-mdb-ripple-color="dark"><a href="<%=path%>/student/join" style="text-decoration: none; color: grey;">+ Enter code</a></button>
        </div>
    </div>
</div>
<c:if test="${verified}">
    <div class="content-main">
        <c:forEach items="${co}" var="co">
            <div class="class-content" style="border-radius: 8px; overflow: hidden">
                <a href="<c:url value="/student/overview"/>" style="text-decoration: none;">             
                    <div style="overflow: hidden; width: 100%; height: 100%;height: 100px; background-size: cover;
                         background-position: center;
                         background-image: url(<c:url value="${co.getClassPicture() == null ? '/assets/img/Common_picture.png' : co.getClassPicture()}"/>)">
                    </div>                  
                    <div style="padding: 4px 8px; white-space: nowrap;overflow: hidden; text-overflow: ellipsis;">
                        ${co.getName()}<br>
                    </div>
                </a> 
            </div>  
        </c:forEach>
    </div>
</c:if>
<c:if test="${!verified}">
    <div style=" width: 100%; width: 250px;height: 100%;height: 200px; background-size: cover;
         margin: auto; background-image: url(<c:url value="/student/assets/img/10.png"/>)">
    </div>
    <div style="text-align: center;font-weight: 100;">Not found class - Input again</div>
</c:if>


<%@include file= "./template/footer.jsp" %>
