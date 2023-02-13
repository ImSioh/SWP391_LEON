<%@include file= "../template/header.jsp" %>
<div style="margin-top: 70px !important; padding-left: 282px !important">
    <ul class="nav nav-tabs mb-3" id="ex-with-icons" role="tablist">
        <li class="nav-item" role="presentation">
            <a class="nav-link active" id="ex-with-icons-tab-1" data-mdb-toggle="tab" href="#ex-with-icons-tabs-1" role="tab"
               aria-controls="ex-with-icons-tabs-1" aria-selected="true"><i class="fas fa-chart-pie fa-fw me-2"></i>Class approved</a>
        </li>
        <li class="nav-item" role="presentation">
            <a class="nav-link" id="ex-with-icons-tab-2" data-mdb-toggle="tab" href="#ex-with-icons-tabs-2" role="tab"
               aria-controls="ex-with-icons-tabs-2" aria-selected="false"><i class="fas fa-chart-line fa-fw me-2"></i>Class hidden</a>
        </li>

    </ul>
</div>
<div class="Content" style="background-color: rgba(209, 209, 209, 0.5); height:  1000px;">
    <section>
        <div class="container py-5">
            <div class="row">
                <div class="col">
                    <nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
                        <ol class="breadcrumb mb-0 position-relative row">
                            <div class="left col-md-6" style="margin-left: 24px;">
                                <button type="button " class="btn btn-info text-light btn-rounded text-wrap">
                                    <a href="<%=path%>/teacher/class/create" style="text-decoration: none; color: white ">
                                        + Create class
                                    </a>
                                </button>
                            </div>
                            <div class="right position-absolute col-md-6" style="top:0; bottom: 0;right: 0;">
                                <div class="input-group rounded row" style="">
                                    <form action="<%=path%>/teacher/search" method="post">
                                        <input type="search" class="form-control rounded" name="searchName" value="${searchName}" placeholder="Search" aria-label="Search" aria-describedby="search-addon" />
                                    </form>
                                </div>
                            </div>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="tab-content" id="ex-with-icons-content">
                <div class="tab-pane fade show active" id="ex-with-icons-tabs-1" role="tabpanel" aria-labelledby="ex-with-icons-tab-1">
                    <div class="row">
                        <c:if test="${verified}">
                            <c:forEach items="${classObjList}" var="co">
                                <c:if test="${co.isHidden() == false}">
                                    <div class="col-lg-3" style="margin-bottom: 24px;">
                                        <a href="<c:url value="/teacher/class/newfeed?code=${co.getCode()}"/>" style="text-decoration: none;">
                                            <div class="card" style=" border-radius: 15px; overflow: hidden;">
                                                <div style="overflow: hidden; width: 100%; height: 100%;height: 188px; background-size: cover;
                                                     background-position: center;
                                                     background-image: url(<c:url value="${co.getClassPicture() == null ? '/assets/img/Common_picture.png' : co.getClassPicture()}"/>)"> 
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title" style="padding: 4px 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${co.getName()}</h5>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </c:if>

                            </c:forEach>
                        </c:if>
                        <c:if test="${!verified}">
                            <div style=" width: 100%; width: 250px;height: 100%;height: 200px; background-size: cover;
                                 margin: auto; background-image: url(<c:url value="/student/assets/img/10.png"/>)">
                            </div>
                            <div class="card-body" >
                                <h5 class="card-title" style="text-align: center;font-weight: 100;">Not found class - Search again</h5>
                            </div>

                        </c:if>
                    </div>
                </div>
                <div class="tab-pane fade" id="ex-with-icons-tabs-2" role="tabpanel" aria-labelledby="ex-with-icons-tab-2">
                    <div class="row">
                        <c:if test="${verified}">
                            <c:forEach items="${classObjList}" var="co">
                                <c:if test="${co.isHidden() == true}">
                                    <div class="col-lg-3" style="margin-bottom: 24px;">
                                        <a href="<c:url value="/teacher/class/newfeed?code=${co.getCode()}"/>" style="text-decoration: none;">
                                            <div class="card" style=" border-radius: 15px; overflow: hidden;">
                                                <div style="overflow: hidden; width: 100%; height: 100%;height: 188px; background-size: cover;
                                                     background-position: center;
                                                     background-image: url(<c:url value="${co.getClassPicture() == null ? '/assets/img/Common_picture.png' : co.getClassPicture()}"/>)"> 
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title" style="padding: 4px 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${co.getName()}</h5>
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </c:if>

                            </c:forEach>
                        </c:if>
                    </div>
                </div>

            </div>

        </div>
    </section>

</div>
</div>
<c:import url="../template/footer.jsp"/>
