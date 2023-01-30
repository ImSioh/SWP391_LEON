
<%@include file= "./template/header.jsp" %>
<div class="Content">
    <div class="row" style="margin-top: 50px">
        <div class="p-2 col" style="margin: 10px 0px 10px 10px;">        
            <input style="border-radius: 34px !important; height: 56px" type="search" class="form-control rounded .col-md-4" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />    
        </div>

        <div class="col-md-auto">
            <button type="button" style="border-radius: 34px; padding: 15px; margin: 15px;" class="btn btn-outline-secondary btn-rounded" data-mdb-ripple-color="dark"><a href="<%=path%>/join" style="text-decoration: none; color: grey ">+ Enter code</a></button>
        </div>
    </div>
</div>

<div class="content-main">
    <div class="class-content">
        
        <a href="<c:url value="/overview"/>">            
            <div style="overflow: hidden; width: 100%; height: 100%;height: 100px; background-size: cover;
                 background-position: center;background-image: url(student/assets/img/2165310.png)">               
            </div>            
            <div>
                <c:forEach items="${classObjList}" var="co">
                    ${co.getName()}<br>
                    ${co.getCode()}
                </c:forEach>
            </div>
        </a>               
    </div>  

</div>
</div>
<script
    type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.1.0/mdb.min.js"
></script>
</body>
</html>
