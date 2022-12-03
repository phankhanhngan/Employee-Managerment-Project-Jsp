<%@ page import="com.ngthvu.quanlynhanvienproject.bean.EmployeeView" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ngthvu.quanlynhanvienproject.bean.Salary" %>
<%@ page import="com.ngthvu.quanlynhanvienproject.bean.Department" %>
<%@ page import="com.ngthvu.quanlynhanvienproject.bean.Admin" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Manage Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
            href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&family=Varela+Round&display=swap"
            rel="stylesheet"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
            integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    />
    <link
            rel="stylesheet"
            href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/stylesheet/index.css" />
    <script src="${pageContext.request.contextPath}/main.js"></script>
</head>

<body>
<div class="container">
    <jsp:include page="/view/navigation.jsp"></jsp:include>
    <div>
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="tabel-title">
                    <p>Manage</p>
                    <i class="fa-solid fa-circle"></i>
                    <p class="text">Admin</p>
                </div>
                <div class="table-control">
                    <div class="search">
                        <form action="admins" method="get">
                            <input
                                    name="keyword"
                                    type="search"
                                    class="search-input"
                                    id="search-input"
                                    placeholder="Search"
                                    autocomplete="off"
                                    value="${keyword}"
                            />
                        </form>
                        <i class="search-icon fa-solid fa-magnifying-glass"></i>
                    </div>
                    <c:if test = "${not empty sessionScope.admin}">
                    <div class="add">
                        <a href="admin/add" class="btn">
                            <div class="tooltip">
                                <i class="add-icon fa-solid fa-plus"></i>
                                <p class="tooltiptext">Add new admin</p>
                            </div></a
                        >
                    </div>
                    </c:if>
                </div>
            </div>
            <c:if test = "${!empty admins}">
                <table class="table table-striped table-hover table-borderless">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th><a href="admins?pageNum=${pageNum}&keyword=${keyword}&fieldName=name&orderBy=${reverseOrderBy}">Username</a></th>
                        <th><a href="admins?pageNum=${pageNum}&keyword=${keyword}&fieldName=address&orderBy=${reverseOrderBy}">First Name</a></th>
                        <th><a href="admins?pageNum=${pageNum}&keyword=${keyword}&fieldName=phone_number&orderBy=${reverseOrderBy}">Last Name</a></th>
                        <th><a href="admins?pageNum=${pageNum}&keyword=${keyword}&fieldName=description&orderBy=${reverseOrderBy}">Phone Number</a></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        List<Admin> admins = (List<Admin>) request.getAttribute("admins");
                        Long i = (Long) request.getAttribute("startCount");
                        for (Admin admin : admins) {
                    %>
                    <tr>
                        <td><%=i++%></td>
                        <td><%=admin.getUsername()%></td>
                        <td><%=admin.getFirstName()%></td>
                        <td><%=admin.getLastName()%></td>
                        <td><%=admin.getPhone()%></td>
                        <td class="td-action">
                            <c:if test = "${not empty sessionScope.admin}">
                            <a href="admin/update?id=<%=admin.getId()%>" class="edit">
                                <div class="tooltip">
                                    <i class="edit-icon fa-solid fa-pen-to-square"></i>
                                    <p class="tooltiptext">Edit</p>
                                </div>
                            </a>
                            <a href="admin/delete?id=<%=admin.getId()%>" class="delete link-delete">
                                <div class="tooltip">
                                    <i class="delete-icon fa-solid fa-trash"></i>
                                    <p class="tooltiptext">Delete</p>
                                </div>
                            </a>
                            </c:if>
                        </td>

                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </c:if>
            <c:if test = "${empty admins}">
                <div>
                    <h3><p class="text text-center">No matches found.</p></h3>
                </div>
            </c:if>
            <c:if test = "${totalPage > 1}">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-control link-back"
                           href="admins?pageNum=${pageNum == 1 ? pageNum : pageNum -1 }&keyword=${keyword}&fieldName=${fieldName}&orderBy=${orderBy}">
                            <i class="fa-solid fa-arrow-left-long"></i
                            ></a>
                    </li>
                    <c:forEach var = "i" begin = "1" end = "${totalPage}">
                        <li class="page-item ${i == pageNum ? 'active' : ''}"><a href="admins?pageNum=${i}&keyword=${keyword}&fieldName=${fieldName}&orderBy=${orderBy}" class="page-link">${i}</a></li>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-control link-next"
                           href="admins?pageNum=${pageNum == totalPage ? pageNum : pageNum +1 }&keyword=${keyword}&fieldName=${fieldName}&orderBy=${orderBy}">
                            <i class="fa-solid fa-arrow-right-long"></i
                            ></a>
                    </li>
                </ul>
            </c:if>
        </div>
        <div id="deleteAminModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <div class="modal-header">
                            <h4 class="modal-title">Delete Admin</h4>
                            <button
                                    type="button"
                                    class="close"
                                    data-dismiss="modal"
                                    aria-hidden="true"
                            >
                                &times;
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to delete this admin?</p>
                            <p class="text-warning">
                                <small>This action cannot be undone.</small>
                            </p>
                        </div>
                        <div class="modal-footer">
                            <input
                                    type="button"
                                    class="btn btn-default"
                                    data-dismiss="modal"
                                    value="Cancel"
                            />
                            <a href="" class="btn btn-danger but-delete">Delete</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function (){
        $(".link-delete").click(function (e){
            e.preventDefault();
            $("#deleteAminModal").modal();
            $(".but-delete").attr("href",$(this).attr("href"));
        })
        $(".link-back").click(function (e){
            if(${pageNum  == 1 }){
                e.preventDefault();
            }
        })
        $(".link-next").click(function (e){
            if(${pageNum  == totalPage }){
                e.preventDefault();
            }
        })
    })
</script>
</html>



