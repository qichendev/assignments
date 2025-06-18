"use strict";
/*    JavaScript 7th Edition
      Chapter 7
      Project 07-03

      Project to create a New Year's Eve countdown clock
      Author: Qi Chen
      Date:   June 18

      Filename: project07-03.js
*/

let currentTime = document.getElementById("currentTime");
let daysLeftBox = document.getElementById("days");
let hrsLeftBox = document.getElementById("hours");
let minsLeftBox = document.getElementById("minutes");
let secsLeftBox = document.getElementById("seconds");

function countdown() {
   const now = new Date();
   document.getElementById("currentTime").textContent = now.toLocaleString();
   const newYear = new Date("January 1, 2024");
   const nextYear = now.getFullYear() + 1;
   newYear.setFullYear(nextYear);
   const daysLeft = (newYear - now) / (1000 * 60 * 60 * 24);
   const hrsLeft = (daysLeft - Math.floor(daysLeft)) * 24;
   const minsLeft = (hrsLeft - Math.floor(hrsLeft)) * 60;
   const secsLeft = (minsLeft - Math.floor(minsLeft)) * 60;
   daysLeftBox.innerHTML = String(Math.floor(daysLeft)).padStart(2, "0");
   hrsLeftBox.innerHTML = String(Math.floor(hrsLeft)).padStart(2, "0");
   minsLeftBox.innerHTML = String(Math.floor(minsLeft)).padStart(2, "0");
   secsLeftBox.innerHTML = String(Math.floor(secsLeft)).padStart(2, "0");
}

setInterval(countdown, 1000);