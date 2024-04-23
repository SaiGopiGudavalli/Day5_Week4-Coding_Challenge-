package com.contactmanagersprint2;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

/**
 * Servlet implementation class deleteContact
 */
public class DeleteContact extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteContact() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		System.out.println(id);
		if (id != null && !id.trim().isEmpty()) {
			try {
				int contactId = Integer.parseInt(id);
				ContactDAO dao = new ContactDAO();
				dao.deleteContactById(contactId);
				request.getSession().setAttribute("message", "Contact deleted successfully!");
				response.sendRedirect("index.jsp?message=Contact deleted successfully");
			} catch (Exception e) {
				throw new ServletException("Deleting contact failed.", e);
			}
		} else {
			response.sendRedirect("index.jsp?error=Invalid contact ID");
		}
	}

}
