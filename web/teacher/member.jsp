<%@include file="../template/header.jsp" %>

<div class="content main-container d-flex" style="background-color: rgba(209, 209, 209, 0.5);  margin-top: 56px;">
    <%@include file="../template/sidebar.jsp" %>

    <div class="content-main d-flex justify-content-center container" style="margin-left: 250px;">
        <div class="card col-md-9 mt-4 row" style="height: fit-content;" >
            <!--<div class="card-header">Create Post</div>-->
            <div class=""  style="margin-left: 31%;"> 
                <div class="form-outline mt-4 col-md-8 ">
                    <input type="search" class="form-control" id="datatable-search-input">
                    <label class="form-label" for="datatable-search-input">Search</label>
                </div>
                <div id="datatable">
                </div>
            </div>
            <div class="card-body m-3" >
                <table class="table align-middle mb-0 bg-white" style="padding: -10px;">
                    <thead class="bg-light">
                        <tr>
                            <th>Name</th>
                            <th>School</th>
                            <th>PhoneNumber</th>
                            <th>Excercise</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listStudent}" var="listS" >
                            <tr>                          
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img
                                            src="https://mdbootstrap.com/img/new/avatars/8.jpg"
                                            alt=""
                                            style="width: 45px; height: 45px"
                                            class="rounded-circle"
                                            />
                                        <div class="ms-3">
                                            <p class="fw-bold mb-1">${listS.getName()}</p>
                                            <p class="text-muted mb-0">${listS.getEmail()}</p>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <p class="fw-normal mb-1">FBT Uni</p>
                                    <!--                                <p class="text-muted mb-0">IT department</p>-->
                                </td>
                                <td>
                                    <span class="">${listS.getPhoneNumber()}</span>
                                </td>
                                <td>10/12</td>
                                <td>
                                    <button style="text-decoration: none" type="button" class="btn btn-link btn-sm btn-rounded">
                                        Delete
                                    </button>
                                </td>              
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!--</div>-->
<c:import url="../template/footer.jsp" />