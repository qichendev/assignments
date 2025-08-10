/**
 * BATTERY MALL MANAGEMENT - DRAG AND DROP MODULE
 * Handles drag and drop functionality for orders and inventory management
 */

// ===== DRAG AND DROP STATE =====
let dragDropState = {
    draggedElement: null,
    draggedData: null,
    dropZones: new Map(),
    isDragging: false,
    dragStartPosition: { x: 0, y: 0 },
    dragOffset: { x: 0, y: 0 }
};

// ===== INITIALIZATION =====
document.addEventListener('DOMContentLoaded', function() {
    initializeDragDrop();
});

/**
 * Initialize drag and drop functionality
 */
function initializeDragDrop() {
    try {
        setupDragDropEventListeners();
        setupDropZones();
        console.log('Drag and drop module initialized');
    } catch (error) {
        handleError(error, 'Drag Drop Initialization');
    }
}

/**
 * Setup global drag and drop event listeners
 */
function setupDragDropEventListeners() {
    // Prevent default drag behavior on images and other elements
    document.addEventListener('dragstart', function(e) {
        if (!e.target.hasAttribute('draggable') || e.target.getAttribute('draggable') === 'false') {
            e.preventDefault();
        }
    });
    
    // Global drag over handler
    document.addEventListener('dragover', function(e) {
        e.preventDefault();
    });
    
    // Global drop handler
    document.addEventListener('drop', function(e) {
        e.preventDefault();
        if (!isValidDropZone(e.target)) {
            resetDragState();
        }
    });
    
    // Touch events for mobile drag and drop
    document.addEventListener('touchstart', handleTouchStart, { passive: false });
    document.addEventListener('touchmove', handleTouchMove, { passive: false });
    document.addEventListener('touchend', handleTouchEnd, { passive: false });
}

/**
 * Setup drop zones
 */
function setupDropZones() {
    // Order status columns
    const orderColumns = querySelectorAll('.column-content');
    orderColumns.forEach(column => {
        registerDropZone(column, 'order-status', column.id);
    });
    
    // Category items for battery categorization
    const categoryItems = querySelectorAll('.category-item');
    categoryItems.forEach(item => {
        registerDropZone(item, 'battery-category', item.dataset.category);
    });
}

/**
 * Register a drop zone
 * @param {HTMLElement} element - Drop zone element
 * @param {string} type - Drop zone type
 * @param {string} data - Drop zone data
 */
function registerDropZone(element, type, data) {
    dragDropState.dropZones.set(element, { type, data });
    
    // Add drop zone event listeners
    element.addEventListener('dragover', handleDragOver);
    element.addEventListener('dragenter', handleDragEnter);
    element.addEventListener('dragleave', handleDragLeave);
    element.addEventListener('drop', handleDrop);
}

// ===== BATTERY DRAG AND DROP =====

/**
 * Handle battery drag start
 * @param {DragEvent} event - Drag start event
 */
function handleBatteryDragStart(event) {
    try {
        const batteryCard = event.target.closest('.battery-card');
        if (!batteryCard) return;
        
        const batteryId = batteryCard.dataset.batteryId;
        const battery = getBatteryById(batteryId);
        
        if (!battery) {
            event.preventDefault();
            return;
        }
        
        // Set drag data
        dragDropState.draggedElement = batteryCard;
        dragDropState.draggedData = {
            type: 'battery',
            battery: battery
        };
        dragDropState.isDragging = true;
        
        // Store initial position
        const rect = batteryCard.getBoundingClientRect();
        dragDropState.dragStartPosition = {
            x: event.clientX - rect.left,
            y: event.clientY - rect.top
        };
        
        // Set drag effect
        event.dataTransfer.effectAllowed = 'move';
        event.dataTransfer.setData('text/plain', batteryId);
        
        // Add dragging class
        batteryCard.classList.add('dragging');
        
        // Create drag image
        createDragImage(event, batteryCard);
        
        console.log('Battery drag started:', battery.model);
        
    } catch (error) {
        handleError(error, 'Battery Drag Start');
    }
}

/**
 * Handle battery drag end
 * @param {DragEvent} event - Drag end event
 */
function handleBatteryDragEnd(event) {
    try {
        const batteryCard = event.target.closest('.battery-card');
        if (batteryCard) {
            batteryCard.classList.remove('dragging');
        }
        
        // Clean up drag state
        resetDragState();
        
        console.log('Battery drag ended');
        
    } catch (error) {
        handleError(error, 'Battery Drag End');
    }
}

/**
 * Handle drop on category
 * @param {DragEvent} event - Drop event
 */
