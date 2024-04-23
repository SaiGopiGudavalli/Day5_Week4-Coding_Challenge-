<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<%@ page import="java.util.List" %>
		<%@ page import="com.contactmanagersprint2.Contact" %>
			<%@ page import="com.contactmanagersprint2.ContactDAO" %>
				<!DOCTYPE html>
				<html>

				<head>
					<meta charset="ISO-8859-1">
					<title>Contact Manager</title>
					<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
						rel="stylesheet"
						integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
						crossorigin="anonymous">
					<meta name="viewport" content="width=device-width, initial-scale=1">
				</head>

				<body>
					<nav class="navbar navbar-expand-lg navbar-light bg-light">
						<div class="container-fluid">
							<a class="navbar-brand" href="/contactmanagersprint2/">Contact Manager</a>
							<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
								data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
								aria-expanded="false" aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
							<div class="collapse navbar-collapse" id="navbarSupportedContent">
								<ul class="navbar-nav me-auto mb-2 mb-lg-0">
									<li class="nav-item"><a class="nav-link active" aria-current="page"
											href="/contactmanagersprint2/">Home</a></li>
									<li class="nav-item"><a class="nav-link"
											href="/contactmanagersprint2/contact.jsp">Add
											Contact</a></li>
								</ul>
							</div>
						</div>
					</nav>
					<% if (session.getAttribute("message") !=null) { %>
						<div class="alert alert-success" role="alert">
							<%= session.getAttribute("message") %>
						</div>
						<% session.removeAttribute("message"); %>
							<% } %>
								<h1 class="text-center my-4">Welcome to Contact Manager</h1>
								<div class="text-center">
									<a href="contact.jsp">
										<button id="addContactBtn" class="btn btn-primary text-center">Add
											Contact</button>
									</a>
								</div>
								<div class="container w-50 mx-auto my-4">
									<h2>Contact List</h2>
									<table class="table">
										<thead>
											<tr>
												<th scope="col">#</th>
												<th scope="col">Name</th>
												<th scope="col">Email</th>
												<th scope="col">Actions</th>
											</tr>
										</thead>
										<tbody>
											<% List<Contact> contacts = new ContactDAO().getAllContacts();
												for (Contact contact : contacts) {
												%>
												<tr>
													<td>
														<%= contact.getId() %>
													</td>
													<td>
														<%= contact.getName() %>
													</td>
													<td>
														<%= contact.getEmail() %>
													</td>
													<td>
														<a href="editContact.jsp?id=<%= contact.getId() %>">Edit</a> |
														<a href="deleteContact?id=<%= contact.getId() %>"
															onclick="return confirm('Are you sure?');">Delete</a>
													</td>
												</tr>
												<% } %>
										</tbody>
									</table>
								</div>
								<script
									src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
									integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
									crossorigin="anonymous"></script>

								<script src="app.js"></script>
				</body>

				</html>