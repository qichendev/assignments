/**
 * BATTERY MALL MANAGEMENT - AUTHENTICATION MODULE
 * Handles user authentication, registration, and form validation
 */

// ===== AUTHENTICATION STATE =====
let authState = {
    isLoading: false,
    currentForm: 'login',
    validationRules: {},
    passwordStrength: 0
};

// ===== VALIDATION RULES =====
const validationRules = {
    username: {
        required: true,
        minLength: 3,
        maxLength: 20,
        pattern: /^[a-zA-Z0-9_]+$/,
        message: 'Username must be 3-20 characters, alphanumeric and underscore only'
    },
    email: {
        required: true,
        pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
        message: 'Please enter a valid email address'
    },
    password: {
        required: true,
        minLength: 8,
        pattern: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]/,
        message: 'Password must contain at least 8 characters with uppercase, lowercase, number, and special character'
    },
    confirmPassword: {
        required: true,
        match: 'password',
        message: 'Passwords do not match'
    },
    phone: {
        required: true,
        pattern: /^[\+]?[1-9][\d]{0,15}$/,
        message: 'Please enter a valid phone number'
    }
};

// ===== MOCK USER DATABASE =====
let users = [
    {
        id: 'user_1',
        username: 'admin',
        email: 'admin@batterymall.com',
        password: 'Admin123!', // In real app, this would be hashed
        role: 'admin',
        firstName: 'John',
        lastName: 'Doe',
        phone: '+1-555-0123',
        createdAt: new Date('2024-01-01').toISOString(),
        isActive: true
    },
    {
        id: 'user_2',
        username: 'manager',
        email: 'manager@batterymall.com',
        password: 'Manager123!',
        role: 'manager',
        firstName: 'Jane',
        lastName: 'Smith',
        phone: '+1-555-0124',
        createdAt: new Date('2024-01-15').toISOString(),
        isActive: true
    },
    {
        id: 'user_3',
        username: 'staff',
        email: 'staff@batterymall.com',
        password: 'Staff123!',
        role: 'staff',
        firstName: 'Bob',
        lastName: 'Johnson',
        phone: '+1-555-0125',
        createdAt: new Date('2024-02-01').toISOString(),
        isActive: true
    }
];

// ===== INITIALIZATION =====
document.addEventListener('DOMContentLoaded', function() {
    initializeAuth();
});

/**
 * Initialize authentication module
 */
function initializeAuth() {
    try {
        // Load users from storage or use defaults
        const storedUsers = loadFromStorage('batteryMall_users');
        if (storedUsers && storedUsers.length > 0) {
            users = storedUsers;
        } else {
            saveToStorage('batteryMall_users', users);
        }
        
        // Check if already authenticated
        if (isAuthenticated()) {
            redirectToDashboard();
            return;
        }
        
        // Setup form event listeners
        setupFormEventListeners();
        
        // Setup real-time validation
        setupRealTimeValidation();
        
        // Setup password strength meter
        setupPasswordStrengthMeter();
        
        console.log('Authentication module initialized');
    } catch (error) {
        handleError(error, 'Auth Initialization');
    }
}

/**
 * Setup form event listeners
 */
function setupFormEventListeners() {
    // Login form
    const loginForm = getElementById('loginFormElement');
    if (loginForm) {
        loginForm.addEventListener('submit', handleLogin);
    }
    
    // Registration form
    const registerForm = getElementById('registerFormElement');
    if (registerForm) {
        registerForm.addEventListener('submit', handleRegistration);
    }
    
    // Password toggle buttons
    const toggleButtons = querySelectorAll('.toggle-password');
    toggleButtons.forEach(button => {
        button.addEventListener('click', function() {
            const input = this.parentElement.querySelector('input');
            togglePasswordVisibility(input.id);
        });
    });
}

/**
 * Setup real-time validation
 */
function setupRealTimeValidation() {
    // Get all form inputs
    const inputs = querySelectorAll('input[required], input[data-validate]');
    
    inputs.forEach(input => {
        // Validate on blur
        input.addEventListener('blur', function() {
            validateField(this);
        });
        
        // Clear errors on focus
        input.addEventListener('focus', function() {
            clearFieldError(this);
        });
        
        // Real-time validation for specific fields
        if (input.type === 'email' || input.name === 'username') {
            input.addEventListener('input', debounce(function() {
                validateField(this);
            }, 500));
        }
    });
}

/**
 * Setup password strength meter
 */
function setupPasswordStrengthMeter() {
    const passwordInput = getElementById('registerPassword');
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            updatePasswordStrength(this.value);
        });
    }
}

// ===== FORM SWITCHING =====

/**
 * Switch to registration form
 */