function dropBatteryOnCategory(event) {
    event.preventDefault();
    
    try {
        const categoryItem = event.currentTarget;
        const newCategory = categoryItem.dataset.category;
        
        if (!dragDropState.draggedData || dragDropState.draggedData.type !== 'battery') {
            return;
        }
        
        const battery = dragDropState.draggedData.battery;
        const oldCategory = battery.category;
        
        if (newCategory === oldCategory) {
            showNotification('Battery is already in this category', 'info');
            return;
        }
        
        // Update battery category
        updateBatteryCategory(battery.id, newCategory);
        
        // Show success message
        showNotification(`${battery.model} moved to ${newCategory} category`, 'success');
        
        // Visual feedback
        categoryItem.classList.add('drop-success');
        setTimeout(() => {
            categoryItem.classList.remove('drop-success');
        }, 1000);
        
    } catch (error) {
        handleError(error, 'Drop Battery on Category');
    } finally {
        // Clean up drag state
        resetDragState();
        
        // Remove drag over effects
        const categoryItems = querySelectorAll('.category-item');
        categoryItems.forEach(item => {
            item.classList.remove('drag-over');
        });
    }
}

/**
 * Update battery category
 * @param {string} batteryId - Battery ID
 * @param {string} newCategory - New category
 */
function updateBatteryCategory(batteryId, newCategory) {
    try {
        // Update in inventory state if available
        if (typeof inventoryState !== 'undefined' && inventoryState.batteries) {
            const battery = inventoryState.batteries.find(b => b.id === batteryId);
            if (battery) {
                battery.category = newCategory;
                battery.lastUpdated = new Date().toISOString().split('T')[0];
                
                // Save to storage
                saveToStorage('batteryMall_batteries', inventoryState.batteries);
                
                // Refresh display
                if (typeof applyFiltersAndSearch === 'function') {
                    applyFiltersAndSearch();
                }
                
                if (typeof updateCategoryCounts === 'function') {
                    updateCategoryCounts();
                }
            }
        }
    } catch (error) {
        handleError(error, 'Update Battery Category');
    }
}

// ===== ORDER DRAG AND DROP =====

/**
 * Handle order drag start
 * @param {DragEvent} event - Drag start event
 */
function handleOrderDragStart(event) {
    try {
        const orderCard = event.target.closest('.order-card');
        if (!orderCard) return;
        
        const orderId = orderCard.dataset.orderId;
        
        // Set drag data
        dragDropState.draggedElement = orderCard;
        dragDropState.draggedData = {
            type: 'order',
            orderId: orderId,
            currentStatus: orderCard.closest('.column-content').id.replace('Orders', '').toLowerCase()
        };
        dragDropState.isDragging = true;
        
        // Set drag effect
        event.dataTransfer.effectAllowed = 'move';
        event.dataTransfer.setData('text/plain', orderId);
        
        // Add dragging class
        orderCard.classList.add('dragging');
        
        // Create drag image
        createDragImage(event, orderCard);
        
        console.log('Order drag started:', orderId);
        
    } catch (error) {
        handleError(error, 'Order Drag Start');
    }
}

/**
 * Handle order drag end
 * @param {DragEvent} event - Drag end event
 */
function handleOrderDragEnd(event) {
    try {
        const orderCard = event.target.closest('.order-card');
        if (orderCard) {
            orderCard.classList.remove('dragging');
        }
        
        // Clean up drag state
        resetDragState();
        
        console.log('Order drag ended');
        
    } catch (error) {
        handleError(error, 'Order Drag End');
    }
}

/**
 * Handle drop order on status column
 * @param {DragEvent} event - Drop event
 */
function dropOrder(event) {
    event.preventDefault();
    
    try {
        const columnContent = event.currentTarget;
        const newStatus = getStatusFromColumnId(columnContent.id);
        
        if (!dragDropState.draggedData || dragDropState.draggedData.type !== 'order') {
            return;
        }
        
        const { orderId, currentStatus } = dragDropState.draggedData;
        
        if (newStatus === currentStatus) {
            return; // No change needed
        }
        
        // Validate status transition
        if (!isValidStatusTransition(currentStatus, newStatus)) {
            showNotification(`Cannot move order from ${currentStatus} to ${newStatus}`, 'error');
            return;
        }
        
        // Update order status
        updateOrderStatus(orderId, newStatus);
        
        // Move the order card to new column
        const orderCard = dragDropState.draggedElement;
        if (orderCard) {
            columnContent.appendChild(orderCard);
            
            // Update order counts
            updateOrderCounts();
            
            // Show success message
            showNotification(`Order ${orderId} moved to ${newStatus}`, 'success');
            
            // Visual feedback
            columnContent.classList.add('drop-success');
            setTimeout(() => {
                columnContent.classList.remove('drop-success');
            }, 1000);
        }
        
    } catch (error) {
        handleError(error, 'Drop Order');
    } finally {
        // Clean up drag state
        resetDragState();
        
        // Remove drag over effects
        const columns = querySelectorAll('.column-content');
        columns.forEach(column => {
            column.classList.remove('drag-over');
        });
    }
}

