<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PDF Table Viewer</title>
        <!-- Include Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ccc;
            }
            th {
                background-color: #f4f4f4;
            }
            /* Styling for the icons */
            .icon {
                font-size: 20px; /* Increase the icon size */
                text-decoration: none;
                transition: color 0.3s ease; /* Smooth transition for color change */
            }
            /* View icon color */
            .view-icon {
                color: #28a745; /* Green color for view icon */
            }
            .view-icon:hover {
                color: #218838; /* Darker green on hover */
            }
            /* PDF icon color */
            .pdf-icon {
                color: #dc3545; /* Red color for PDF icon */
            }
            .pdf-icon:hover {
                color: #c82333; /* Darker red on hover */
            }
        </style>
    </head>
    <body>
        <h1>PDF Files</h1>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>File Name</th>
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
          
    </body>
</html>



