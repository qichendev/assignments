"use strict";
/*    JavaScript 7th Edition
      Chapter 6
      Project 06-03

      Script to complete a form containing billing and shipping address information
      Author: Qi Chen
      Date:   June 11

      Filename: project06-03.js
*/
let useShip = document.getElementById("useShip");

function copyShippingToBilling() {
      if (useShip.checked) {
            document.getElementById("firstnameBill").value = document.getElementById("firstnameShip").value;
            document.getElementById("last").value = document.getElementById("firstnameShip").value;
            document.getElementById("firstnameBill").value = document.getElementById("firstnameShip").value;
            document.getElementById("firstnameBill").value = document.getElementById("firstnameShip").value;
            
      }
}