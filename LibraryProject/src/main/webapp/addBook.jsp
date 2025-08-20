<%@ page import="com.example.dao.BookDAO,com.example.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<h2>Add Book</h2>
<form method="post">
Title: <input type="text" name="title" required><br/>
Author: <input type="text" name="author" required><br/>
<input type="submit" value="Save">
</form>
<p><a href="index.jsp">Back</a></p>
<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
String title = request.getParameter("title");
String author = request.getParameter("author");
BookDAO dao = new BookDAO();
boolean ok = dao.addBook(new Book(title, author, true));
if (ok) out.println("<p style='color:green'>Book added!</p>");
else out.println("<p style='color:red'>Failed to add book.</p>");
}
%>
</body>
</html>