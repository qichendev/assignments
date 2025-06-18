"use strict";
/*    JavaScript 7th Edition
      Chapter 7
      Project 07-01

      Project to validate a form used for setting up a new account
      Author: Qi Chen
      Date:   June 18

      Filename: project07-01.js
*/

let signupForm = document.getElementById("signup");

const regex1 = /[A-Z]/;
const regex2 = /\d/;
const regex3 = /[!$#%]/;

signupForm.addEventListener("submit", function(e) { 
   let pwd = document.getElementById("pwd").value;
   let username = document.getElementById("user").value;
   let feedback = document.getElementById("feedback");
   if (username.length < 3) {
      e.preventDefault();
      feedback.textContent = "Username must be at least 3 letters.";
   } else if (pwd.length < 8) {
      e.preventDefault();
      feedback.textContent = "Password must be at least 8 characters.";
   } else if (regex1.test(pwd) === false) {
      e.preventDefault();
      feedback.textContent = "Password must contain at least one uppercase letter.";
   } else if (regex2.test(pwd) === false) {
      e.preventDefault();
      feedback.textContent = "Password must contain at least one number.";
   } else if (regex3.test(pwd) === false) {
      e.preventDefault();
      feedback.textContent = "Password must contain at least one special character (!, $, #, %).";
   } else {
      feedback.textContent = "";
   }
});
