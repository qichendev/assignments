/**
 * BATTERY MALL MANAGEMENT - ORDERS MODULE
 * Handles order management, processing, and Kanban board functionality
 */

// ===== ORDERS STATE =====
let ordersState = {
    orders: [],
    filteredOrders: [],
    currentView: 'kanban',
    currentPage: 1,
    itemsPerPage: 20,
    searchQuery: '',
    filters: {
        status: '',
        date: '',
        priority: ''
    },
    sortBy: 'date',
    selectedOrders: new Set(),
    isLoading: false,
    orderStatuses: ['pending', 'processing', 'shipped', 'delivered', 'cancelled']
};

// ===== INITIALIZATION =====
document.addEventListener('DOMContentLoaded', function() {
    if (window.location.pathname.includes('orders.html')) {
        initializeOrders();
    }
});

/**
 * Initialize orders module
 */
async function initializeOrders() {
    try {
        // Check authentication
        if (!isAuthenticated()) {
            navigateTo('index.html');
            return;
        }
        
        showLoading('Loading orders...');
        
        // Load order data
        await loadOrderData();
        
        // Setup event listeners
        setupOrderEventListeners();
        
        // Render initial view
        renderOrders();
        
        // Update order counts
        updateOrderCounts();
        
        // Setup drag and drop for orders
        setupOrderDragDrop();
        
        hideLoading();
        console.log('Orders module initialized');
        
    } catch (error) {
        handleError(error, 'Orders Initialization');
        hideLoading();
    }
}

/**
 * Load order data from JSON file or localStorage
 */
async function loadOrderData() {
    try {
        // Try to load from localStorage first
        let orders = loadFromStorage('batteryMall_orders');
        
        if (!orders || orders.length === 0) {
            // Load from JSON file
            const response = await fetch('data/orders.json');
            if (!response.ok) {
                throw new Error('Failed to load order data');
            }
            orders = await response.json();
            
            // Save to localStorage
            saveToStorage('batteryMall_orders', orders);
        }
        
        ordersState.orders = orders;
        ordersState.filteredOrders = [...orders];
        
    } catch (error) {
        console.error('Error loading order data:', error);
        // Use empty array as fallback
        ordersState.orders = [];
        ordersState.filteredOrders = [];
        showNotification('Failed to load order data', 'error');
    }
}

/**
 * Setup event listeners for orders page
 */
function setupOrderEventListeners() {
    // Search input
    const searchInput = getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', debounce(handleOrderSearch, 300));
    }
    
    // Filter selects
    const statusFilter = getElementById('statusFilter');
    const dateFilter = getElementById('dateFilter');
    const priorityFilter = getElementById('priorityFilter');
    
    if (statusFilter) statusFilter.addEventListener('change', handleOrderFilterChange);
    if (dateFilter) dateFilter.addEventListener('change', handleOrderFilterChange);
    if (priorityFilter) priorityFilter.addEventListener('change', handleOrderFilterChange);
    
    // View toggle buttons
    const viewButtons = querySelectorAll('.view-btn');
    viewButtons.forEach(button => {
        button.addEventListener('click', function() {
            changeOrderView(this.dataset.view);
        });
    });
    
    // Order form
    const orderForm = getElementById('orderForm');
    if (orderForm) {
        orderForm.addEventListener('submit', handleOrderFormSubmit);
        setupOrderFormEventListeners();
    }
    
    // Bulk actions
    setupOrderBulkActions();
}

/**
 * Setup order form event listeners
 */
function setupOrderFormEventListeners() {
    // Shipping method change
    const shippingMethod = getElementById('shippingMethod');
    if (shippingMethod) {
        shippingMethod.addEventListener('change', calculateShipping);
    }
    
    // Battery selection change
    const batterySelects = querySelectorAll('.battery-select');
    batterySelects.forEach(select => {
        select.addEventListener('change', function() {
            updateItemPrice(this);
        });
    });
    
    // Quantity change
    const quantityInputs = querySelectorAll('.quantity-input');
    quantityInputs.forEach(input => {
        input.addEventListener('change', function() {
            updateItemTotal(this);
        });
    });
    
    // Load battery options
    loadBatteryOptions();
}