/**
 * Get status from column ID
 * @param {string} columnId - Column element ID
 * @returns {string} Status name
 */
function getStatusFromColumnId(columnId) {
    const statusMap = {
        'pendingOrders': 'pending',
        'processingOrders': 'processing',
        'shippedOrders': 'shipped',
        'deliveredOrders': 'delivered'
    };
    
    return statusMap[columnId] || 'pending';
}

/**
 * Validate status transition
 * @param {string} currentStatus - Current order status
 * @param {string} newStatus - New order status
 * @returns {boolean} Whether transition is valid
 */
function isValidStatusTransition(currentStatus, newStatus) {
    const validTransitions = {
        'pending': ['processing', 'cancelled'],
        'processing': ['shipped', 'cancelled'],
        'shipped': ['delivered'],
        'delivered': [], // Final state
        'cancelled': [] // Final state
    };
    
    return validTransitions[currentStatus]?.includes(newStatus) || false;
}

/**
 * Update order status
 * @param {string} orderId - Order ID
 * @param {string} newStatus - New status
 */
function updateOrderStatus(orderId, newStatus) {
    try {
        // Update in orders state if available
        if (typeof ordersState !== 'undefined' && ordersState.orders) {
            const order = ordersState.orders.find(o => o.id === orderId);
            if (order) {
                order.status = newStatus;
                order.lastUpdated = new Date().toISOString();
                
                // Add status-specific updates
                if (newStatus === 'shipped' && !order.trackingNumber) {
                    order.trackingNumber = generateTrackingNumber();
                }
                
                if (newStatus === 'delivered') {
                    order.deliveredDate = new Date().toISOString();
                }
                
                // Save to storage
                saveToStorage('batteryMall_orders', ordersState.orders);
            }
        }
    } catch (error) {
        handleError(error, 'Update Order Status');
    }
}

/**
 * Generate tracking number
 * @returns {string} Tracking number
 */
function generateTrackingNumber() {
    return 'TRK' + Math.random().toString(36).substr(2, 9).toUpperCase();
}

/**
 * Update order counts in columns
 */
function updateOrderCounts() {
    try {
        const statusCounts = {
            pending: 0,
            processing: 0,
            shipped: 0,
            delivered: 0
        };
        
        // Count orders in each column
        Object.keys(statusCounts).forEach(status => {
            const column = getElementById(`${status}Orders`);
            if (column) {
                const orderCards = column.querySelectorAll('.order-card');
                statusCounts[status] = orderCards.length;
                
                // Update count display
                const countElement = getElementById(`${status}Count`);
                if (countElement) {
                    countElement.textContent = statusCounts[status];
                }
            }
        });
        
    } catch (error) {
        handleError(error, 'Update Order Counts');
    }
}

// ===== DRAG AND DROP EVENT HANDLERS =====

/**
 * Handle drag over
 * @param {DragEvent} event - Drag over event
 */
function handleDragOver(event) {
    event.preventDefault();
    
    if (!dragDropState.isDragging) return;
    
    const dropZone = dragDropState.dropZones.get(event.currentTarget);
    if (dropZone && isValidDrop(dropZone)) {
        event.dataTransfer.dropEffect = 'move';
    } else {
        event.dataTransfer.dropEffect = 'none';
    }
}

/**
 * Handle drag enter
 * @param {DragEvent} event - Drag enter event
 */
function handleDragEnter(event) {
    event.preventDefault();
    
    if (!dragDropState.isDragging) return;
    
    const dropZone = dragDropState.dropZones.get(event.currentTarget);
    if (dropZone && isValidDrop(dropZone)) {
        event.currentTarget.classList.add('drag-over');
    }
}

/**
 * Handle drag leave
 * @param {DragEvent} event - Drag leave event
 */
function handleDragLeave(event) {
    // Only remove drag-over if we're actually leaving the element
    if (!event.currentTarget.contains(event.relatedTarget)) {
        event.currentTarget.classList.remove('drag-over');
    }
}

/**
 * Handle drop
 * @param {DragEvent} event - Drop event
 */
