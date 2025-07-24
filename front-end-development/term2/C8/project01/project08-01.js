"use strict";
/*    JavaScript 7th Edition
      Chapter 8
      Project 08-01

      Project to create a timer object
      Author: Qi Chen
      Date: 7/9/2025


      Filename: project08-01.js
*/

/*--------------- Object Code --------------------*/


let timer = {
      minutes: 0,
      seconds: 0,
      timerID: null,
      init: function (min, sec) {
            this.minutes = min;
            this.seconds = sec;
            return this;
      },
      runPause: function (minBox, secBox) {
            if (this.timerID === null) {
                  this.timerID = setInterval(() => {
                        this.countdown(minBox, secBox);
                  }, 1000);
            } else {
                  clearInterval(this.timerID);
                  this.timerID = null;
            }
      },
      countdown: function (minBox, secBox) {
            if (this.seconds > 0) {
                  this.seconds--;
            } else if (this.minutes > 0) {
                  this.minutes--;
                  this.seconds = 59;
            } else {
                  clearInterval(this.timerID);
                  this.timerID = null;
            }
            minBox.value = this.minutes;
            secBox.value = this.seconds;
      }
}

/*---------------Interface Code -----------------*/

document.addEventListener('DOMContentLoaded', function() {
      /* Interface Objects */
      let minBox = document.getElementById("minutesBox");
      let secBox = document.getElementById("secondsBox");
      let runPauseTimer = document.getElementById("runPauseButton");

      let myTimer = timer.init(parseInt(minBox.value) || 0, parseInt(secBox.value) || 0);

      minBox.onchange = function() {
            myTimer.minutes = parseInt(minBox.value) || 0;
      }
      secBox.onchange = function() {
            myTimer.seconds = parseInt(secBox.value) || 0;
      }

      runPauseTimer.onclick = function() {
            myTimer.runPause(minBox, secBox);
      }
});