/**
 * Load battery options for order form
 */
async function loadBatteryOptions() {
    try {
        const batteries = loadFromStorage('batteryMall_batteries') || [];
        const batterySelects = querySelectorAll('.battery-select');
        
        const optionsHTML = batteries
            .filter(battery => battery.stock > 0)
            .map(battery => `
                <option value="${battery.id}" data-price="${battery.price}">
                    ${battery.brand} ${battery.model} - ${formatCurrency(battery.price)} (${battery.stock} in stock)
                </option>
            `).join('');
        
        batterySelects.forEach(select => {
            select.innerHTML = '<option value="">Select Battery</option>' + optionsHTML;
        });
        
    } catch (error) {
        handleError(error, 'Load Battery Options');
    }
}

/**
 * Setup order drag and drop
 */
function setupOrderDragDrop() {
    const orderCards = querySelectorAll('.order-card');
    orderCards.forEach(card => {
        card.addEventListener('dragstart', handleOrderDragStart);
        card.addEventListener('dragend', handleOrderDragEnd);
    });
}

// ===== SEARCH AND FILTER FUNCTIONS =====

/**
 * Handle order search
 * @param {Event} event - Input event
 */
function handleOrderSearch(event) {
    ordersState.searchQuery = event.target.value.toLowerCase().trim();
    applyOrderFiltersAndSearch();
}

/**
 * Handle filter changes
 * @param {Event} event - Change event
 */
function handleOrderFilterChange(event) {
    const filterType = event.target.id.replace('Filter', '');
    ordersState.filters[filterType] = event.target.value;
    applyOrderFiltersAndSearch();
}

/**
 * Apply filters, search, and sorting to orders
 */
function applyOrderFiltersAndSearch() {
    let filtered = [...ordersState.orders];
    
    // Apply search
    if (ordersState.searchQuery) {
        filtered = filtered.filter(order => 
            order.id.toLowerCase().includes(ordersState.searchQuery) ||
            order.customerName.toLowerCase().includes(ordersState.searchQuery) ||
            order.customerEmail.toLowerCase().includes(ordersState.searchQuery) ||
            order.items.some(item => 
                item.model.toLowerCase().includes(ordersState.searchQuery) ||
                item.brand.toLowerCase().includes(ordersState.searchQuery)
            )
        );
    }
    
    // Apply filters
    if (ordersState.filters.status) {
        filtered = filtered.filter(order => order.status === ordersState.filters.status);
    }
    
    if (ordersState.filters.priority) {
        filtered = filtered.filter(order => order.priority === ordersState.filters.priority);
    }
    
    if (ordersState.filters.date) {
        const now = new Date();
        filtered = filtered.filter(order => {
            const orderDate = new Date(order.orderDate);
            switch (ordersState.filters.date) {
                case 'today':
                    return orderDate.toDateString() === now.toDateString();
                case 'week':
                    const weekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
                    return orderDate >= weekAgo;
                case 'month':
                    const monthAgo = new Date(now.getTime() - 30 * 24 * 60 * 60 * 1000);
                    return orderDate >= monthAgo;
                default:
                    return true;
            }
        });
    }
    
    // Apply sorting
    filtered.sort((a, b) => {
        switch (ordersState.sortBy) {
            case 'orderId':
                return a.id.localeCompare(b.id);
            case 'customer':
                return a.customerName.localeCompare(b.customerName);
            case 'date':
                return new Date(b.orderDate) - new Date(a.orderDate);
            case 'total':
                return b.total - a.total;
            case 'status':
                return a.status.localeCompare(b.status);
            case 'priority':
                const priorityOrder = { high: 3, medium: 2, low: 1 };
                return priorityOrder[b.priority] - priorityOrder[a.priority];
            default:
                return 0;
        }
    });
    
    ordersState.filteredOrders = filtered;
    ordersState.currentPage = 1; // Reset to first page
    renderOrders();
}