function handleDrop(event) {
    event.preventDefault();
    
    const dropZone = dragDropState.dropZones.get(event.currentTarget);
    if (!dropZone || !isValidDrop(dropZone)) {
        return;
    }
    
    // Route to appropriate drop handler
    if (dropZone.type === 'order-status') {
        dropOrder(event);
    } else if (dropZone.type === 'battery-category') {
        dropBatteryOnCategory(event);
    }
    
    // Remove drag over class
    event.currentTarget.classList.remove('drag-over');
}

/**
 * Check if drop is valid
 * @param {Object} dropZone - Drop zone configuration
 * @returns {boolean} Whether drop is valid
 */
function isValidDrop(dropZone) {
    if (!dragDropState.draggedData) return false;
    
    const { type } = dragDropState.draggedData;
    
    if (dropZone.type === 'order-status' && type === 'order') {
        return true;
    }
    
    if (dropZone.type === 'battery-category' && type === 'battery') {
        return true;
    }
    
    return false;
}

/**
 * Check if element is a valid drop zone
 * @param {HTMLElement} element - Element to check
 * @returns {boolean} Whether element is a valid drop zone
 */
function isValidDropZone(element) {
    return dragDropState.dropZones.has(element) || 
           element.closest('.column-content') || 
           element.closest('.category-item');
}

// ===== TOUCH SUPPORT FOR MOBILE =====

let touchState = {
    startX: 0,
    startY: 0,
    currentX: 0,
    currentY: 0,
    isDragging: false,
    draggedElement: null,
    ghostElement: null
};

/**
 * Handle touch start
 * @param {TouchEvent} event - Touch start event
 */
function handleTouchStart(event) {
    const target = event.target.closest('[draggable="true"]');
    if (!target) return;
    
    const touch = event.touches[0];
    touchState.startX = touch.clientX;
    touchState.startY = touch.clientY;
    touchState.currentX = touch.clientX;
    touchState.currentY = touch.clientY;
    touchState.draggedElement = target;
    
    // Prevent scrolling while dragging
    event.preventDefault();
}

/**
 * Handle touch move
 * @param {TouchEvent} event - Touch move event
 */
function handleTouchMove(event) {
    if (!touchState.draggedElement) return;
    
    const touch = event.touches[0];
    touchState.currentX = touch.clientX;
    touchState.currentY = touch.clientY;
    
    const deltaX = touchState.currentX - touchState.startX;
    const deltaY = touchState.currentY - touchState.startY;
    
    // Start dragging if moved enough
    if (!touchState.isDragging && (Math.abs(deltaX) > 10 || Math.abs(deltaY) > 10)) {
        touchState.isDragging = true;
        startTouchDrag();
    }
    
    if (touchState.isDragging) {
        updateTouchDrag();
        
        // Find element under touch point
        const elementBelow = document.elementFromPoint(touchState.currentX, touchState.currentY);
        const dropZone = findDropZone(elementBelow);
        
        // Update drop zone highlights
        updateDropZoneHighlights(dropZone);
    }
    
    event.preventDefault();
}

/**
 * Handle touch end
 * @param {TouchEvent} event - Touch end event
 */
function handleTouchEnd(event) {
    if (!touchState.isDragging) {
        touchState.draggedElement = null;
        return;
    }
    
    // Find drop target
    const elementBelow = document.elementFromPoint(touchState.currentX, touchState.currentY);
    const dropZone = findDropZone(elementBelow);
    
    if (dropZone) {
        // Simulate drop event
        const dropEvent = new Event('drop', { bubbles: true });
        dropEvent.currentTarget = dropZone;
        handleDrop(dropEvent);
    }
    
    // Clean up touch drag
    endTouchDrag();
}

/**
 * Start touch drag
 */
function startTouchDrag() {
    if (!touchState.draggedElement) return;
    
    // Create ghost element
    touchState.ghostElement = touchState.draggedElement.cloneNode(true);
    touchState.ghostElement.classList.add('touch-ghost');
    touchState.ghostElement.style.position = 'fixed';
    touchState.ghostElement.style.pointerEvents = 'none';
    touchState.ghostElement.style.zIndex = '9999';
    touchState.ghostElement.style.opacity = '0.8';
    touchState.ghostElement.style.transform = 'rotate(5deg)';
    
    document.body.appendChild(touchState.ghostElement);
    
    // Add dragging class to original element
    touchState.draggedElement.classList.add('dragging');
    
    // Set up drag data
    if (touchState.draggedElement.classList.contains('order-card')) {
        const orderId = touchState.draggedElement.dataset.orderId;
        dragDropState.draggedData = {
            type: 'order',
            orderId: orderId,
            currentStatus: touchState.draggedElement.closest('.column-content').id.replace('Orders', '').toLowerCase()
        };
    } else if (touchState.draggedElement.classList.contains('battery-card')) {
        const batteryId = touchState.draggedElement.dataset.batteryId;
        const battery = getBatteryById(batteryId);
        dragDropState.draggedData = {
            type: 'battery',
            battery: battery
        };
    }
    
    dragDropState.isDragging = true;
}

