/**
 * BATTERY MALL MANAGEMENT - INVENTORY MODULE
 * Handles battery inventory management, CRUD operations, and UI interactions
 */

// ===== INVENTORY STATE =====
let inventoryState = {
    batteries: [],
    filteredBatteries: [],
    currentView: 'grid',
    currentPage: 1,
    itemsPerPage: 20,
    searchQuery: '',
    filters: {
        category: '',
        type: '',
        stock: ''
    },
    sortBy: 'name',
    selectedBatteries: new Set(),
    isLoading: false
};

// ===== INITIALIZATION =====
document.addEventListener('DOMContentLoaded', function() {
    if (window.location.pathname.includes('inventory.html')) {
        initializeInventory();
    }
});

/**
 * Initialize inventory module
 */
async function initializeInventory() {
    try {
        // Check authentication
        if (!isAuthenticated()) {
            navigateTo('index.html');
            return;
        }
        
        showLoading('Loading inventory...');
        
        // Load battery data
        await loadBatteryData();
        
        // Setup event listeners
        setupInventoryEventListeners();
        
        // Render initial view
        renderInventory();
        
        // Update category counts
        updateCategoryCounts();
        
        hideLoading();
        console.log('Inventory module initialized');
        
    } catch (error) {
        handleError(error, 'Inventory Initialization');
        hideLoading();
    }
}

/**
 * Load battery data from JSON file or localStorage
 */
async function loadBatteryData() {
    try {
        // Try to load from localStorage first
        let batteries = loadFromStorage('batteryMall_batteries');
        
        if (!batteries || batteries.length === 0) {
            // Load from JSON file
            const response = await fetch('data/batteries.json');
            if (!response.ok) {
                throw new Error('Failed to load battery data');
            }
            batteries = await response.json();
            
            // Save to localStorage
            saveToStorage('batteryMall_batteries', batteries);
        }
        
        inventoryState.batteries = batteries;
        inventoryState.filteredBatteries = [...batteries];
        
    } catch (error) {
        console.error('Error loading battery data:', error);
        // Use empty array as fallback
        inventoryState.batteries = [];
        inventoryState.filteredBatteries = [];
        showNotification('Failed to load inventory data', 'error');
    }
}

/**
 * Setup event listeners for inventory page
 */
function setupInventoryEventListeners() {
    // Search input
    const searchInput = getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('input', debounce(handleSearch, 300));
    }
    
    // Filter selects
    const categoryFilter = getElementById('categoryFilter');
    const typeFilter = getElementById('typeFilter');
    const stockFilter = getElementById('stockFilter');
    const sortSelect = getElementById('sortBy');
    
    if (categoryFilter) categoryFilter.addEventListener('change', handleFilterChange);
    if (typeFilter) typeFilter.addEventListener('change', handleFilterChange);
    if (stockFilter) stockFilter.addEventListener('change', handleFilterChange);
    if (sortSelect) sortSelect.addEventListener('change', handleSortChange);
    
    // View toggle buttons
    const viewButtons = querySelectorAll('.view-btn');
    viewButtons.forEach(button => {
        button.addEventListener('click', function() {
            changeView(this.dataset.view);
        });
    });
    
    // Battery form
    const batteryForm = getElementById('batteryForm');
    if (batteryForm) {
        batteryForm.addEventListener('submit', handleBatteryFormSubmit);
        setupAutoSave();
    }
    
    // Bulk actions
    setupBulkActions();
}

/**
 * Setup auto-save for battery form
 */
function setupAutoSave() {
    const batteryForm = getElementById('batteryForm');
    if (batteryForm) {
        autoSaveForm(batteryForm, 'battery_form');
    }
}

/**
 * Setup bulk action event listeners
 */
function setupBulkActions() {
    const selectAllCheckbox = getElementById('selectAll');
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', handleSelectAll);
    }
}

// ===== SEARCH AND FILTER FUNCTIONS =====

/**
 * Handle search input
 * @param {Event} event - Input event
 */