// ===== VIEW FUNCTIONS =====

/**
 * Change order view
 * @param {string} view - View type (kanban, list, calendar)
 */
function changeOrderView(view) {
    ordersState.currentView = view;
    
    // Update view buttons
    const viewButtons = querySelectorAll('.view-btn');
    viewButtons.forEach(button => {
        button.classList.toggle('active', button.dataset.view === view);
    });
    
    // Show/hide view containers
    const kanbanView = getElementById('orderBoard');
    const listView = getElementById('orderListView');
    const calendarView = getElementById('orderCalendarView');
    
    if (kanbanView) kanbanView.style.display = view === 'kanban' ? 'grid' : 'none';
    if (listView) listView.style.display = view === 'list' ? 'block' : 'none';
    if (calendarView) calendarView.style.display = view === 'calendar' ? 'block' : 'none';
    
    renderOrders();
}

/**
 * Render orders based on current view
 */
function renderOrders() {
    if (ordersState.isLoading) {
        return;
    }
    
    switch (ordersState.currentView) {
        case 'kanban':
            renderKanbanView();
            break;
        case 'list':
            renderListView();
            break;
        case 'calendar':
            renderCalendarView();
            break;
    }
    
    updateOrderCounts();
}

/**
 * Render Kanban board view
 */
function renderKanbanView() {
    const statusColumns = {
        pending: getElementById('pendingOrders'),
        processing: getElementById('processingOrders'),
        shipped: getElementById('shippedOrders'),
        delivered: getElementById('deliveredOrders')
    };
    
    // Clear all columns
    Object.values(statusColumns).forEach(column => {
        if (column) column.innerHTML = '';
    });
    
    // Group orders by status
    const ordersByStatus = ordersState.filteredOrders.reduce((acc, order) => {
        if (!acc[order.status]) acc[order.status] = [];
        acc[order.status].push(order);
        return acc;
    }, {});
    
    // Render orders in each column
    Object.keys(statusColumns).forEach(status => {
        const column = statusColumns[status];
        const orders = ordersByStatus[status] || [];
        
        if (column) {
            column.innerHTML = orders.map(order => createOrderCard(order)).join('');
            
            // Setup drag and drop for new cards
            const orderCards = column.querySelectorAll('.order-card');
            orderCards.forEach(card => {
                card.addEventListener('dragstart', handleOrderDragStart);
                card.addEventListener('dragend', handleOrderDragEnd);
            });
        }
    });
}

/**
 * Create order card HTML
 * @param {Object} order - Order object
 * @returns {string} Order card HTML
 */
function createOrderCard(order) {
    const priorityClass = `order-priority ${order.priority}`;
    const itemsText = order.items.length === 1 
        ? `${order.items[0].quantity}x ${order.items[0].model}`
        : `${order.items.length} items`;
    
    return `
        <div class="order-card" draggable="true" data-order-id="${order.id}">
            <div class="order-card-header">
                <span class="order-id">${order.id}</span>
                <span class="${priorityClass}">${order.priority}</span>
            </div>
            
            <div class="order-customer">
                <div class="customer-name">${order.customerName}</div>
                <div class="customer-email">${order.customerEmail}</div>
            </div>
            
            <div class="order-items">
                <h5>Items:</h5>
                <div class="item-list">${itemsText}</div>
            </div>
            
            <div class="order-total">
                <span class="total-label">Total:</span>
                <span class="total-amount">${formatCurrency(order.total)}</span>
            </div>
            
            <div class="order-date">${formatDate(order.orderDate)}</div>
            
            <div class="order-actions">
                <button class="btn-icon" onclick="viewOrderDetails('${order.id}')" title="View Details">
                    <i class="fas fa-eye"></i>
                </button>
                <button class="btn-icon" onclick="editOrder('${order.id}')" title="Edit">
                    <i class="fas fa-edit"></i>
                </button>
            </div>
        </div>
    `;
}

