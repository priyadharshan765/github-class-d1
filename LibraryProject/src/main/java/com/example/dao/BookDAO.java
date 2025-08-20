package com.example.dao;
import java.sql.*;
import java.util.*;
import com.example.model.Book;
public class BookDAO {
private static final String URL = "jdbc:mysql://localhost:3306/librarydb";
private static final String USER = "root"; // change to your MySQL username
private static final String PASS = "root"; // change to your MySQL password
private Connection getConnection() throws Exception {
Class.forName("com.mysql.cj.jdbc.Driver");
return DriverManager.getConnection(URL, USER, PASS);
}
public boolean addBook(Book b) {
try (Connection con = getConnection();
PreparedStatement ps = con.prepareStatement(
"INSERT INTO books(title, author, available) VALUES(?,?,?)")) {

ps.setString(1, b.getTitle());
ps.setString(2, b.getAuthor());
ps.setBoolean(3, b.isAvailable());
return ps.executeUpdate() > 0;
} catch (Exception e) {
e.printStackTrace();
return false;
}
}
public List<Book> getAllBooks() {
List<Book> list = new ArrayList<>();
try (Connection con = getConnection();
PreparedStatement ps = con.prepareStatement("SELECT * FROM books ORDER BY
id DESC");
ResultSet rs = ps.executeQuery()) {
while (rs.next()) {
list.add(new Book(
rs.getInt("id"),
rs.getString("title"),
rs.getString("author"),
rs.getBoolean("available")
));
}
} catch (Exception e) {
e.printStackTrace();
}
return list;
}
public boolean deleteBook(int id) {
try (Connection con = getConnection();
PreparedStatement ps = con.prepareStatement("DELETE FROM books WHERE
id=?")) {
ps.setInt(1, id);
return ps.executeUpdate() > 0;
} catch (Exception e) {
e.printStackTrace();
return false;
}
}
public boolean borrowBook(int id) {
try (Connection con = getConnection();

PreparedStatement ps = con.prepareStatement("UPDATE books SET available=0
WHERE id=? AND available=1")) {
ps.setInt(1, id);
return ps.executeUpdate() > 0; // only updates if currently available
} catch (Exception e) {
e.printStackTrace();
return false;
}
}
public boolean returnBook(int id) {
try (Connection con = getConnection();
PreparedStatement ps = con.prepareStatement("UPDATE books SET available=1
WHERE id=? AND available=0")) {
ps.setInt(1, id);
return ps.executeUpdate() > 0; // only updates if currently borrowed
} catch (Exception e) {
e.printStackTrace();
return false;
}
}
}