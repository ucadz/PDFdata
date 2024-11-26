<%-- 
    Document   : sample2
    Created on : 25 Nov 2024, 2:16:17 pm
    Author     : OSSP-ITU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- DataTable CSS  -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0-alpha3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.4.1/css/responsive.bootstrap5.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    
    
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <title>DataTable | devRasen</title>
</head>

<body>
    <!-- Main Content -->
    <h1>PDF Files</h1>
    <div class="container p-3 my-5 bg-light border border-primary">
        <!-- DataTable Code starts -->
        <table id="example" class="table table-striped nowrap" style="width:100%">
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Files name</th>
                    <th>View</th>
                    <th>Download</th>
                </tr>
            </thead>
            <tbody>
                     <%
                    // Path to the directory containing PDF files (relative to the web application)
                    String pdfDirPath = application.getRealPath("/pdfs"); // Get the real path to 'pdfs' folder
                    out.println("PDF Directory Path: " + pdfDirPath); // Debugging line to print the directory path

                    File pdfDir = new File(pdfDirPath);

                    // List to store PDF files
                    List<File> pdfFiles = new ArrayList<>();
                    if (pdfDir.exists() && pdfDir.isDirectory()) {
                        // Filter and add only PDF files to the list
                        for (File file : pdfDir.listFiles()) {
                            if (file.isFile() && file.getName().toLowerCase().endsWith(".pdf")) {
                                pdfFiles.add(file);
                            }
                        }
                    } else {
                        out.println("Directory does not exist or is not accessible.");
                    }

                    // Generate table rows dynamically for each PDF file
                    int index = 1; // Counter for file number
                    if (pdfFiles.isEmpty()) {
                        out.println("No PDF files found.");
                    }
                    for (File file : pdfFiles) {
                        String fileName = file.getName(); // Get the file name
                        String filePath = "/pdfs/" + fileName; // Construct file path relative to the web server
                %>
                <tr>
                    <td><%= index++ %></td>
                    <td><%= fileName %></td>
                    <td>
                        <a href="/pdfviewer/pdfs/<%= fileName %>" target="_blank" class="icon view-icon">
                            <i class="fas fa-search"></i> <!-- Changed to a PDF open icon (search icon as an example) -->
                        </a>
                    </td>
                    <td>
                        <a href="/pdfviewer/pdfs/<%= fileName %>" download class="icon pdf-icon">
                            <i class="fas fa-file-pdf"></i> <!-- PDF icon -->
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>        
                </tbody>
        </table>
    </div>

    <!-- DataTable JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.4.1/js/dataTables.responsive.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.4.1/js/responsive.bootstrap5.min.js"></script>

    <!-- Custom JS -->
    <script src="script.js"></script>
</body>

</html>