/**
 * Render list view
 */
function renderListView() {
    const tableBody = getElementById('orderTableBody');
    if (!tableBody) return;
    
    // Calculate pagination
    const startIndex = (ordersState.currentPage - 1) * ordersState.itemsPerPage;
    const endIndex = startIndex + ordersState.itemsPerPage;
    const ordersToShow = ordersState.filteredOrders.slice(startIndex, endIndex);
    
    tableBody.innerHTML = ordersToShow.map(order => `
        <tr data-order-id="${order.id}">
            <td><input type="checkbox" class="order-checkbox" value="${order.id}" onchange="handleOrderSelect(this)"></td>
            <td><strong>${order.id}</strong></td>
            <td>${order.customerName}</td>
            <td>${formatDate(order.orderDate)}</td>
            <td>${formatCurrency(order.total)}</td>
            <td><span class="order-status ${order.status}">${order.status}</span></td>
            <td><span class="order-priority ${order.priority}">${order.priority}</span></td>
            <td>
                <button class="btn btn-sm btn-secondary" onclick="viewOrderDetails('${order.id}')">
                    <i class="fas fa-eye"></i>
                </button>
                <button class="btn btn-sm btn-primary" onclick="editOrder('${order.id}')">
                    <i class="fas fa-edit"></i>
                </button>
            </td>
        </tr>
    `).join('');
}

/**
 * Render calendar view
 */
function renderCalendarView() {
    // This would implement a calendar view of orders
    // For now, show a placeholder
    const calendarGrid = getElementById('calendarGrid');
    if (calendarGrid) {
        calendarGrid.innerHTML = `
            <div class="calendar-placeholder">
                <i class="fas fa-calendar-alt"></i>
                <h3>Calendar View</h3>
                <p>Calendar view implementation would show orders by date</p>
            </div>
        `;
    }
}

/**
 * Update order counts in status columns
 */
function updateOrderCounts() {
    const statusCounts = ordersState.filteredOrders.reduce((acc, order) => {
        acc[order.status] = (acc[order.status] || 0) + 1;
        return acc;
    }, {});
    
    // Update count displays
    Object.keys(statusCounts).forEach(status => {
        const countElement = getElementById(`${status}Count`);
        if (countElement) {
            countElement.textContent = statusCounts[status] || 0;
        }
    });
}

// ===== ORDER CRUD OPERATIONS =====

/**
 * Show new order modal
 */
function showNewOrderModal() {
    const modal = getElementById('orderModal');
    const modalTitle = getElementById('orderModalTitle');
    const orderForm = getElementById('orderForm');
    
    if (modal && modalTitle && orderForm) {
        modalTitle.innerHTML = '<i class="fas fa-plus"></i> New Order';
        resetForm(orderForm);
        
        // Set default values
        const today = new Date().toISOString().split('T')[0];
        const orderDate = getElementById('orderDate');
        if (orderDate) orderDate.value = today;
        
        showModal('orderModal');
        loadBatteryOptions();
    }
}

/**
 * Edit order
 * @param {string} orderId - Order ID to edit
 */
function editOrder(orderId) {
    const order = ordersState.orders.find(o => o.id === orderId);
    if (!order) {
        showNotification('Order not found', 'error');
        return;
    }
    
    const modal = getElementById('orderModal');
    const modalTitle = getElementById('orderModalTitle');
    
    if (modal && modalTitle) {
        modalTitle.innerHTML = '<i class="fas fa-edit"></i> Edit Order';
        populateOrderForm(order);
        showModal('orderModal');
    }
}

/**
 * View order details
 * @param {string} orderId - Order ID to view
 */