function handleSearch(event) {
    inventoryState.searchQuery = event.target.value.toLowerCase().trim();
    applyFiltersAndSearch();
}

/**
 * Handle filter changes
 * @param {Event} event - Change event
 */
function handleFilterChange(event) {
    const filterType = event.target.id.replace('Filter', '');
    inventoryState.filters[filterType] = event.target.value;
    applyFiltersAndSearch();
}

/**
 * Handle sort changes
 * @param {Event} event - Change event
 */
function handleSortChange(event) {
    inventoryState.sortBy = event.target.value;
    applyFiltersAndSearch();
}

/**
 * Apply filters, search, and sorting
 */
function applyFiltersAndSearch() {
    let filtered = [...inventoryState.batteries];
    
    // Apply search
    if (inventoryState.searchQuery) {
        filtered = filtered.filter(battery => 
            battery.model.toLowerCase().includes(inventoryState.searchQuery) ||
            battery.brand.toLowerCase().includes(inventoryState.searchQuery) ||
            battery.type.toLowerCase().includes(inventoryState.searchQuery) ||
            battery.category.toLowerCase().includes(inventoryState.searchQuery)
        );
    }
    
    // Apply filters
    if (inventoryState.filters.category) {
        filtered = filtered.filter(battery => battery.category === inventoryState.filters.category);
    }
    
    if (inventoryState.filters.type) {
        filtered = filtered.filter(battery => battery.type === inventoryState.filters.type);
    }
    
    if (inventoryState.filters.stock) {
        filtered = filtered.filter(battery => {
            switch (inventoryState.filters.stock) {
                case 'in-stock':
                    return battery.stock > battery.lowStockThreshold;
                case 'low-stock':
                    return battery.stock > 0 && battery.stock <= battery.lowStockThreshold;
                case 'out-of-stock':
                    return battery.stock === 0;
                default:
                    return true;
            }
        });
    }
    
    // Apply sorting
    filtered.sort((a, b) => {
        switch (inventoryState.sortBy) {
            case 'name':
                return a.model.localeCompare(b.model);
            case 'price-low':
                return a.price - b.price;
            case 'price-high':
                return b.price - a.price;
            case 'stock-low':
                return a.stock - b.stock;
            case 'stock-high':
                return b.stock - a.stock;
            case 'date-new':
                return new Date(b.lastUpdated) - new Date(a.lastUpdated);
            case 'date-old':
                return new Date(a.lastUpdated) - new Date(b.lastUpdated);
            default:
                return 0;
        }
    });
    
    inventoryState.filteredBatteries = filtered;
    inventoryState.currentPage = 1; // Reset to first page
    renderInventory();
}

/**
 * Clear search and filters
 */
function clearSearch() {
    // Clear search input
    const searchInput = getElementById('searchInput');
    if (searchInput) {
        searchInput.value = '';
    }
    
    // Reset filters
    inventoryState.searchQuery = '';
    inventoryState.filters = { category: '', type: '', stock: '' };
    
    // Reset filter selects
    const filterSelects = querySelectorAll('#categoryFilter, #typeFilter, #stockFilter');
    filterSelects.forEach(select => {
        select.value = '';
    });
    
    // Reset sort
    inventoryState.sortBy = 'name';
    const sortSelect = getElementById('sortBy');
    if (sortSelect) {
        sortSelect.value = 'name';
    }
    
    // Apply changes
    applyFiltersAndSearch();
}

// ===== VIEW FUNCTIONS =====

/**
 * Change inventory view
 * @param {string} view - View type (grid, list)
 */
function changeView(view) {
    inventoryState.currentView = view;
    
    // Update view buttons
    const viewButtons = querySelectorAll('.view-btn');
    viewButtons.forEach(button => {
        button.classList.toggle('active', button.dataset.view === view);
    });
    
    renderInventory();
}

/**
 * Render inventory based on current state
 */
