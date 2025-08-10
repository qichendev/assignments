# 🔋 Battery Mall Management System

A comprehensive web application for managing battery sales, inventory, and customer orders. Built with modern JavaScript, HTML5, and CSS3, featuring advanced functionality including drag-and-drop interfaces, real-time validation, and responsive design.

## 📋 Table of Contents

- [Features](#features)
- [Demo Credentials](#demo-credentials)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Technical Requirements](#technical-requirements)
- [API Integration](#api-integration)
- [Security Features](#security-features)
- [Browser Support](#browser-support)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### 🔐 Authentication System
- **User Registration & Login**: Secure authentication with role-based access
- **Password Strength Validation**: Real-time password strength meter
- **Session Management**: Automatic session timeout and extension
- **Remember Me**: Extended session option
- **Demo Accounts**: Pre-configured accounts for testing

### 📊 Dashboard
- **Real-time Statistics**: Sales revenue, order counts, and inventory alerts
- **Interactive Charts**: Sales trends and performance metrics
- **Quick Actions**: Fast access to common tasks
- **System Status**: Monitor application health and connectivity
- **Notification Center**: Real-time alerts and updates

### 🔋 Battery Inventory Management
- **CRUD Operations**: Create, read, update, and delete battery products
- **Advanced Search**: Multi-field search with real-time filtering
- **Category Management**: Drag-and-drop battery categorization
- **Stock Monitoring**: Low stock alerts and inventory tracking
- **Bulk Operations**: Mass updates and batch processing
- **Data Export**: JSON export functionality

### 📦 Order Management
- **Kanban Board**: Drag-and-drop order status management
- **Order Processing**: Complete order lifecycle management
- **Customer Information**: Comprehensive customer data handling
- **Shipping Integration**: Multiple shipping methods and tracking
- **Payment Processing**: Multiple payment method support
- **Order Analytics**: Performance tracking and reporting

### 📈 Sales Analytics
- **Interactive Charts**: Sales trends, product performance, and customer insights
- **Data Visualization**: Chart.js integration for comprehensive reporting
- **Custom Reports**: Generate detailed reports for specific periods
- **Export Functionality**: PDF, Excel, and CSV export options
- **Forecasting**: Sales prediction and trend analysis

### ⚙️ Settings & Configuration
- **User Profile Management**: Personal information and preferences
- **Theme Customization**: Light, dark, and auto themes
- **Notification Settings**: Customizable alert preferences
- **Security Settings**: Two-factor authentication and session management
- **System Configuration**: Application-wide settings and preferences

## 🔑 Demo Credentials

The application comes with pre-configured demo accounts for testing:

### Administrator Account
- **Email**: `admin@batterymall.com`
- **Password**: `Admin123!`
- **Role**: Administrator (Full access)

### Manager Account
- **Email**: `manager@batterymall.com`
- **Password**: `Manager123!`
- **Role**: Manager (Limited admin access)

### Staff Account
- **Email**: `staff@batterymall.com`
- **Password**: `Staff123!`
- **Role**: Staff (Basic access)

## 🚀 Installation

### Prerequisites
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Local web server (optional, for AJAX functionality)
- No additional dependencies required

### Quick Start

1. **Clone or Download** the project files
2. **Open** `index.html` in your web browser
3. **Login** using one of the demo credentials above
4. **Explore** the application features

### Local Server Setup (Recommended)

For full AJAX functionality, run a local web server:

```bash
# Using Python 3
python -m http.server 8000

# Using Node.js (with http-server)
npx http-server

# Using PHP
php -S localhost:8000
```

Then navigate to `http://localhost:8000`

## 📖 Usage

### Getting Started

1. **Login**: Use demo credentials or register a new account
2. **Dashboard**: Overview of your business metrics and quick actions
3. **Inventory**: Manage battery products and stock levels
4. **Orders**: Process customer orders with drag-and-drop status updates
5. **Analytics**: View sales performance and generate reports
6. **Settings**: Customize your experience and manage account settings

### Key Workflows

#### Adding a New Battery
1. Navigate to **Inventory** page
2. Click **"Add Battery"** button
3. Fill in battery specifications and details
4. Set pricing and stock levels
5. Save to add to inventory

#### Processing Orders
1. Go to **Orders** page
2. View orders in Kanban board format
3. Drag orders between status columns
4. Update order details as needed
5. Track shipping and delivery

#### Managing Categories
1. In **Inventory** page, locate category section
2. Drag battery cards onto category items
3. Batteries automatically update to new category
4. View updated category counts

## 📁 Project Structure

```
battery-mall-management/
├── index.html              # Login/Registration page
├── dashboard.html           # Main dashboard
├── inventory.html           # Battery inventory management
├── orders.html             # Order management with Kanban board
├── analytics.html          # Sales analytics and reporting
├── settings.html           # User settings and configuration
├── css/
│   ├── main.css            # Core styles and variables
│   ├── components.css      # Component-specific styles
│   └── responsive.css      # Responsive design rules
├── js/
│   ├── main.js             # Core utilities and initialization
│   ├── auth.js             # Authentication and validation
│   ├── inventory.js        # Inventory management logic
│   ├── orders.js           # Order processing functionality
│   ├── analytics.js        # Analytics and reporting
│   ├── settings.js         # Settings management
│   └── dragdrop.js         # Drag-and-drop functionality
├── data/
│   ├── batteries.json      # Sample battery data
│   ├── orders.json         # Sample order data
│   └── users.json          # User accounts (generated)
├── assets/
│   └── images/             # Application images and icons
└── README.md               # This file
```

## 🛠️ Technical Requirements

### Core Technologies
- **HTML5**: Semantic markup and modern web standards
- **CSS3**: Advanced styling with CSS Grid and Flexbox
- **JavaScript (ES6+)**: Modern JavaScript features and APIs
- **jQuery**: DOM manipulation and AJAX requests
- **Chart.js**: Data visualization and analytics
- **Font Awesome**: Icon library

### JavaScript Features Demonstrated

#### Object-Oriented Programming
```javascript
class Battery {
    constructor(model, brand, voltage, capacity) {
        this.model = model;
        this.brand = brand;
        this.voltage = voltage;
        this.capacity = capacity;
    }
    
    getDisplayName() {
        return `${this.brand} ${this.model}`;
    }
}
```

#### Form Validation
- Real-time validation with custom rules
- Regular expressions for email and pattern matching
- Password strength calculation
- Cross-field validation (password confirmation)

#### Drag and Drop API
- Native HTML5 drag and drop
- Touch support for mobile devices
- Visual feedback and animations
- Data transfer between components

#### Local Storage Management
- Persistent data storage
- Session management
- Auto-save functionality
- Data export/import

#### AJAX Integration
- Asynchronous data loading
- RESTful API simulation
- Error handling and retry logic
- Loading states and user feedback

### Security Features

#### Input Sanitization
```javascript
function sanitizeInput(input) {
    const div = document.createElement('div');
    div.textContent = input;
    return div.innerHTML;
}
```

#### Session Security
- Automatic session timeout
- CSRF token generation
- Secure password hashing (demo implementation)
- Rate limiting for login attempts

#### Data Validation
- Client-side validation with server-side simulation
- SQL injection prevention patterns
- XSS protection through proper escaping

## 🌐 API Integration

### Third-Party APIs (Simulated)

#### Currency Conversion
```javascript
async function getCurrencyRates() {
    // Simulated API call
    return {
        USD: 1.0,
        EUR: 0.85,
        GBP: 0.73
    };
}
```

#### Shipping Calculation
```javascript
async function calculateShipping(weight, destination) {
    // Simulated shipping API
    return {
        standard: 9.99,
        express: 19.99,
        overnight: 39.99
    };
}
```

#### Market Data
```javascript
async function getBatteryMarketPrices() {
    // Simulated market data API
    return {
        leadAcid: 150.00,
        lithium: 800.00,
        agm: 250.00
    };
}
```

## 🔒 Security Features

### Authentication
- Password strength requirements
- Session token validation
- Automatic logout on inactivity
- Remember me functionality

### Data Protection
- Input sanitization
- XSS prevention
- CSRF protection
- Secure data storage patterns

### Access Control
- Role-based permissions
- Route protection
- API endpoint security
- Session management

## 🌍 Browser Support

### Fully Supported
- **Chrome** 80+
- **Firefox** 75+
- **Safari** 13+
- **Edge** 80+

### Partially Supported
- **Internet Explorer** 11 (limited functionality)
- **Mobile browsers** (iOS Safari, Chrome Mobile)

### Required Features
- ES6+ JavaScript support
- CSS Grid and Flexbox
- Local Storage API
- Drag and Drop API
- Canvas API (for charts)

## 📱 Responsive Design

### Breakpoints
- **Mobile**: 320px - 767px
- **Tablet**: 768px - 1023px
- **Desktop**: 1024px+
- **Large Desktop**: 1400px+

### Mobile Features
- Touch-friendly drag and drop
- Responsive navigation
- Optimized forms and inputs
- Swipe gestures support

## 🎨 Customization

### Themes
The application supports multiple themes:
- **Light Theme**: Default bright interface
- **Dark Theme**: Dark mode for low-light environments
- **Auto Theme**: Follows system preference

### CSS Variables
```css
:root {
    --primary-color: #2563eb;
    --secondary-color: #64748b;
    --success-color: #10b981;
    --warning-color: #f59e0b;
    --danger-color: #ef4444;
}
```

## 🧪 Testing

### Manual Testing Checklist

#### Authentication
- [ ] User registration with validation
- [ ] Login with correct credentials
- [ ] Login failure with incorrect credentials
- [ ] Password strength validation
- [ ] Session timeout functionality

#### Inventory Management
- [ ] Add new battery product
- [ ] Edit existing battery
- [ ] Delete battery with confirmation
- [ ] Search and filter functionality
- [ ] Drag and drop categorization

#### Order Management
- [ ] Create new order
- [ ] Drag orders between status columns
- [ ] Update order details
- [ ] Generate tracking numbers
- [ ] Export order data

#### Responsive Design
- [ ] Mobile navigation
- [ ] Touch drag and drop
- [ ] Form usability on mobile
- [ ] Chart responsiveness

## 🚀 Deployment

### Static Hosting
The application can be deployed to any static hosting service:
- **GitHub Pages**
- **Netlify**
- **Vercel**
- **AWS S3**

### Configuration
1. Upload all files to hosting service
2. Ensure `index.html` is set as the default page
3. Configure HTTPS (recommended)
4. Test all functionality in production environment

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Code Standards
- Use ES6+ JavaScript features
- Follow consistent naming conventions
- Add comments for complex functionality
- Maintain responsive design principles
- Test across multiple browsers

## 📄 License

This project is created for educational purposes as part of a web development course assignment. It demonstrates advanced JavaScript concepts, modern web development practices, and responsive design principles.

### Educational Use
- ✅ Learning and educational purposes
- ✅ Portfolio demonstration
- ✅ Code reference and study
- ✅ Academic assignments

### Commercial Use
- ❌ Not licensed for commercial use
- ❌ No warranty or support provided
- ❌ Use at your own risk

## 📞 Support

For questions about this educational project:

1. **Review the documentation** in this README
2. **Check the code comments** for implementation details
3. **Test with demo credentials** provided above
4. **Examine the browser console** for debugging information

## 🎯 Learning Objectives

This project demonstrates proficiency in:

### JavaScript Concepts
- ✅ Object-oriented programming
- ✅ Event handling and DOM manipulation
- ✅ Asynchronous programming (Promises, async/await)
- ✅ Local storage and session management
- ✅ Form validation and user input handling
- ✅ Drag and drop functionality
- ✅ Error handling and debugging

### Web Development Skills
- ✅ Responsive web design
- ✅ CSS Grid and Flexbox layouts
- ✅ Progressive enhancement
- ✅ Accessibility best practices
- ✅ Cross-browser compatibility
- ✅ Performance optimization

### Software Engineering
- ✅ Code organization and modularity
- ✅ Documentation and commenting
- ✅ Version control best practices
- ✅ Testing and quality assurance
- ✅ Security considerations
- ✅ User experience design

---

**Built with ❤️ for educational purposes**

*This project showcases modern web development techniques and serves as a comprehensive example of JavaScript application development.*
