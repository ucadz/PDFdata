<%-- 
    Document   : PDFfiles
    Created on : 25 Nov 2024, 2:28:02 pm
    Author     : OSSP-ITU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        
        <link rel="icon" type="image/png" href="images/pdf.ico">

        <title>PDF Files</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <style>
            body {
                color: #566787;
                background: #f5f5f5;
                font-family: 'Roboto', sans-serif;
            }
            .table-responsive {
                margin: 30px 0;
            }
            .table-wrapper {
                min-width: 1000px;
                background: #fff;
                padding: 20px;
                box-shadow: 0 1px 1px rgba(0,0,0,.05);
            }
            .table-title {
                padding-bottom: 10px;
                margin: 0 0 10px;
                min-width: 100%;
            }
            .table-title h2 {
                margin: 8px 0 0;
                font-size: 22px;
            }

            .notification {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #ff9800;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                font-weight: bold;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                display: none;
            }

            .notification.hidden {
                display: none;
            }
            body {
                color: #566787;
                background: url('images/blank-checked-paper-notes-grey.jpg') no-repeat center center fixed;
                background-size: cover; /* Ensures the background image covers the entire screen */
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 0;
            }

            @media (max-width: 768px) {
                body {
                    background: linear-gradient(to bottom, rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('images/blank-checked-paper-notes-grey.jpg') no-repeat center center fixed;
                    background-size: cover;
                }
            }


        </style>

    </head>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-8"><h2>PDF <b>Files</b></h2></div>
                        </div>
                    </div>
                    <table id="customerTable" class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr>
                                <th>No.</th>
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
                                <td><%= index++%></td>
                                <td><%= fileName%></td>
                                <td>
                                    <a href="/pdfviewer/pdfs/<%= fileName%>" target="_blank" class="icon view-icon" data-filename="<%= fileName%>">
                                        <i class="fas fa-search"></i> <!-- PDF open icon -->
                                    </a>
                                </td>
                                <td>
                                    <a href="/pdfviewer/pdfs/<%= fileName%>" download class="icon pdf-icon">
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
            </div>  
        </div>   

        <!-- Notification for new PDF upload -->
        <div id="notification" class="notification hidden">
            New PDF file(s) detected from scanner!
        </div>

        <script>
            $(document).ready(function () {
                // Initialize DataTables
                var table = $('#customerTable').DataTable();

                // Add a transition class when table updates on page change
                table.on('draw', function () {
                    $('#customerTable tbody').addClass('fade-in'); // Add fade-in class
                    setTimeout(function () {
                        $('#customerTable tbody').removeClass('fade-in'); // Remove class after animation
                    }, 300); // Match the duration of the animation
                });

                // Function to show notification
                function showNotification() {
                    $('#notification').removeClass('hidden'); // Remove hidden class to show the notification
                    setTimeout(function () {
                        $('#notification').addClass('hidden'); // Hide notification after 3 seconds
                    }, 3000); // Keep the notification visible for 3 seconds
                }

                // Function to check if new files are uploaded
                function checkNewPdfFiles() {
                    $.ajax({
                        url: '/path-to-your-servlet-or-endpoint-to-check-new-files', // Endpoint to check for new PDF files
                        method: 'GET',
                        success: function (response) {
                            if (response.newFilesUploaded) { // Check if new files are uploaded
                                showNotification(); // Display the notification
                            }
                        },
                        error: function () {
                            console.log('Error checking new files.');
                        }
                    });
                }

                // Periodically check for new PDF files
                setInterval(checkNewPdfFiles, 5000); // Check every 5 seconds
            });
        </script>
        <script>
            // Function to set a custom favicon
            function setFavicon(fileName) {
                var favicon = document.createElement('link');
                favicon.rel = 'icon';
                favicon.type = 'image/png';
                favicon.href = '/images/' + fileName + '.png'; // Set dynamic favicon path based on the file name (you can use a default icon or different ones for each file)
                document.head.appendChild(favicon);
            }

            // Function to handle the view icon click and change favicon
            $(document).on('click', '.view-icon', function () {
                // Get the file name from the data attribute of the clicked link
                var fileName = $(this).data('filename'); // Assuming the data-filename attribute holds the PDF file name
                setFavicon(fileName); // Set the favicon dynamically based on the file name
            });
        </script>

        <script src="script1.js"></script>
        <link rel="stylesheet" href="style.css">
    </body>

</html>