function viewOrderDetails(orderId) {
    const order = ordersState.orders.find(o => o.id === orderId);
    if (!order) {
        showNotification('Order not found', 'error');
        return;
    }
    
    const modal = getElementById('orderDetailsModal');
    const content = getElementById('orderDetailsContent');
    
    if (modal && content) {
        content.innerHTML = createOrderDetailsHTML(order);
        showModal('orderDetailsModal');
    }
}

/**
 * Create order details HTML
 * @param {Object} order - Order object
 * @returns {string} Order details HTML
 */
function createOrderDetailsHTML(order) {
    return `
        <div class="order-details">
            <div class="order-header">
                <h3>${order.id}</h3>
                <span class="order-status ${order.status}">${order.status}</span>
            </div>
            
            <div class="order-info-grid">
                <div class="info-section">
                    <h4>Customer Information</h4>
                    <p><strong>Name:</strong> ${order.customerName}</p>
                    <p><strong>Email:</strong> ${order.customerEmail}</p>
                    <p><strong>Phone:</strong> ${order.customerPhone}</p>
                </div>
                
                <div class="info-section">
                    <h4>Order Details</h4>
                    <p><strong>Date:</strong> ${formatDate(order.orderDate)}</p>
                    <p><strong>Priority:</strong> ${order.priority}</p>
                    <p><strong>Payment:</strong> ${order.paymentStatus}</p>
                    ${order.trackingNumber ? `<p><strong>Tracking:</strong> ${order.trackingNumber}</p>` : ''}
                </div>
            </div>
            
            <div class="order-items-section">
                <h4>Items</h4>
                <table class="items-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${order.items.map(item => `
                            <tr>
                                <td>${item.brand} ${item.model}</td>
                                <td>${item.quantity}</td>
                                <td>${formatCurrency(item.unitPrice)}</td>
                                <td>${formatCurrency(item.totalPrice)}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            </div>
            
            <div class="order-summary">
                <div class="summary-row">
                    <span>Subtotal:</span>
                    <span>${formatCurrency(order.subtotal)}</span>
                </div>
                <div class="summary-row">
                    <span>Shipping:</span>
                    <span>${formatCurrency(order.shipping)}</span>
                </div>
                <div class="summary-row">
                    <span>Tax:</span>
                    <span>${formatCurrency(order.tax)}</span>
                </div>
                <div class="summary-row total">
                    <span>Total:</span>
                    <span>${formatCurrency(order.total)}</span>
                </div>
            </div>
            
            ${order.notes ? `
                <div class="order-notes">
                    <h4>Notes</h4>
                    <p>${order.notes}</p>
                </div>
            ` : ''}
        </div>
    `;
}

/**
 * Handle order form submission
 * @param {Event} event - Form submit event
 */
async function handleOrderFormSubmit(event) {
    event.preventDefault();
    
    if (ordersState.isLoading) return;
    
    try {
        ordersState.isLoading = true;
        showLoading('Saving order...');
        
        const form = event.target;
        const formData = serializeForm(form);
        
        // Validate form data
        if (!validateOrderForm(formData)) {
            return;
        }
        
        // Create order object
        const order = createOrderFromForm(formData);
        
        // Simulate API delay
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        // Check if editing or adding
        const existingIndex = ordersState.orders.findIndex(o => o.id === order.id);
        
        if (existingIndex >= 0) {
            // Update existing order
            ordersState.orders[existingIndex] = order;
            showNotification('Order updated successfully', 'success');
        } else {
            // Add new order
            order.id = generateOrderId();
            ordersState.orders.push(order);
            showNotification('Order created successfully', 'success');
        }
        
        // Save to localStorage
        saveToStorage('batteryMall_orders', ordersState.orders);
        
        // Refresh display
        applyOrderFiltersAndSearch();
        
        // Close modal
        closeOrderModal();
        
    } catch (error) {
        handleError(error, 'Save Order');
        showNotification('Failed to save order', 'error');
    } finally {
        ordersState.isLoading = false;
        hideLoading();
    }
}

/**
 * Generate order ID
 * @returns {string} Order ID
 */
function generateOrderId() {
    const year = new Date().getFullYear();
    const orderNumber = String(ordersState.orders.length + 1).padStart(3, '0');
    return `ORD-${year}-${orderNumber}`;
}

/**
 * Close order modal
 */
function closeOrderModal() {
    hideModal('orderModal');
}

/**
 * Close order details modal
 */
function closeOrderDetailsModal() {
    hideModal('orderDetailsModal');
}

// ===== UTILITY FUNCTIONS =====

/**
 * Update item price when battery is selected
 * @param {HTMLSelectElement} select - Battery select element
 */
function updateItemPrice(select) {
    const selectedOption = select.options[select.selectedIndex];
    const price = selectedOption.dataset.price || 0;
    
    const priceInput = select.closest('.order-item').querySelector('.price-input');
    if (priceInput) {
        priceInput.value = price;
        updateItemTotal(priceInput);
    }
}

/**
 * Update item total when quantity changes
 * @param {HTMLInputElement} input - Quantity or price input
 */
function updateItemTotal(input) {
    const orderItem = input.closest('.order-item');
    const quantityInput = orderItem.querySelector('.quantity-input');
    const priceInput = orderItem.querySelector('.price-input');
    const totalInput = orderItem.querySelector('.total-input');
    
    if (quantityInput && priceInput && totalInput) {
        const quantity = parseInt(quantityInput.value) || 0;
        const price = parseFloat(priceInput.value) || 0;
        const total = quantity * price;
        
        totalInput.value = total.toFixed(2);
        updateOrderSummary();
    }
}

/**
 * Update order summary totals
 */
function updateOrderSummary() {
    const totalInputs = querySelectorAll('.total-input');
    let subtotal = 0;
    
    totalInputs.forEach(input => {
        subtotal += parseFloat(input.value) || 0;
    });
    
    const shipping = parseFloat(getElementById('orderShipping')?.textContent.replace('$', '')) || 0;
    const taxRate = 0.085; // 8.5% tax
    const tax = subtotal * taxRate;
    const total = subtotal + shipping + tax;
    
    // Update display
    const subtotalElement = getElementById('orderSubtotal');
    const taxElement = getElementById('orderTax');
    const totalElement = getElementById('orderTotal');
    
    if (subtotalElement) subtotalElement.textContent = formatCurrency(subtotal);
    if (taxElement) taxElement.textContent = formatCurrency(tax);
    if (totalElement) totalElement.textContent = formatCurrency(total);
}

/**
 * Calculate shipping cost
 */
function calculateShipping() {
    const shippingMethod = getElementById('shippingMethod');
    const shippingElement = getElementById('orderShipping');
    const expectedDelivery = getElementById('expectedDelivery');
    
    if (!shippingMethod || !shippingElement) return;
    
    const shippingCosts = {
        'standard': { cost: 9.99, days: 7 },
        'express': { cost: 19.99, days: 3 },
        'overnight': { cost: 39.99, days: 1 }
    };
    
    const selected = shippingCosts[shippingMethod.value];
    if (selected) {
        shippingElement.textContent = formatCurrency(selected.cost);
        
        // Calculate expected delivery date
        if (expectedDelivery) {
            const deliveryDate = new Date();
            deliveryDate.setDate(deliveryDate.getDate() + selected.days);
            expectedDelivery.value = deliveryDate.toISOString().split('T')[0];
        }
        
        updateOrderSummary();
    }
}

/**
 * Add order item row
 */
function addOrderItem() {
    const orderItems = getElementById('orderItems');
    if (!orderItems) return;
    
    const newItem = document.createElement('div');
    newItem.className = 'order-item';
    newItem.innerHTML = `
        <div class="item-select">
            <label>Battery *</label>
            <select class="battery-select" name="batteryId[]" required onchange="updateItemPrice(this)">
                <option value="">Select Battery</option>
            </select>
        </div>
        <div class="item-quantity">
            <label>Quantity *</label>
            <input type="number" class="quantity-input" name="quantity[]" min="1" value="1" required onchange="updateItemTotal(this)">
        </div>
        <div class="item-price">
            <label>Unit Price</label>
            <input type="number" class="price-input" name="unitPrice[]" readonly>
        </div>
        <div class="item-total">
            <label>Total</label>
            <input type="number" class="total-input" name="itemTotal[]" readonly>
        </div>
        <div class="item-actions">
            <button type="button" class="btn-icon btn-danger" onclick="removeOrderItem(this)">
                <i class="fas fa-trash"></i>
            </button>
        </div>
    `;
    
    orderItems.appendChild(newItem);
    loadBatteryOptions();
}

/**
 * Remove order item row
 * @param {HTMLButtonElement} button - Remove button
 */
function removeOrderItem(button) {
    const orderItem = button.closest('.order-item');
    const orderItems = getElementById('orderItems');
    
    if (orderItems && orderItems.children.length > 1) {
        orderItem.remove();
        updateOrderSummary();
    } else {
        showNotification('At least one item is required', 'warning');
    }
}

// ===== BULK OPERATIONS =====

/**
 * Setup bulk action event listeners
 */
function setupOrderBulkActions() {
    const selectAllCheckbox = getElementById('selectAll');
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', handleOrderSelectAll);
    }
}

/**
 * Handle select all orders
 * @param {Event} event - Change event
 */
function handleOrderSelectAll(event) {
    const isChecked = event.target.checked;
    const checkboxes = querySelectorAll('.order-checkbox');
    
    checkboxes.forEach(checkbox => {
        checkbox.checked = isChecked;
        handleOrderSelect(checkbox);
    });
}

/**
 * Handle individual order selection
 * @param {HTMLInputElement} checkbox - Checkbox element
 */
function handleOrderSelect(checkbox) {
    const orderId = checkbox.value;
    
    if (checkbox.checked) {
        ordersState.selectedOrders.add(orderId);
    } else {
        ordersState.selectedOrders.delete(orderId);
    }
    
    updateOrderBulkActionButtons();
}

/**
 * Update bulk action buttons
 */
function updateOrderBulkActionButtons() {
    const selectedCount = ordersState.selectedOrders.size;
    const bulkButtons = querySelectorAll('#bulkUpdateBtn, #bulkDeleteBtn');
    
    bulkButtons.forEach(button => {
        button.disabled = selectedCount === 0;
    });
}

// ===== EXPORT FUNCTIONALITY =====

/**
 * Export orders data
 */
function exportOrders() {
    try {
        const exportData = {
            orders: ordersState.orders,
            exportDate: new Date().toISOString(),
            totalOrders: ordersState.orders.length,
            statusBreakdown: ordersState.orders.reduce((acc, order) => {
                acc[order.status] = (acc[order.status] || 0) + 1;
                return acc;
            }, {})
        };
        
        const filename = `orders_export_${new Date().toISOString().split('T')[0]}.json`;
        exportAsJSON(exportData, filename);
        
    } catch (error) {
        handleError(error, 'Export Orders');
    }
}

// Make functions available globally
window.showNewOrderModal = showNewOrderModal;
window.editOrder = editOrder;
window.viewOrderDetails = viewOrderDetails;
window.closeOrderModal = closeOrderModal;
window.closeOrderDetailsModal = closeOrderDetailsModal;
window.exportOrders = exportOrders;
window.clearSearch = () => {
    const searchInput = getElementById('searchInput');
    if (searchInput) searchInput.value = '';
    ordersState.searchQuery = '';
    applyOrderFiltersAndSearch();
};
window.changeOrderView = changeOrderView;
window.updateItemPrice = updateItemPrice;
window.updateItemTotal = updateItemTotal;
window.calculateShipping = calculateShipping;
window.addOrderItem = addOrderItem;
window.removeOrderItem = removeOrderItem;
window.handleOrderSelect = handleOrderSelect;
