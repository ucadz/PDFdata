$(document).ready(function () {
    let previousFiles = []; // Track previously listed files

    // Function to fetch new files from the backend
    function checkForNewFiles() {
        $.ajax({
            url: '/watchPdfDir', // Backend endpoint
            method: 'GET',
            dataType: 'json',
            success: function (newFiles) {
                if (newFiles.length > 0) {
                    // Notify the user about new files
                    showNotification(newFiles);

                    // Add new files to the table
                    addNewFilesToTable(newFiles);

                    // Update previous file list
                    previousFiles = [...previousFiles, ...newFiles];
                }
            },
            error: function () {
                console.error('Failed to fetch new PDF files.');
            },
        });
    }

    // Show notification for new files
    function showNotification(newFiles) {
        const notification = $('#notification');
        notification.text(`New PDF(s) added: ${newFiles.join(', ')}`);
        notification.removeClass('hidden');
        setTimeout(() => notification.addClass('hidden'), 3000); // Hide after 3 seconds
    }

    // Add new files to the table
    function addNewFilesToTable(newFiles) {
        const tableBody = $('#pdfTableBody');
        newFiles.forEach((file, index) => {
            const filePath = `/pdfviewer/pdfs/${file}`;
            const row = `
                <tr>
                    <td>${previousFiles.length + index + 1}</td>
                    <td>${file}</td>
                    <td>
                        <a href="${filePath}" target="_blank" class="icon view-icon">
                            <i class="fas fa-search"></i>
                        </a>
                    </td>
                    <td>
                        <a href="${filePath}" download class="icon pdf-icon">
                            <i class="fas fa-file-pdf"></i>
                        </a>
                    </td>
                </tr>
            `;
            tableBody.append(row);
        });
    }

    // Poll for new files every 3 seconds
    setInterval(checkForNewFiles, 3000);
});
