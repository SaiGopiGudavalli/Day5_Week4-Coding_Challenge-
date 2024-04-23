<%@ page import="java.util.List" %>
    <%@ page import="com.contactmanagersprint2.ContactServlet" %>
        <%-- Assuming Contact is a class representing a contact --%>
            <% List<Contact> contacts = (List<Contact>)request.getAttribute("contacts"); %>
                    <table>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                        <% for(Contact contact : contacts) { %>
                            <tr>
                                <td>
                                    <%= contact.getName() %>
                                </td>
                                <td>
                                    <%= contact.getEmail() %>
                                </td>
                                <td>
                                    <a href="modifyContact.jsp?id=<%= contact.getId() %>">Modify</a>
                                    <a href="deleteContact?id=<%= contact.getId() %>"
                                        onclick="return confirm('Are you sure?');">Delete</a>
                                </td>
                            </tr>
                            <% } %>
                    </table>