function switchToRegister() {
    try {
        const loginForm = getElementById('loginForm');
        const registerForm = getElementById('registerForm');
        
        if (loginForm && registerForm) {
            loginForm.classList.remove('active');
            registerForm.classList.add('active');
            authState.currentForm = 'register';
            
            // Focus first input
            const firstInput = registerForm.querySelector('input');
            if (firstInput) {
                setTimeout(() => firstInput.focus(), 100);
            }
        }
    } catch (error) {
        handleError(error, 'Switch to Register');
    }
}

/**
 * Switch to login form
 */
function switchToLogin() {
    try {
        const loginForm = getElementById('loginForm');
        const registerForm = getElementById('registerForm');
        
        if (loginForm && registerForm) {
            registerForm.classList.remove('active');
            loginForm.classList.add('active');
            authState.currentForm = 'login';
            
            // Focus first input
            const firstInput = loginForm.querySelector('input');
            if (firstInput) {
                setTimeout(() => firstInput.focus(), 100);
            }
        }
    } catch (error) {
        handleError(error, 'Switch to Login');
    }
}

// ===== PASSWORD UTILITIES =====

/**
 * Toggle password visibility
 * @param {string} inputId - Password input ID
 */
function togglePassword(inputId) {
    try {
        const input = getElementById(inputId);
        const button = input.parentElement.querySelector('.toggle-password');
        const icon = button.querySelector('i');
        
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    } catch (error) {
        handleError(error, 'Toggle Password');
    }
}

/**
 * Calculate password strength
 * @param {string} password - Password to evaluate
 * @returns {number} Strength score (0-4)
 */
function calculatePasswordStrength(password) {
    let score = 0;
    
    if (!password) return score;
    
    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Character variety checks
    if (/[a-z]/.test(password)) score++;
    if (/[A-Z]/.test(password)) score++;
    if (/[0-9]/.test(password)) score++;
    if (/[^A-Za-z0-9]/.test(password)) score++;
    
    // Bonus for very long passwords
    if (password.length >= 16) score++;
    
    return Math.min(score, 4);
}

/**
 * Update password strength meter
 * @param {string} password - Password value
 */
function updatePasswordStrength(password) {
    try {
        const strengthBar = getElementById('strengthBar');
        const strengthText = getElementById('strengthText');
        
        if (!strengthBar || !strengthText) return;
        
        const strength = calculatePasswordStrength(password);
        authState.passwordStrength = strength;
        
        // Update visual indicator
        const strengthLevels = ['', 'weak', 'fair', 'good', 'strong'];
        const strengthTexts = ['', 'Weak', 'Fair', 'Good', 'Strong'];
        
        strengthBar.className = `strength-bar ${strengthLevels[strength]}`;
        strengthText.textContent = strengthTexts[strength] || 'Password strength';
        
        // Update width percentage
        const widthPercentage = (strength / 4) * 100;
        strengthBar.style.width = `${widthPercentage}%`;
        
    } catch (error) {
        handleError(error, 'Update Password Strength');
    }
}

// ===== VALIDATION FUNCTIONS =====

/**
 * Validate individual field
 * @param {HTMLInputElement} field - Input field to validate
 * @returns {boolean} Validation result
 */
function validateField(field) {
    try {
        const fieldName = field.name.replace(/^(login|register)/, '').toLowerCase();
        const value = field.value.trim();
        const rules = validationRules[fieldName];
        
        if (!rules) return true;
        
        // Clear previous errors
        clearFieldError(field);
        
        // Required check
        if (rules.required && !value) {
            showFieldError(field, `${fieldName} is required`);
            return false;
        }
        
        if (!value) return true; // Skip other validations if field is empty and not required
        
        // Length checks
        if (rules.minLength && value.length < rules.minLength) {
            showFieldError(field, `${fieldName} must be at least ${rules.minLength} characters`);
            return false;
        }
        
        if (rules.maxLength && value.length > rules.maxLength) {
            showFieldError(field, `${fieldName} must not exceed ${rules.maxLength} characters`);
            return false;
        }
        
        // Pattern check
        if (rules.pattern && !rules.pattern.test(value)) {
            showFieldError(field, rules.message);
            return false;
        }
        
        // Match check (for confirm password)
        if (rules.match) {
            const matchField = field.form.querySelector(`[name*="${rules.match}"]`);
            if (matchField && value !== matchField.value) {
                showFieldError(field, rules.message);
                return false;
            }
        }
        
        // Custom validations
        if (fieldName === 'email') {
            return validateEmail(field, value);
        }
        
        if (fieldName === 'username') {
            return validateUsername(field, value);
        }
        
        return true;
        
    } catch (error) {
        handleError(error, 'Field Validation');
        return false;
    }
}

