/**
 * BATTERY MALL MANAGEMENT - MAIN JAVASCRIPT
 * Core functionality and utilities for the application
 */

// ===== GLOBAL VARIABLES =====
let currentUser = null;
let appSettings = {
    theme: 'light',
    language: 'en',
    timezone: 'UTC-5',
    dateFormat: 'MM/DD/YYYY',
    autoSave: true,
    notifications: true
};

// ===== UTILITY FUNCTIONS =====

/**
 * Utility function to safely get elements by ID
 * @param {string} id - Element ID
 * @returns {HTMLElement|null}
 */
function getElementById(id) {
    return document.getElementById(id);
}

/**
 * Utility function to safely query selectors
 * @param {string} selector - CSS selector
 * @returns {HTMLElement|null}
 */
function querySelector(selector) {
    return document.querySelector(selector);
}

/**
 * Utility function to query all selectors
 * @param {string} selector - CSS selector
 * @returns {NodeList}
 */
function querySelectorAll(selector) {
    return document.querySelectorAll(selector);
}

/**
 * Generate unique ID
 * @returns {string}
 */
function generateId() {
    return 'id_' + Math.random().toString(36).substr(2, 9) + '_' + Date.now();
}

/**
 * Format currency
 * @param {number} amount - Amount to format
 * @param {string} currency - Currency code (default: USD)
 * @returns {string}
 */
function formatCurrency(amount, currency = 'USD') {
    try {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency
        }).format(amount);
    } catch (error) {
        console.error('Error formatting currency:', error);
        return `$${amount.toFixed(2)}`;
    }
}

/**
 * Format date
 * @param {Date|string} date - Date to format
 * @param {string} format - Format string (optional)
 * @returns {string}
 */
function formatDate(date, format = null) {
    try {
        const dateObj = date instanceof Date ? date : new Date(date);
        const formatStr = format || appSettings.dateFormat;
        
        const options = {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit'
        };
        
        if (formatStr === 'YYYY-MM-DD') {
            return dateObj.toISOString().split('T')[0];
        } else if (formatStr === 'DD/MM/YYYY') {
            return dateObj.toLocaleDateString('en-GB');
        } else {
            return dateObj.toLocaleDateString('en-US');
        }
    } catch (error) {
        console.error('Error formatting date:', error);
        return date.toString();
    }
}

/**
 * Debounce function
 * @param {Function} func - Function to debounce
 * @param {number} wait - Wait time in milliseconds
 * @returns {Function}
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Throttle function
 * @param {Function} func - Function to throttle
 * @param {number} limit - Limit in milliseconds
 * @returns {Function}
 */
function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

// ===== LOCAL STORAGE UTILITIES =====

/**
 * Save data to localStorage with error handling
 * @param {string} key - Storage key
 * @param {any} data - Data to store
 * @returns {boolean} Success status
 */
function saveToStorage(key, data) {
    try {
        const jsonData = JSON.stringify(data);
        localStorage.setItem(key, jsonData);
        return true;
    } catch (error) {
        console.error('Error saving to localStorage:', error);
        showNotification('Failed to save data locally', 'error');
        return false;
    }
}

/**
 * Load data from localStorage with error handling
 * @param {string} key - Storage key
 * @param {any} defaultValue - Default value if not found
 * @returns {any}
 */
function loadFromStorage(key, defaultValue = null) {
    try {
        const data = localStorage.getItem(key);
        return data ? JSON.parse(data) : defaultValue;
    } catch (error) {
        console.error('Error loading from localStorage:', error);
        return defaultValue;
    }
}

/**
 * Remove data from localStorage
 * @param {string} key - Storage key
 */
function removeFromStorage(key) {
    try {
        localStorage.removeItem(key);
    } catch (error) {
        console.error('Error removing from localStorage:', error);
    }
}

/**
 * Clear all application data from localStorage
 */
function clearAllStorage() {
    try {
        const keys = Object.keys(localStorage);
        keys.forEach(key => {
            if (key.startsWith('batteryMall_')) {
                localStorage.removeItem(key);
            }
        });
    } catch (error) {
        console.error('Error clearing localStorage:', error);
    }
}

// ===== SESSION MANAGEMENT =====

/**
 * Check if user is authenticated
 * @returns {boolean}
 */
