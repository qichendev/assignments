"use strict";
/*    JavaScript 7th Edition
      Chapter 9
      Project 09-03

      Project to retrieve date of last visit from web storage and mark new article
      Author: 
      Date:   

      Filename: project09-03.js
*/

/* Page Objects */

let lastVisitDate = document.getElementById("lastVisitDate");
let articleDates = document.getElementsByClassName("posttime");

if (localStorage.sbloggerVisit) {
      let storedLastDate = localStorage.sbloggerVisit;
      lastVisitDate.textContent = storedLastDate;
      let lastVisit = new Date(storedLastDate);
      for (let article of articleDates) {
            let articleDate = new Date(article.textContent);
            if (articleDate > lastVisit) {
                  article.innerHTML += "<strong>new</strong>";
            }
      }
} else {
      lastVisitDate.textContent = "Welcome to SBlogger!";
      for (let article of articleDates) {
            article.innerHTML += "<strong>new</strong>";
      }
}

let currentDate = new Date("9/12/2024");
localStorage.setItem("sbloggerVisit", currentDate.toLocaleDateString());