function renderInventory() {
    const container = getElementById('inventoryGrid');
    const loadingState = getElementById('loadingState');
    const emptyState = getElementById('emptyState');
    
    if (!container) return;
    
    // Show/hide loading state
    if (inventoryState.isLoading) {
        loadingState.style.display = 'block';
        emptyState.style.display = 'none';
        container.innerHTML = '';
        return;
    } else {
        loadingState.style.display = 'none';
    }
    
    // Check if we have batteries to display
    if (inventoryState.filteredBatteries.length === 0) {
        emptyState.style.display = 'block';
        container.innerHTML = '';
        updatePagination();
        return;
    } else {
        emptyState.style.display = 'none';
    }
    
    // Calculate pagination
    const startIndex = (inventoryState.currentPage - 1) * inventoryState.itemsPerPage;
    const endIndex = startIndex + inventoryState.itemsPerPage;
    const batteriesToShow = inventoryState.filteredBatteries.slice(startIndex, endIndex);
    
    // Render batteries
    if (inventoryState.currentView === 'grid') {
        renderBatteryGrid(container, batteriesToShow);
    } else {
        renderBatteryList(container, batteriesToShow);
    }
    
    // Update pagination
    updatePagination();
}

/**
 * Render battery grid view
 * @param {HTMLElement} container - Container element
 * @param {Array} batteries - Batteries to render
 */
function renderBatteryGrid(container, batteries) {
    container.className = 'inventory-grid';
    container.innerHTML = batteries.map(battery => `
        <div class="battery-card" draggable="true" data-battery-id="${battery.id}" 
             ondragstart="handleBatteryDragStart(event)" ondragend="handleBatteryDragEnd(event)">
            <div class="battery-header">
                <div class="battery-info">
                    <h4>${battery.model}</h4>
                    <p>${battery.brand}</p>
                </div>
                <div class="battery-actions">
                    <button class="btn-icon" onclick="editBattery('${battery.id}')" title="Edit">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-icon" onclick="deleteBattery('${battery.id}')" title="Delete">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            
            <div class="battery-specs">
                <div class="spec-item">
                    <span class="spec-label">Voltage</span>
                    <span class="spec-value">${battery.voltage}</span>
                </div>
                <div class="spec-item">
                    <span class="spec-label">Capacity</span>
                    <span class="spec-value">${battery.capacity}</span>
                </div>
                <div class="spec-item">
                    <span class="spec-label">Type</span>
                    <span class="spec-value">${battery.type}</span>
                </div>
                <div class="spec-item">
                    <span class="spec-label">Category</span>
                    <span class="spec-value">${battery.category}</span>
                </div>
            </div>
            
            <div class="battery-footer">
                <div class="battery-price">${formatCurrency(battery.price)}</div>
                <div class="stock-indicator ${getStockStatus(battery)}">
                    <span class="stock-dot"></span>
                    <span>${battery.stock} in stock</span>
                </div>
            </div>
        </div>
    `).join('');
}

/**
 * Render battery list view
 * @param {HTMLElement} container - Container element
 * @param {Array} batteries - Batteries to render
 */
