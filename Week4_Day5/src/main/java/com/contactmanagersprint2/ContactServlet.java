package com.contactmanagersprint2;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class ContactServlet
 */
public class ContactServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public ContactServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		try {
			ContactDAO dao = new ContactDAO();
			List<Contact> contacts = dao.getAllContacts();
			JSONArray jsonContacts = new JSONArray();
			for (Contact contact : contacts) {
				JSONObject jsonContact = new JSONObject();
				jsonContact.put("id", contact.getId());
				jsonContact.put("name", contact.getName());
				jsonContact.put("email", contact.getEmail());
				jsonContacts.put(jsonContact);
			}
			out.print(jsonContacts.toString());
		} catch (Exception e) {
			JSONObject error = new JSONObject();
			error.put("error", "Error occurred: " + e.getMessage());
			out.print(error.toString());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("update".equals(action)) {
			try {
				int id = Integer.parseInt(request.getParameter("id"));
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				ContactDAO dao = new ContactDAO();
				Contact contact = dao.getContactById(id);
				if (contact != null) {
					contact.setName(name);
					contact.setEmail(email);
					dao.updateContact(contact);
					request.setAttribute("message", "Contact updated successfully");
					request.getSession().setAttribute("message", "Contact updated successfully!");
					response.sendRedirect("index.jsp?message=Contact updated successfully");	
				} else {
					request.setAttribute("error", "Contact not found");
					request.getRequestDispatcher("/editContact.jsp").forward(request, response);
				}
			} catch (Exception e) {
				request.setAttribute("error", "Error updating contact: " + e.getMessage());
				request.getRequestDispatcher("/editContact.jsp").forward(request, response);
			}
		} else {
			response.setContentType("text/html");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
				response.getWriter()
						.println("<html><body><b>Missing name or email. Please fill out all fields.</b></body></html>");
				return;
			}
			try (Connection con = DatabaseConnection.initializeDatabase();
					PreparedStatement st = con.prepareStatement("insert into contact(name, email) values(?, ?)")) {
				st.setString(1, name);
				st.setString(2, email);
				int result = st.executeUpdate();
				if (result > 0) {
					response.sendRedirect("/contactmanagersprint2/");
					response.getWriter().println("<html><body><b>Insertion Success</b></body></html>");
				} else {
					response.getWriter().println("<html><body><b>Insertion Failed</b></body></html>");
				}
			} catch (Exception e) {
				response.getWriter().println("<html><body><b>Error occurred: " + e.getMessage() + "</b></body></html>");
				e.printStackTrace();
			}
		}

	}
}
