"use strict";
/*    JavaScript 7th Edition
      Chapter 9
      Project 09-04

      Project to store high scores from a game in a cookie
      Author: 
      Date:   

      Filename: project09-04.js
*/

/* Page Objects */
let bestText = document.getElementById("best");
let clockTimer = document.getElementById("timer");

// Custom event that runs when the puzzle is solved
window.addEventListener("puzzleSolved", updateRecord);

function getBestTime() {
      if (document.cookie) {
            let cookieArray = document.cookie.split("=");
            return parseInt(cookieArray[1]);
      } else {
            return 9999;
      }
}

function updateRecord() {
      let solutionTime = parseInt(document.getElementById("timer").textContent);
      let bestTime = getBestTime();

      if (solutionTime < bestTime) {
            bestTime = solutionTime;
            bestText.textContent = `${bestTime} seconds`;
            document.cookie = `puzzle8Best=${bestTime}; max-age=${90 * 24 * 60 * 60}`;
      }
}
// Event listener that is run when the page loads
window.addEventListener("load", function() {
      if (this.document.cookie) {
            bestText.textContent = "Best seconds " + getBestTime();
            let cookies = this.document.cookie.split("; ");
            for (let cookie of cookies) {
                  let nameValue = cookie.split("=");
                  if (nameValue[0] === "best") {
                        bestText.textContent = nameValue[1];
                  }
            }
      }
});

