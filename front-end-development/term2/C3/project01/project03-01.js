/*    JavaScript 7th Edition
      Chapter 3
      Project 03-01

      Application to calculate total order cost
      Author: Qi Chen
      Date:   May 21

      Filename: project03-01.js
*/


// Function to display a numeric value as a text string in the format $##.## 
function formatCurrency(value) {
      return "$" + value.toFixed(2);
}

let menuItems = document.getElementsByClassName("menuItem");

for (let i = 0; i < menuItems.length; i++) {
      menuItems[i].onclick = () => {
            let orderTotal = 0;
            for (let j = 0; j < menuItems.length; j++) {
                  if (menuItems[j].checked) {
                        orderTotal += parseFloat(menuItems[j].value);
                  }
            }
            document.getElementById("billTotal").innerHTML = formatCurrency(orderTotal);
      }
}