function isAuthenticated() {
    const session = loadFromStorage('batteryMall_session');
    if (!session || !session.token || !session.expiresAt) {
        return false;
    }
    
    const now = new Date().getTime();
    if (now > session.expiresAt) {
        removeFromStorage('batteryMall_session');
        return false;
    }
    
    return true;
}

/**
 * Get current user from session
 * @returns {Object|null}
 */
function getCurrentUser() {
    if (!isAuthenticated()) {
        return null;
    }
    
    const session = loadFromStorage('batteryMall_session');
    return session ? session.user : null;
}

/**
 * Create user session
 * @param {Object} user - User object
 * @param {boolean} rememberMe - Whether to extend session
 */
function createSession(user, rememberMe = false) {
    const expirationTime = rememberMe ? 30 * 24 * 60 * 60 * 1000 : 8 * 60 * 60 * 1000; // 30 days or 8 hours
    const session = {
        user: user,
        token: generateId(),
        createdAt: new Date().getTime(),
        expiresAt: new Date().getTime() + expirationTime
    };
    
    saveToStorage('batteryMall_session', session);
    currentUser = user;
}

/**
 * Destroy user session
 */
function destroySession() {
    removeFromStorage('batteryMall_session');
    currentUser = null;
}

/**
 * Extend session expiration
 */
function extendSession() {
    const session = loadFromStorage('batteryMall_session');
    if (session) {
        session.expiresAt = new Date().getTime() + (8 * 60 * 60 * 1000); // Extend by 8 hours
        saveToStorage('batteryMall_session', session);
    }
}

// ===== NOTIFICATION SYSTEM =====

/**
 * Show notification to user
 * @param {string} message - Notification message
 * @param {string} type - Notification type (success, error, warning, info)
 * @param {number} duration - Duration in milliseconds (default: 5000)
 */
function showNotification(message, type = 'info', duration = 5000) {
    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.innerHTML = `
        <div class="notification-content">
            <i class="fas fa-${getNotificationIcon(type)}"></i>
            <span>${message}</span>
            <button class="notification-close" onclick="closeNotification(this)">
                <i class="fas fa-times"></i>
            </button>
        </div>
    `;
    
    // Add to notification container or create one
    let container = querySelector('.notification-container');
    if (!container) {
        container = document.createElement('div');
        container.className = 'notification-container';
        document.body.appendChild(container);
    }
    
    container.appendChild(notification);
    
    // Animate in
    setTimeout(() => notification.classList.add('show'), 100);
    
    // Auto remove
    if (duration > 0) {
        setTimeout(() => {
            closeNotification(notification.querySelector('.notification-close'));
        }, duration);
    }
    
    // Browser notification if enabled and supported
    if (appSettings.notifications && 'Notification' in window && Notification.permission === 'granted') {
        new Notification('Battery Mall Management', {
            body: message,
            icon: '/assets/images/logo.png'
        });
    }
}

/**
 * Get notification icon based on type
 * @param {string} type - Notification type
 * @returns {string}
 */
function getNotificationIcon(type) {
    const icons = {
        success: 'check-circle',
        error: 'exclamation-circle',
        warning: 'exclamation-triangle',
        info: 'info-circle'
    };
    return icons[type] || 'info-circle';
}

/**
 * Close notification
 * @param {HTMLElement} closeBtn - Close button element
 */
function closeNotification(closeBtn) {
    const notification = closeBtn.closest('.notification');
    if (notification) {
        notification.classList.add('hide');
        setTimeout(() => {
            notification.remove();
        }, 300);
    }
}

// ===== MODAL UTILITIES =====

/**
 * Show modal
 * @param {string} modalId - Modal element ID
 */
function showModal(modalId) {
    const modal = getElementById(modalId);
    if (modal) {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';
        
        // Focus first input
        const firstInput = modal.querySelector('input, select, textarea');
        if (firstInput) {
            setTimeout(() => firstInput.focus(), 100);
        }
    }
}

/**
 * Hide modal
 * @param {string} modalId - Modal element ID
 */
function hideModal(modalId) {
    const modal = getElementById(modalId);
    if (modal) {
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }
}

/**
 * Hide all modals
 */
function hideAllModals() {
    const modals = querySelectorAll('.modal.active');
    modals.forEach(modal => {
        modal.classList.remove('active');
    });
    document.body.style.overflow = '';
}

// ===== LOADING STATES =====

