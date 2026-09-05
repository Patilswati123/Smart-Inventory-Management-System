/**
 * Smart Inventory Management System - Custom JavaScript
 * Use this file for client-side form validations, confirmation dialogs, and dynamic UI interactions.
 */

document.addEventListener('DOMContentLoaded', function () {
    console.log("Smart Inventory Management System UI initialized.");

    // Example: Auto-hide alerts after 4 seconds if present
    const alerts = document.querySelectorAll('.alert-dismissible');
    alerts.forEach(function (alert) {
        setTimeout(function () {
            const bsAlert = bootstrap.Alert.getOrCreateInstance(alert);
            bsAlert.close();
        }, 4000);
    });
});

/**
 * Confirmation helper for delete operations
 * Can be used in JSP like: onclick="return confirmDelete('Are you sure you want to delete this product?');"
 */
function confirmDelete(message) {
    return confirm(message || "Are you sure you want to perform this action?");
}
