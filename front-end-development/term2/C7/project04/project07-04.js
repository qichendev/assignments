"use strict";
/*    JavaScript 7th Edition
      Chapter 7
      Project 07-04

      Project to create a customer queue
      Author: Qi Chen
      Date:   June 18


      Filename: project07-04.js
*/

let customers = ["Alisha Jordan","Kurt Cunningham", "Ricardo Lopez", "Chanda Rao",
                 "Kevin Grant", "Thomas Bey", "Elizabeth Anderson", "Shirley Falk",
                 "David Babin", "Arthur Blanding", "Brian Vick", "Jaime Aguilar",
                 "Eileen Rios", "Gail Watts", "Margaret Wolfe", "Kathleen Newman",
                 "Jason Searl", "Stephen Gross", "Robin Steinfeldt", "Jacob Bricker",
                 "Gene Bearden", "Charles Sorensen", "John Hilton", "David Johnson",
                 "Wesley Cho"];

let customerName = document.getElementById("customerName");
let customerList = document.getElementById("customerList");

let addButton = document.getElementById("addButton");
let searchButton = document.getElementById("searchButton");
let removeButton = document.getElementById("removeButton");
let topButton = document.getElementById("topButton");

let status = document.getElementById("status");

generateCustomerList();

// Function to generate the ordered list based on the contents of the customers array
function generateCustomerList() {
   customerList.innerHTML = "";
   for (let i = 0; i < customers.length; i++) {
      let customerItem = document.createElement("li");      
      customerItem.textContent = customers[i];     
      customerList.appendChild(customerItem);
   }
}

// addButton.addEventListener("click", function() {
//    customers.push(customerName.value);
//    generateCustomerList();
//    status.textContent = `${customerName} added to the end of the queue`;
// });

// searchButton.addEventListener("click", function() {
//    let index = customers.indexOf(customerName.value);
//    let place = index + 1;
//    if (place === 0) {
//       status.textContent = `${customerName.value} is not in the queue`;
//    } else {
//       status.textContent = `${customerName.value} is number ${place} in the queue`;
//    }
// });

// removeButton.addEventListener("click", function() {
//    let index = customers.indexOf(customerName.value);
//    if (index !== -1) {
//       customers.splice(index, 1);
//       generateCustomerList();
//       status.textContent = `${customerName.value} removed from the queue`;
//    } else {
//       status.textContent = `${customerName.value} is not in the queue`;
//    }
// });
// topButton.addEventListener("click", function() {
//    let firstCustomer = customers.shift();
//    generateCustomerList();
//    status.textContent = `${firstCustomer} is at the front of the queue`;
// });

// ...existing code...

// Add Button Handler
addButton.onclick = function() {
   const name = customerName.value.trim();
   if (name) {
      customers.push(name);
      generateCustomerList();
      status.textContent = `${name} added to the end of the queue`;
   }
};

// Search Button Handler
searchButton.onclick = function() {
   const name = customerName.value.trim();
   const index = customers.indexOf(name);
   const place = index + 1;
   if (place === 0) {
      status.textContent = `${name} is not found in the queue`;
   } else {
      status.textContent = `${name} found in position ${place} of the queue`;
   }
};

// Remove Button Handler
removeButton.onclick = function() {
   const name = customerName.value.trim();
   const index = customers.indexOf(name);
   if (index !== -1) {
      customers.splice(index, 1);
      status.textContent = `${name} removed from the queue`;
      generateCustomerList();
   } else {
      status.textContent = `${name} is not found in the queue`;
   }
};

// Top Button Handler
topButton.onclick = function() {
   if (customers.length > 0) {
      const topCustomer = customers.shift();
      status.textContent = `${topCustomer} removed from the top of the queue`;
      generateCustomerList();
   } else {
      status.textContent = `No customers in the queue`;
   }
};

// ...existing code...