/**
 * Show loading overlay
 * @param {string} message - Loading message (optional)
 */
function showLoading(message = 'Loading...') {
    let overlay = getElementById('loadingOverlay');
    if (!overlay) {
        overlay = document.createElement('div');
        overlay.id = 'loadingOverlay';
        overlay.className = 'loading-overlay';
        overlay.innerHTML = `
            <div class="loading-spinner">
                <i class="fas fa-battery-half fa-spin"></i>
                <p>${message}</p>
            </div>
        `;
        document.body.appendChild(overlay);
    }
    
    overlay.querySelector('p').textContent = message;
    overlay.classList.add('active');
}

/**
 * Hide loading overlay
 */
function hideLoading() {
    const overlay = getElementById('loadingOverlay');
    if (overlay) {
        overlay.classList.remove('active');
    }
}

// ===== FORM UTILITIES =====

/**
 * Serialize form data to object
 * @param {HTMLFormElement} form - Form element
 * @returns {Object}
 */
function serializeForm(form) {
    const formData = new FormData(form);
    const data = {};
    
    for (let [key, value] of formData.entries()) {
        if (data[key]) {
            // Handle multiple values (arrays)
            if (Array.isArray(data[key])) {
                data[key].push(value);
            } else {
                data[key] = [data[key], value];
            }
        } else {
            data[key] = value;
        }
    }
    
    return data;
}

/**
 * Reset form and clear validation errors
 * @param {HTMLFormElement} form - Form element
 */
function resetForm(form) {
    form.reset();
    
    // Clear validation errors
    const errorElements = form.querySelectorAll('.error-message');
    errorElements.forEach(element => {
        element.textContent = '';
    });
    
    // Remove error classes
    const inputElements = form.querySelectorAll('input, select, textarea');
    inputElements.forEach(element => {
        element.classList.remove('error');
    });
}

// ===== THEME MANAGEMENT =====

/**
 * Set application theme
 * @param {string} theme - Theme name (light, dark, auto)
 */
function setTheme(theme) {
    appSettings.theme = theme;
    document.documentElement.setAttribute('data-theme', theme);
    saveToStorage('batteryMall_settings', appSettings);
}

/**
 * Initialize theme based on user preference
 */
function initializeTheme() {
    const savedSettings = loadFromStorage('batteryMall_settings');
    if (savedSettings) {
        appSettings = { ...appSettings, ...savedSettings };
    }
    
    let theme = appSettings.theme;
    
    if (theme === 'auto') {
        theme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    }
    
    document.documentElement.setAttribute('data-theme', theme);
}

// ===== ERROR HANDLING =====

/**
 * Global error handler
 * @param {Error} error - Error object
 * @param {string} context - Error context
 */
function handleError(error, context = 'Unknown') {
    console.error(`Error in ${context}:`, error);
    
    // Show user-friendly error message
    const message = error.message || 'An unexpected error occurred';
    showNotification(`Error: ${message}`, 'error');
    
    // Log error for debugging (in production, send to logging service)
    const errorLog = {
        message: error.message,
        stack: error.stack,
        context: context,
        timestamp: new Date().toISOString(),
        userAgent: navigator.userAgent,
        url: window.location.href
    };
    
    console.log('Error Log:', errorLog);
}

// ===== NAVIGATION UTILITIES =====

/**
 * Navigate to page with authentication check
 * @param {string} page - Page URL
 */
function navigateTo(page) {
    // Check if authentication is required
    const publicPages = ['index.html', ''];
    const currentPage = page.split('/').pop() || 'index.html';
    
    if (!publicPages.includes(currentPage) && !isAuthenticated()) {
        window.location.href = 'index.html';
        return;
    }
    
    window.location.href = page;
}

/**
 * Logout user
 */
function logout() {
    try {
        destroySession();
        clearAllStorage();
        showNotification('Logged out successfully', 'success');
        setTimeout(() => {
            window.location.href = 'index.html';
        }, 1000);
    } catch (error) {
        handleError(error, 'Logout');
    }
}

// ===== NOTIFICATION PANEL =====

/**
 * Toggle notification panel
 */
function toggleNotifications() {
    const panel = getElementById('notificationPanel');
    if (panel) {
        panel.classList.toggle('active');
    }
}

// ===== INITIALIZATION =====

/**
 * Initialize application
 */
