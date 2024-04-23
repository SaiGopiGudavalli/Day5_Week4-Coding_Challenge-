<%@ page import="com.contactmanagersprint2.Contact" %>
    <%-- Assuming we have fetched the contact object based on ID --%>
        <% Contact contact=(Contact)request.getAttribute("contact"); %>
            <form action="  " method="post">
                <input type="hidden" name="id" value="<%= contact.getId() %>" />
                <input type="text" name="name" value="<%= contact.getName() %>" />
                <input type="email" name="email" value="<%= contact.getEmail() %>" />
                <button type="submit">Update Contact</button>
            </form>