/**
 * Validate email field
 * @param {HTMLInputElement} field - Email input field
 * @param {string} email - Email value
 * @returns {boolean} Validation result
 */
function validateEmail(field, email) {
    // Check if email already exists (for registration)
    if (field.form.id === 'registerFormElement') {
        const existingUser = users.find(user => user.email.toLowerCase() === email.toLowerCase());
        if (existingUser) {
            showFieldError(field, 'Email address is already registered');
            return false;
        }
    }
    
    return true;
}

/**
 * Validate username field
 * @param {HTMLInputElement} field - Username input field
 * @param {string} username - Username value
 * @returns {boolean} Validation result
 */
function validateUsername(field, username) {
    // Check if username already exists (for registration)
    if (field.form.id === 'registerFormElement') {
        const existingUser = users.find(user => user.username.toLowerCase() === username.toLowerCase());
        if (existingUser) {
            showFieldError(field, 'Username is already taken');
            return false;
        }
    }
    
    return true;
}

/**
 * Validate entire form
 * @param {HTMLFormElement} form - Form to validate
 * @returns {boolean} Validation result
 */
function validateForm(form) {
    try {
        let isValid = true;
        const inputs = form.querySelectorAll('input[required], input[data-validate]');
        
        inputs.forEach(input => {
            if (!validateField(input)) {
                isValid = false;
            }
        });
        
        return isValid;
    } catch (error) {
        handleError(error, 'Form Validation');
        return false;
    }
}

/**
 * Show field error
 * @param {HTMLInputElement} field - Input field
 * @param {string} message - Error message
 */
function showFieldError(field, message) {
    field.classList.add('error');
    const errorElement = field.parentElement.querySelector('.error-message');
    if (errorElement) {
        errorElement.textContent = message;
    }
}

/**
 * Clear field error
 * @param {HTMLInputElement} field - Input field
 */
function clearFieldError(field) {
    field.classList.remove('error');
    const errorElement = field.parentElement.querySelector('.error-message');
    if (errorElement) {
        errorElement.textContent = '';
    }
}

// ===== AUTHENTICATION HANDLERS =====

/**
 * Handle login form submission
 * @param {Event} event - Form submit event
 */
async function handleLogin(event) {
    event.preventDefault();
    
    if (authState.isLoading) return;
    
    try {
        authState.isLoading = true;
        showLoading('Authenticating...');
        
        const form = event.target;
        
        // Validate form
        if (!validateForm(form)) {
            return;
        }
        
        const formData = serializeForm(form);
        const { loginEmail, loginPassword, rememberMe } = formData;
        
        // Simulate API delay
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        // Find user
        const user = users.find(u => 
            (u.email.toLowerCase() === loginEmail.toLowerCase() || 
             u.username.toLowerCase() === loginEmail.toLowerCase()) &&
            u.password === loginPassword &&
            u.isActive
        );
        
        if (!user) {
            showNotification('Invalid credentials. Please try again.', 'error');
            return;
        }
        
        // Create session
        createSession(user, rememberMe);
        
        // Show success message
        showNotification('Login successful! Redirecting...', 'success');
        
        // Redirect to dashboard
        setTimeout(() => {
            redirectToDashboard();
        }, 1000);
        
    } catch (error) {
        handleError(error, 'Login');
        showNotification('Login failed. Please try again.', 'error');
    } finally {
        authState.isLoading = false;
        hideLoading();
    }
}

/**
 * Handle registration form submission
 * @param {Event} event - Form submit event
 */
async function handleRegistration(event) {
    event.preventDefault();
    
    if (authState.isLoading) return;
    
    try {
        authState.isLoading = true;
        showLoading('Creating account...');
        
        const form = event.target;
        
        // Validate form
        if (!validateForm(form)) {
            return;
        }
        
        const formData = serializeForm(form);
        const { 
            registerUsername, 
            registerEmail, 
            registerPassword, 
            confirmPassword,
            userRole,
            agreeTerms
        } = formData;
        
        // Check password confirmation
        if (registerPassword !== confirmPassword) {
            showFieldError(getElementById('confirmPassword'), 'Passwords do not match');
            return;
        }
        
        // Check terms agreement
        if (!agreeTerms) {
            showNotification('Please agree to the terms of service', 'error');
            return;
        }
        
        // Check password strength
        if (authState.passwordStrength < 3) {
            showNotification('Please choose a stronger password', 'error');
            return;
        }
        
        // Simulate API delay
        await new Promise(resolve => setTimeout(resolve, 1500));
        
        // Create new user
        const newUser = {
            id: generateId(),
            username: registerUsername,
            email: registerEmail,
            password: registerPassword, // In real app, this would be hashed
            role: userRole,
            firstName: '',
            lastName: '',
            phone: '',
            createdAt: new Date().toISOString(),
            isActive: true
        };
        
        // Add to users array
        users.push(newUser);
        saveToStorage('batteryMall_users', users);
        
        // Show success message
        showNotification('Account created successfully! Please log in.', 'success');
        
        // Switch to login form
        setTimeout(() => {
            switchToLogin();
            
            // Pre-fill login form
            const loginEmailField = getElementById('loginEmail');
            if (loginEmailField) {
                loginEmailField.value = registerEmail;
            }
        }, 1000);
        
    } catch (error) {
        handleError(error, 'Registration');
        showNotification('Registration failed. Please try again.', 'error');
    } finally {
        authState.isLoading = false;
        hideLoading();
    }
}