function initializeApp() {
    try {
        // Initialize theme
        initializeTheme();
        
        // Load user session
        currentUser = getCurrentUser();
        
        // Update user info in navigation
        updateUserInfo();
        
        // Set up session timeout
        setupSessionTimeout();
        
        // Set up global event listeners
        setupGlobalEventListeners();
        
        // // Request notification permission
        // requestNotificationPermission();
        
        console.log('Application initialized successfully');
    } catch (error) {
        handleError(error, 'App Initialization');
    }
}

/**
 * Update user info in navigation
 */
function updateUserInfo() {
    if (currentUser) {
        const userNameElements = querySelectorAll('#userName, #welcomeUserName');
        userNameElements.forEach(element => {
            if (element) {
                element.textContent = currentUser.username || currentUser.email;
            }
        });
        
        const userRoleElement = getElementById('userRole');
        if (userRoleElement) {
            userRoleElement.textContent = currentUser.role || 'User';
        }
    }
}

/**
 * Setup session timeout
 */
function setupSessionTimeout() {
    // Extend session on user activity
    const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart'];
    const extendSessionThrottled = throttle(extendSession, 60000); // Throttle to once per minute
    
    events.forEach(event => {
        document.addEventListener(event, extendSessionThrottled, true);
    });
    
    // Check session validity every 5 minutes
    setInterval(() => {
        if (!isAuthenticated() && window.location.pathname !== '/index.html') {
            showNotification('Session expired. Please log in again.', 'warning');
            setTimeout(() => {
                window.location.href = 'index.html';
            }, 2000);
        }
    }, 5 * 60 * 1000);
}

/**
 * Setup global event listeners
 */
function setupGlobalEventListeners() {
    // Close modals on escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            hideAllModals();
        }
    });
    
    // Close modals on backdrop click
    document.addEventListener('click', (e) => {
        if (e.target.classList.contains('modal')) {
            hideAllModals();
        }
    });
    
    // Handle theme changes
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
        if (appSettings.theme === 'auto') {
            const theme = e.matches ? 'dark' : 'light';
            document.documentElement.setAttribute('data-theme', theme);
        }
    });
}

/**
 * Request notification permission
 */
function requestNotificationPermission() {
    if ('Notification' in window && Notification.permission === 'default') {
        Notification.requestPermission().then(permission => {
            if (permission === 'granted') {
                showNotification('Notifications enabled', 'success');
            }
        });
    }
}

// ===== AUTO-SAVE FUNCTIONALITY =====

/**
 * Auto-save form data
 * @param {HTMLFormElement} form - Form element
 * @param {string} key - Storage key
 */
function autoSaveForm(form, key) {
    if (!appSettings.autoSave) return;
    
    const saveData = debounce(() => {
        const data = serializeForm(form);
        saveToStorage(`batteryMall_draft_${key}`, data);
    }, 1000);
    
    // Save on input changes
    form.addEventListener('input', saveData);
    form.addEventListener('change', saveData);
}

/**
 * Load auto-saved form data
 * @param {HTMLFormElement} form - Form element
 * @param {string} key - Storage key
 */
function loadAutoSavedForm(form, key) {
    const data = loadFromStorage(`batteryMall_draft_${key}`);
    if (data) {
        Object.keys(data).forEach(fieldName => {
            const field = form.querySelector(`[name="${fieldName}"]`);
            if (field) {
                field.value = data[fieldName];
            }
        });
    }
}

/**
 * Clear auto-saved form data
 * @param {string} key - Storage key
 */
function clearAutoSavedForm(key) {
    removeFromStorage(`batteryMall_draft_${key}`);
}

// ===== EXPORT FUNCTIONALITY =====

/**
 * Export data as JSON file
 * @param {Object} data - Data to export
 * @param {string} filename - File name
 */
function exportAsJSON(data, filename) {
    try {
        const jsonString = JSON.stringify(data, null, 2);
        const blob = new Blob([jsonString], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        
        const link = document.createElement('a');
        link.href = url;
        link.download = filename;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        
        URL.revokeObjectURL(url);
        showNotification('Data exported successfully', 'success');
    } catch (error) {
        handleError(error, 'Export Data');
    }
}

// ===== INITIALIZE ON DOM CONTENT LOADED =====
document.addEventListener('DOMContentLoaded', initializeApp);
