package com.contactmanagersprint2;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        // Use your DatabaseConnection class to get a connection to the database
        return DatabaseConnection.initializeDatabase();
    }

    public List<Contact> getAllContacts() {
        List<Contact> contacts = new ArrayList<>();
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM contact");
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Contact contact = new Contact();
                contact.setId(rs.getInt("id"));
                contact.setName(rs.getString("name"));
                contact.setEmail(rs.getString("email"));
                contacts.add(contact);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contacts;
    }

    public Contact getContactById(int id) {
        Contact contact = null;
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM contact WHERE id = ?")) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    contact = new Contact();
                    contact.setId(rs.getInt("id"));
                    contact.setName(rs.getString("name"));
                    contact.setEmail(rs.getString("email"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contact;
    }

    public void updateContact(Contact contact) throws SQLException, ClassNotFoundException {
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement("UPDATE contact SET name = ?, email = ? WHERE id = ?")) {
            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setInt(3, contact.getId());
            ps.executeUpdate();
        }
    }

    public void deleteContactById(int id) throws SQLException, ClassNotFoundException {
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement("DELETE FROM contact WHERE id = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}