// ===== UTILITY FUNCTIONS =====

/**
 * Redirect to dashboard
 */
function redirectToDashboard() {
    window.location.href = 'dashboard.html';
}

/**
 * Hash password (simplified for demo)
 * @param {string} password - Plain text password
 * @returns {string} Hashed password
 */
function hashPassword(password) {
    // In a real application, use a proper hashing library like bcrypt
    // This is just for demonstration
    let hash = 0;
    for (let i = 0; i < password.length; i++) {
        const char = password.charCodeAt(i);
        hash = ((hash << 5) - hash) + char;
        hash = hash & hash; // Convert to 32-bit integer
    }
    return hash.toString();
}

/**
 * Verify password (simplified for demo)
 * @param {string} password - Plain text password
 * @param {string} hash - Hashed password
 * @returns {boolean} Verification result
 */
function verifyPassword(password, hash) {
    return hashPassword(password) === hash;
}

/**
 * Generate secure password
 * @param {number} length - Password length
 * @returns {string} Generated password
 */
function generateSecurePassword(length = 12) {
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*';
    let password = '';
    
    for (let i = 0; i < length; i++) {
        password += charset.charAt(Math.floor(Math.random() * charset.length));
    }
    
    return password;
}

// ===== SECURITY FEATURES =====

/**
 * Sanitize input to prevent XSS
 * @param {string} input - User input
 * @returns {string} Sanitized input
 */
function sanitizeInput(input) {
    const div = document.createElement('div');
    div.textContent = input;
    return div.innerHTML;
}

/**
 * Generate CSRF token
 * @returns {string} CSRF token
 */
function generateCSRFToken() {
    return generateId() + '_' + Date.now();
}

/**
 * Rate limiting for login attempts
 */
const loginAttempts = {
    attempts: {},
    maxAttempts: 5,
    lockoutTime: 15 * 60 * 1000, // 15 minutes
    
    isBlocked(identifier) {
        const attempts = this.attempts[identifier];
        if (!attempts) return false;
        
        if (attempts.count >= this.maxAttempts) {
            const timeSinceLastAttempt = Date.now() - attempts.lastAttempt;
            return timeSinceLastAttempt < this.lockoutTime;
        }
        
        return false;
    },
    
    recordAttempt(identifier, success = false) {
        if (!this.attempts[identifier]) {
            this.attempts[identifier] = { count: 0, lastAttempt: 0 };
        }
        
        if (success) {
            delete this.attempts[identifier];
        } else {
            this.attempts[identifier].count++;
            this.attempts[identifier].lastAttempt = Date.now();
        }
    },
    
    getRemainingTime(identifier) {
        const attempts = this.attempts[identifier];
        if (!attempts) return 0;
        
        const timeSinceLastAttempt = Date.now() - attempts.lastAttempt;
        return Math.max(0, this.lockoutTime - timeSinceLastAttempt);
    }
};

// ===== DEMO FUNCTIONS =====

/**
 * Fill demo credentials
 * @param {string} role - User role (admin, manager, staff)
 */
function fillDemoCredentials(role = 'admin') {
    const demoUsers = {
        admin: { email: 'admin@batterymall.com', password: 'Admin123!' },
        manager: { email: 'manager@batterymall.com', password: 'Manager123!' },
        staff: { email: 'staff@batterymall.com', password: 'Staff123!' }
    };
    
    const credentials = demoUsers[role];
    if (credentials) {
        const emailField = getElementById('loginEmail');
        const passwordField = getElementById('loginPassword');
        
        if (emailField && passwordField) {
            emailField.value = credentials.email;
            passwordField.value = credentials.password;
            showNotification(`Demo credentials filled for ${role}`, 'info');
        }
    }
}

// Make demo function available globally for testing
window.fillDemoCredentials = fillDemoCredentials;
