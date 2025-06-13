"use strict";
/*    JavaScript 7th Edition
      Chapter 6
      Project 06-05

      Project to submit a registration form
      Author: Qi Chen
      Date:   June 11

      Filename: project06-05.js
*/


window.addEventListener("load", function () {
   calcCart();

   document.getElementById("regSubmit").addEventListener("click", sessionTest);

   document.getElementById("fnBox").addEventListener("blur", calcCart);
   document.getElementById("lnBox").addEventListener("blur", calcCart);
   document.getElementById("groupBox").addEventListener("blur", calcCart);
   document.getElementById("mailBox").addEventListener("blur", calcCart);
   document.getElementById("phoneBox").addEventListener("blur", calcCart);
   document.getElementById("sessionBox").addEventListener("change", calcCart);
   document.getElementById("banquetBox").addEventListener("blur", calcCart);
   document.getElementById("mediaCB").addEventListener("click", calcCart);
});

function sessionTest() {
   var confSession = document.getElementById("sessionBox");
   if (confSession.selectedIndex === -1) {
      confSession.setCustomValidity("Select a Session Package");
   } else {
      confSession.setCustomValidity("");
   }
}

function calcCart() {
   const form = document.forms.register;

   let banquetGuests = form.elements.banquetGuests.value;
   let guestCost = banquetGuests * 55;
   document.getElementById("regBanquet").textContent = banquetGuests;

   let sessionCost = 0;
   let sessionChoice = "";

   let sessionBox = document.getElementById("sessionBox");
   let selectedSession = sessionBox.selectedIndex;

   if (selectedSession !== -1) {
      sessionChoice = sessionBox.options[selectedSession].text;
      sessionCost = sessionBox.options[selectedSession].value;
   }

   let mediaCost = 0;
   let mediaChoice = "";

   if (form.elements.mediaCB.checked) {
      mediaChoice = "yes";
      mediaCost = 115;
   }

   let totalCost = Number(guestCost) + Number(sessionCost) + Number(mediaCost);

   document.getElementById("regName").textContent = form.elements.firstName.value + " " + form.elements.lastName.value;
   document.getElementById("regGroup").textContent = form.elements.group.value;
   document.getElementById("regEmail").textContent = form.elements.email.value;
   document.getElementById("regPhone").textContent = form.elements.phoneNumber.value;
   document.getElementById("regSession").textContent = sessionChoice;
   document.getElementById("regBanquet").textContent = banquetGuests;
   document.getElementById("regPack").textContent = mediaChoice;
   document.getElementById("regTotal").textContent = totalCost.toLocaleString("en-US", { style: "currency", currency: "USD" });
}