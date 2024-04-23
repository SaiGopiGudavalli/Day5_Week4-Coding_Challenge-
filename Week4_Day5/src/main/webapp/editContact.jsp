<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.contactmanagersprint2.Contact" %>
<%@ page import="com.contactmanagersprint2.ContactDAO" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<title>Edit Contact</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="index.html">Contact Manager</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active" aria-current="page" href="/index.jsp">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="contactmanagersprint2/contact.jsp">Add
							Contact</a></li>
				</ul>
			</div>
		</div>
	</nav>
    <% if (session.getAttribute("message") != null) { %>
        <div class="alert alert-success" role="alert">
            <%= session.getAttribute("message") %>
        </div>
        <% session.removeAttribute("message"); %>
    <% } %>
	<div class="container my-5">
		<div class="row row-cols-md-3 row-cols-1 justify-content-center">
			<div class="col">
				<div class="text-center">
					<h3>Edit Contact Form</h3>
				</div>
				<%
					String contactId = request.getParameter("id");
					ContactDAO dao = new ContactDAO();
					Contact contact = dao.getContactById(Integer.parseInt(contactId));
				%>
				<form name="editContactForm" method="post" action="/contactmanagersprint2/contact">
                    <input type="hidden" name="action" value="update" />
                    <input type="hidden" name="id" value="<%= contactId %>" />
					<div class="mb-3">
						<label for="name" class="form-label">Name</label> 
                        <input type="text" class="form-control"
							id="name" name="name" value="<%= contact.getName() %>" required>
					</div>
					<div class="mb-3">
						<label for="email" class="form-label">Email</label> <input type="email" class="form-control"
							id="email" name="email" value="<%= contact.getEmail() %>" required>
					</div>
					<div class="mb-3">
						<button class="btn btn-primary w-100" type="submit">Update
							Contact</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>\
	<script src="app.js"></script>
</body>

</html>