function renderBatteryList(container, batteries) {
    container.className = 'inventory-list';
    container.innerHTML = `
        <table class="inventory-table">
            <thead>
                <tr>
                    <th><input type="checkbox" id="selectAllBatteries" onchange="toggleSelectAll()"></th>
                    <th>Model</th>
                    <th>Brand</th>
                    <th>Type</th>
                    <th>Voltage</th>
                    <th>Capacity</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                ${batteries.map(battery => `
                    <tr data-battery-id="${battery.id}">
                        <td><input type="checkbox" class="battery-checkbox" value="${battery.id}" onchange="handleBatterySelect(this)"></td>
                        <td><strong>${battery.model}</strong></td>
                        <td>${battery.brand}</td>
                        <td>${battery.type}</td>
                        <td>${battery.voltage}</td>
                        <td>${battery.capacity}</td>
                        <td>${formatCurrency(battery.price)}</td>
                        <td>
                            <span class="stock-indicator ${getStockStatus(battery)}">
                                <span class="stock-dot"></span>
                                ${battery.stock}
                            </span>
                        </td>
                        <td><span class="category-badge">${battery.category}</span></td>
                        <td>
                            <button class="btn btn-sm btn-secondary" onclick="editBattery('${battery.id}')">
                                <i class="fas fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger" onclick="deleteBattery('${battery.id}')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                `).join('')}
            </tbody>
        </table>
    `;
}

/**
 * Get stock status class
 * @param {Object} battery - Battery object
 * @returns {string} Stock status class
 */
function getStockStatus(battery) {
    if (battery.stock === 0) return 'out-of-stock';
    if (battery.stock <= battery.lowStockThreshold) return 'low-stock';
    return 'in-stock';
}

/**
 * Update pagination controls
 */
function updatePagination() {
    const totalItems = inventoryState.filteredBatteries.length;
    const totalPages = Math.ceil(totalItems / inventoryState.itemsPerPage);
    const startItem = (inventoryState.currentPage - 1) * inventoryState.itemsPerPage + 1;
    const endItem = Math.min(inventoryState.currentPage * inventoryState.itemsPerPage, totalItems);
    
    // Update pagination info
    const itemsStart = getElementById('itemsStart');
    const itemsEnd = getElementById('itemsEnd');
    const totalItemsElement = getElementById('totalItems');
    
    if (itemsStart) itemsStart.textContent = totalItems > 0 ? startItem : 0;
    if (itemsEnd) itemsEnd.textContent = endItem;
    if (totalItemsElement) totalItemsElement.textContent = totalItems;
    
    // Update pagination buttons
    const paginationContainer = getElementById('pagination');
    if (paginationContainer && totalPages > 1) {
        paginationContainer.innerHTML = generatePaginationButtons(totalPages);
    } else if (paginationContainer) {
        paginationContainer.innerHTML = '';
    }
}

/**
 * Generate pagination buttons
 * @param {number} totalPages - Total number of pages
 * @returns {string} HTML for pagination buttons
 */
function generatePaginationButtons(totalPages) {
    let buttons = '';
    
    // Previous button
    buttons += `
        <button onclick="changePage(${inventoryState.currentPage - 1})" 
                ${inventoryState.currentPage === 1 ? 'disabled' : ''}>
            <i class="fas fa-chevron-left"></i>
        </button>
    `;
    
    // Page numbers
    const startPage = Math.max(1, inventoryState.currentPage - 2);
    const endPage = Math.min(totalPages, inventoryState.currentPage + 2);
    
    if (startPage > 1) {
        buttons += `<button onclick="changePage(1)">1</button>`;
        if (startPage > 2) {
            buttons += `<span>...</span>`;
        }
    }
    
    for (let i = startPage; i <= endPage; i++) {
        buttons += `
            <button onclick="changePage(${i})" 
                    ${i === inventoryState.currentPage ? 'class="active"' : ''}>
                ${i}
            </button>
        `;
    }
    
    if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
            buttons += `<span>...</span>`;
        }
        buttons += `<button onclick="changePage(${totalPages})">${totalPages}</button>`;
    }
    
    // Next button
    buttons += `
        <button onclick="changePage(${inventoryState.currentPage + 1})" 
                ${inventoryState.currentPage === totalPages ? 'disabled' : ''}>
            <i class="fas fa-chevron-right"></i>
        </button>
    `;
    
    return buttons;
}

/**
 * Change page
 * @param {number} page - Page number
 */
function changePage(page) {
    const totalPages = Math.ceil(inventoryState.filteredBatteries.length / inventoryState.itemsPerPage);
    
    if (page >= 1 && page <= totalPages) {
        inventoryState.currentPage = page;
        renderInventory();
    }
}

// ===== CATEGORY MANAGEMENT =====

/**
 * Update category counts
 */
function updateCategoryCounts() {
    const categories = ['automotive', 'marine', 'motorcycle', 'ups', 'solar'];
    
    categories.forEach(category => {
        const count = inventoryState.batteries.filter(battery => battery.category === category).length;
        const countElement = getElementById(`${category}-count`);
        if (countElement) {
            countElement.textContent = count;
        }
    });
}

/**
 * Filter by category
 * @param {string} category - Category to filter by
 */
function filterByCategory(category) {
    inventoryState.filters.category = category;
    
    // Update filter select
    const categoryFilter = getElementById('categoryFilter');
    if (categoryFilter) {
        categoryFilter.value = category;
    }
    
    applyFiltersAndSearch();
}

/**
 * Filter by type
 * @param {string} type - Type to filter by
 */
function filterByType(type) {
    inventoryState.filters.type = type;
    applyFiltersAndSearch();
}

/**
 * Filter by stock level
 * @param {string} stock - Stock level to filter by
 */
function filterByStock(stock) {
    inventoryState.filters.stock = stock;
    applyFiltersAndSearch();
}

/**
 * Sort inventory
 * @param {string} sortBy - Sort criteria
 */
function sortInventory(sortBy) {
    inventoryState.sortBy = sortBy;
    applyFiltersAndSearch();
}

// ===== BATTERY CRUD OPERATIONS =====

/**
 * Show add battery modal
 */
function showAddBatteryModal() {
    const modal = getElementById('batteryModal');
    const modalTitle = getElementById('modalTitle');
    const batteryForm = getElementById('batteryForm');
    
    if (modal && modalTitle && batteryForm) {
        modalTitle.innerHTML = '<i class="fas fa-plus"></i> Add New Battery';
        resetForm(batteryForm);
        clearAutoSavedForm('battery_form');
        showModal('batteryModal');
    }
}

/**
 * Edit battery
 * @param {string} batteryId - Battery ID to edit
 */
function editBattery(batteryId) {
    const battery = inventoryState.batteries.find(b => b.id === batteryId);
    if (!battery) {
        showNotification('Battery not found', 'error');
        return;
    }
    
    const modal = getElementById('batteryModal');
    const modalTitle = getElementById('modalTitle');
    const batteryForm = getElementById('batteryForm');
    
    if (modal && modalTitle && batteryForm) {
        modalTitle.innerHTML = '<i class="fas fa-edit"></i> Edit Battery';
        
        // Populate form with battery data
        populateBatteryForm(battery);
        
        showModal('batteryModal');
    }
}

/**
 * Populate battery form with data
 * @param {Object} battery - Battery object
 */
function populateBatteryForm(battery) {
    const form = getElementById('batteryForm');
    if (!form) return;
    
    // Set form values
    const fields = [
        'batteryId', 'batteryModel', 'batteryBrand', 'batteryVoltage',
        'batteryCapacity', 'batteryType', 'batteryCategory', 'batteryPrice',
        'batteryStock', 'batteryDescription', 'batteryWarranty', 'batteryWeight'
    ];
    
    fields.forEach(fieldName => {
        const field = getElementById(fieldName);
        if (field) {
            const batteryProperty = fieldName.replace('battery', '').toLowerCase();
            if (batteryProperty === 'id') {
                field.value = battery.id;
            } else {
                field.value = battery[batteryProperty] || '';
            }
        }
    });
}

/**
 * Handle battery form submission
 * @param {Event} event - Form submit event
 */
async function handleBatteryFormSubmit(event) {
    event.preventDefault();
    
    if (inventoryState.isLoading) return;
    
    try {
        inventoryState.isLoading = true;
        showLoading('Saving battery...');
        
        const form = event.target;
        const formData = serializeForm(form);
        
        // Validate form data
        if (!validateBatteryForm(formData)) {
            return;
        }
        
        // Create battery object
        const battery = createBatteryFromForm(formData);
        
        // Simulate API delay
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        // Check if editing or adding
        const existingIndex = inventoryState.batteries.findIndex(b => b.id === battery.id);
        
        if (existingIndex >= 0) {
            // Update existing battery
            inventoryState.batteries[existingIndex] = battery;
            showNotification('Battery updated successfully', 'success');
        } else {
            // Add new battery
            battery.id = generateId();
            battery.createdDate = new Date().toISOString().split('T')[0];
            inventoryState.batteries.push(battery);
            showNotification('Battery added successfully', 'success');
        }
        
        // Save to localStorage
        saveToStorage('batteryMall_batteries', inventoryState.batteries);
        
        // Clear auto-saved form data
        clearAutoSavedForm('battery_form');
        
        // Refresh display
        applyFiltersAndSearch();
        updateCategoryCounts();
        
        // Close modal
        closeBatteryModal();
        
    } catch (error) {
        handleError(error, 'Save Battery');
        showNotification('Failed to save battery', 'error');
    } finally {
        inventoryState.isLoading = false;
        hideLoading();
    }
}

/**
 * Validate battery form data
 * @param {Object} formData - Form data object
 * @returns {boolean} Validation result
 */
function validateBatteryForm(formData) {
    const requiredFields = [
        'batteryModel', 'batteryBrand', 'batteryVoltage', 'batteryCapacity',
        'batteryType', 'batteryCategory', 'batteryPrice', 'batteryStock'
    ];
    
    for (const field of requiredFields) {
        if (!formData[field] || formData[field].trim() === '') {
            const fieldLabel = field.replace('battery', '').replace(/([A-Z])/g, ' $1').trim();
            showNotification(`${fieldLabel} is required`, 'error');
            return false;
        }
    }
    
    // Validate numeric fields
    const price = parseFloat(formData.batteryPrice);
    const stock = parseInt(formData.batteryStock);
    
    if (isNaN(price) || price < 0) {
        showNotification('Price must be a valid positive number', 'error');
        return false;
    }
    
    if (isNaN(stock) || stock < 0) {
        showNotification('Stock must be a valid non-negative number', 'error');
        return false;
    }
    
    return true;
}

/**
 * Create battery object from form data
 * @param {Object} formData - Form data object
 * @returns {Object} Battery object
 */
function createBatteryFromForm(formData) {
    return {
        id: formData.batteryId || generateId(),
        model: formData.batteryModel.trim(),
        brand: formData.batteryBrand.trim(),
        voltage: formData.batteryVoltage,
        capacity: formData.batteryCapacity,
        type: formData.batteryType,
        price: parseFloat(formData.batteryPrice),
        stock: parseInt(formData.batteryStock),
        category: formData.batteryCategory,
        description: formData.batteryDescription?.trim() || '',
        warranty: parseInt(formData.batteryWarranty) || 12,
        weight: parseFloat(formData.batteryWeight) || 0,
        lastUpdated: new Date().toISOString().split('T')[0],
        lowStockThreshold: Math.max(5, Math.floor(parseInt(formData.batteryStock) * 0.2))
    };
}

/**
 * Delete battery
 * @param {string} batteryId - Battery ID to delete
 */
function deleteBattery(batteryId) {
    const battery = inventoryState.batteries.find(b => b.id === batteryId);
    if (!battery) {
        showNotification('Battery not found', 'error');
        return;
    }
    
    if (confirm(`Are you sure you want to delete "${battery.model}"? This action cannot be undone.`)) {
        try {
            // Remove from array
            inventoryState.batteries = inventoryState.batteries.filter(b => b.id !== batteryId);
            
            // Save to localStorage
            saveToStorage('batteryMall_batteries', inventoryState.batteries);
            
            // Refresh display
            applyFiltersAndSearch();
            updateCategoryCounts();
            
            showNotification('Battery deleted successfully', 'success');
            
        } catch (error) {
            handleError(error, 'Delete Battery');
            showNotification('Failed to delete battery', 'error');
        }
    }
}

/**
 * Close battery modal
 */
function closeBatteryModal() {
    hideModal('batteryModal');
}

// ===== BULK OPERATIONS =====

/**
 * Handle select all checkbox
 * @param {Event} event - Change event
 */
function handleSelectAll(event) {
    const isChecked = event.target.checked;
    const checkboxes = querySelectorAll('.battery-checkbox');
    
    checkboxes.forEach(checkbox => {
        checkbox.checked = isChecked;
        handleBatterySelect(checkbox);
    });
}

/**
 * Toggle select all
 */
function toggleSelectAll() {
    const selectAllCheckbox = getElementById('selectAllBatteries');
    if (selectAllCheckbox) {
        handleSelectAll({ target: selectAllCheckbox });
    }
}

/**
 * Handle individual battery selection
 * @param {HTMLInputElement} checkbox - Checkbox element
 */
function handleBatterySelect(checkbox) {
    const batteryId = checkbox.value;
    
    if (checkbox.checked) {
        inventoryState.selectedBatteries.add(batteryId);
    } else {
        inventoryState.selectedBatteries.delete(batteryId);
    }
    
    updateBulkActionButtons();
}

/**
 * Update bulk action buttons
 */
function updateBulkActionButtons() {
    const selectedCount = inventoryState.selectedBatteries.size;
    const bulkButtons = querySelectorAll('#bulkUpdateBtn, #bulkDeleteBtn');
    
    bulkButtons.forEach(button => {
        button.disabled = selectedCount === 0;
    });
    
    const selectedCountElement = getElementById('selectedCount');
    if (selectedCountElement) {
        selectedCountElement.textContent = selectedCount;
    }
}

// ===== EXPORT FUNCTIONALITY =====

/**
 * Export inventory data
 */
function exportInventory() {
    try {
        const exportData = {
            batteries: inventoryState.batteries,
            exportDate: new Date().toISOString(),
            totalItems: inventoryState.batteries.length,
            categories: {
                automotive: inventoryState.batteries.filter(b => b.category === 'automotive').length,
                marine: inventoryState.batteries.filter(b => b.category === 'marine').length,
                motorcycle: inventoryState.batteries.filter(b => b.category === 'motorcycle').length,
                ups: inventoryState.batteries.filter(b => b.category === 'ups').length,
                solar: inventoryState.batteries.filter(b => b.category === 'solar').length
            }
        };
        
        const filename = `battery_inventory_${new Date().toISOString().split('T')[0]}.json`;
        exportAsJSON(exportData, filename);
        
    } catch (error) {
        handleError(error, 'Export Inventory');
    }
}

// ===== UTILITY FUNCTIONS =====

/**
 * Search batteries by query
 * @param {string} query - Search query
 */
function searchBatteries(query) {
    inventoryState.searchQuery = query.toLowerCase().trim();
    applyFiltersAndSearch();
}

/**
 * Get battery by ID
 * @param {string} batteryId - Battery ID
 * @returns {Object|null} Battery object or null
 */
function getBatteryById(batteryId) {
    return inventoryState.batteries.find(battery => battery.id === batteryId) || null;
}

/**
 * Check if battery is in stock
 * @param {string} batteryId - Battery ID
 * @returns {boolean} Stock status
 */
function isBatteryInStock(batteryId) {
    const battery = getBatteryById(batteryId);
    return battery ? battery.stock > 0 : false;
}

/**
 * Update battery stock
 * @param {string} batteryId - Battery ID
 * @param {number} newStock - New stock quantity
 * @returns {boolean} Success status
 */
function updateBatteryStock(batteryId, newStock) {
    try {
        const battery = getBatteryById(batteryId);
        if (!battery) return false;
        
        battery.stock = Math.max(0, newStock);
        battery.lastUpdated = new Date().toISOString().split('T')[0];
        
        saveToStorage('batteryMall_batteries', inventoryState.batteries);
        renderInventory();
        
        return true;
    } catch (error) {
        handleError(error, 'Update Battery Stock');
        return false;
    }
}

// Make functions available globally
window.showAddBatteryModal = showAddBatteryModal;
window.editBattery = editBattery;
window.deleteBattery = deleteBattery;
window.closeBatteryModal = closeBatteryModal;
window.exportInventory = exportInventory;
window.clearSearch = clearSearch;
window.changeView = changeView;
window.filterByCategory = filterByCategory;
window.filterByType = filterByType;
window.filterByStock = filterByStock;
window.sortInventory = sortInventory;
window.searchBatteries = searchBatteries;
window.changePage = changePage;
window.toggleSelectAll = toggleSelectAll;
window.handleBatterySelect = handleBatterySelect;