/**
 * Update touch drag position
 */
function updateTouchDrag() {
    if (!touchState.ghostElement) return;
    
    const rect = touchState.draggedElement.getBoundingClientRect();
    touchState.ghostElement.style.left = (touchState.currentX - rect.width / 2) + 'px';
    touchState.ghostElement.style.top = (touchState.currentY - rect.height / 2) + 'px';
}

/**
 * End touch drag
 */
function endTouchDrag() {
    // Remove ghost element
    if (touchState.ghostElement) {
        touchState.ghostElement.remove();
        touchState.ghostElement = null;
    }
    
    // Remove dragging class
    if (touchState.draggedElement) {
        touchState.draggedElement.classList.remove('dragging');
    }
    
    // Clear drop zone highlights
    updateDropZoneHighlights(null);
    
    // Reset state
    touchState.isDragging = false;
    touchState.draggedElement = null;
    resetDragState();
}

/**
 * Find drop zone element
 * @param {HTMLElement} element - Element to check
 * @returns {HTMLElement|null} Drop zone element
 */
function findDropZone(element) {
    if (!element) return null;
    
    // Check if element itself is a drop zone
    if (dragDropState.dropZones.has(element)) {
        return element;
    }
    
    // Check parent elements
    let parent = element.parentElement;
    while (parent) {
        if (dragDropState.dropZones.has(parent)) {
            return parent;
        }
        parent = parent.parentElement;
    }
    
    return null;
}

/**
 * Update drop zone highlights
 * @param {HTMLElement|null} activeDropZone - Currently active drop zone
 */
function updateDropZoneHighlights(activeDropZone) {
    // Remove all highlights
    dragDropState.dropZones.forEach((config, element) => {
        element.classList.remove('drag-over');
    });
    
    // Add highlight to active drop zone
    if (activeDropZone) {
        const dropZone = dragDropState.dropZones.get(activeDropZone);
        if (dropZone && isValidDrop(dropZone)) {
            activeDropZone.classList.add('drag-over');
        }
    }
}

// ===== UTILITY FUNCTIONS =====

/**
 * Create custom drag image
 * @param {DragEvent} event - Drag event
 * @param {HTMLElement} element - Element being dragged
 */
function createDragImage(event, element) {
    try {
        // Create a canvas for the drag image
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        const rect = element.getBoundingClientRect();
        
        canvas.width = rect.width;
        canvas.height = rect.height;
        
        // Set canvas styles
        ctx.fillStyle = 'rgba(255, 255, 255, 0.9)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        ctx.strokeStyle = '#2563eb';
        ctx.lineWidth = 2;
        ctx.strokeRect(0, 0, canvas.width, canvas.height);
        
        // Add text
        ctx.fillStyle = '#1e293b';
        ctx.font = '14px Inter, sans-serif';
        ctx.textAlign = 'center';
        ctx.fillText('Moving...', canvas.width / 2, canvas.height / 2);
        
        // Set as drag image
        event.dataTransfer.setDragImage(canvas, canvas.width / 2, canvas.height / 2);
        
    } catch (error) {
        console.warn('Could not create custom drag image:', error);
    }
}

/**
 * Reset drag state
 */
function resetDragState() {
    dragDropState.draggedElement = null;
    dragDropState.draggedData = null;
    dragDropState.isDragging = false;
    dragDropState.dragStartPosition = { x: 0, y: 0 };
    dragDropState.dragOffset = { x: 0, y: 0 };
}

/**
 * Allow drop (used in HTML ondragover)
 * @param {DragEvent} event - Drag over event
 */
function allowDrop(event) {
    event.preventDefault();
}

// ===== GLOBAL FUNCTIONS =====

// Make functions available globally for HTML event handlers
window.handleBatteryDragStart = handleBatteryDragStart;
window.handleBatteryDragEnd = handleBatteryDragEnd;
window.dropBatteryOnCategory = dropBatteryOnCategory;
window.handleOrderDragStart = handleOrderDragStart;
window.handleOrderDragEnd = handleOrderDragEnd;
window.dropOrder = dropOrder;
window.allowDrop = allowDrop;
