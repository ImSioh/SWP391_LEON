<%@include file= "/template/header.jsp" %>
<div class="content" style="margin-top: 50px;">
    <section style="background-color: rgba(209, 209, 209, 0.5);">
        <div class="container py-5">
            <div class="row">
                <div class="col">
                    <nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
                        <ol class="breadcrumb mb-0">
                            <c:choose>
                                <c:when test="${account.getRole() == 1 }">
                                    <li class="breadcrumb-item"><a href="<c:url value="/teacher/class"/>" style="text-decoration: none;">Home</a></li>
                                    </c:when>    
                                    <c:otherwise>
                                    <li class="breadcrumb-item"><a href="<c:url value="/student/overview"/>" style="text-decoration: none;">Home</a></li>
                                    </c:otherwise>
                                </c:choose>

                            <li class="breadcrumb-item active" aria-current="page">Profile</li>
                        </ol>
                    </nav>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-4">
                    <div class="card mb-4">
                        <div class="card-body text-center">

                            <div style="width: 150px; height: 150px; overflow: hidden; margin: 0 auto;" class="rounded-circle mt-5 position-relative" >
                                <div id="profile-img" style="
                                     width: 100%;
                                     height: 0;
                                     padding-bottom: 100%;
                                     background-image: url(<c:url value="${account.getProfilePicture()==null ? '/assets/img/ava.png' :account.getProfilePicture()}"/>);
                                     background-position: center;
                                     background-repeat: no-repeat;
                                     background-size: cover;
                                     ">;
                                </div>

                            </div>


                            <h5 class="my-3">${account.getName()}</h5>
                            <p class="text-muted mb-1">${account.getRole() == 1 ? "Teacher" : "Student"}</p>
                            <p class="text-muted mb-4">${account.getAddress()}</p>
                            <c:choose>
                                <c:when test="${account.getRole() == 1 }">
                                    <div class="d-flex justify-content-center mb-2">
                                        <a type="button" class="btn btn-primary" href="<c:url value="/teacher/profile/change-password"/>">Change Password</a>
                                        <a type="button" class="btn btn-outline-primary ms-1" href="<c:url value="/teacher/profile/edit"/>">Edit Profile</a>
                                    </div>
                                </c:when>    
                                <c:otherwise>
                                    <div class="d-flex justify-content-center mb-2">
                                        <a type="button" class="btn btn-primary" href="<c:url value="/student/profile/change-password"/>">Change Password</a>
                                        <a type="button" class="btn btn-outline-primary ms-1" href="<c:url value="/student/profile/edit"/>">Edit Profile</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>

                </div>
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Full Name</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${account.getName()}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Email</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${account.getEmail()}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Date of Birth</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${account.getBirthDate()}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Mobile</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${account.getPhoneNumber()}</p>
                                </div>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <p class="mb-0">Address</p>
                                </div>
                                <div class="col-sm-9">
                                    <p class="text-muted mb-0">${account.getAddress()}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>
</div>
<c:import url="/template/footer.jsp"/>