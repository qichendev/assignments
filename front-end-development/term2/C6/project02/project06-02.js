"use strict";
/*    JavaScript 7th Edition
      Chapter 6
      Project 06-02

      Project to turn a selection list into a selection of hypertext links
      Author: Qi Chen
      Date:   June 11

      Filename: project06-02.js
*/


window.addEventListener("load", () => {
      let allSelect = document.querySelectorAll("#govLinks");
      for (let i = 0; i < allSelect.length; i++) {
            allSelect[i].addEventListener("change", (e) => {
                  let linkURL = e.target.value;
                  let newWin = window.open(linkURL);
            });
      }
});