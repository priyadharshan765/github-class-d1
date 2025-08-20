<%@ page import="java.util.*,com.example.dao.BookDAO,com.example.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<h2>Books</h2>
<p><a href="index.jsp">Back</a></p>

<%
BookDAO dao = new BookDAO();
String action = request.getParameter("action");
String idStr = request.getParameter("id");
if (action != null && idStr != null) {
try {
int id = Integer.parseInt(idStr);
boolean done = false;
if ("delete".equals(action)) done = dao.deleteBook(id);
if ("borrow".equals(action)) done = dao.borrowBook(id);
if ("return".equals(action)) done = dao.returnBook(id);
if (done) out.println("<p style='color:green'>Action successful.</p>");
else out.println("<p style='color:red'>Action failed.</p>");
} catch (Exception e) { out.println("<p style='color:red'>Invalid id.</p>"); }
}
List<Book> books = dao.getAllBooks();
%>
<table border="1" cellpadding="6" cellspacing="0">
<tr>
<th>ID</th>
<th>Title</th>
<th>Author</th>
<th>Status</th>
<th>Actions</th>
</tr>
<%
for (Book b : books) {
%>
<tr>
<td><%= b.getId() %></td>
<td><%= b.getTitle() %></td>
<td><%= b.getAuthor() %></td>
<td><%= b.isAvailable() ? "Available" : "Borrowed" %></td>
<td>
<a href="listBooks.jsp?action=delete&id=<%=b.getId()%>" onclick="return confirm('Delete
this book?')">Delete</a>
<% if (b.isAvailable()) { %>
| <a href="listBooks.jsp?action=borrow&id=<%=b.getId()%>">Borrow</a>
<% } else { %>
| <a href="listBooks.jsp?action=return&id=<%=b.getId()%>">Return</a>
<% } %>

</td>
</tr>
<%
}
%>
</table>
</body>
</html>