"use strict";
/*  JavaScript 7th Edition
    Chapter 10
    Project 10-04

    Chess Board Drag and Drop
    
    Author: 
    Date:   

    Filename: project10-04.js
*/


// Page Objects
let pieces = document.getElementsByTagName("span");
let boardSquares = document.querySelectorAll("table#chessboard td");
let whiteBox = document.getElementById("whiteBox");
let blackBox = document.getElementById("blackBox");

for (let piece of pieces) {
    piece.draggable = true;
    piece.ondragstart = function(e) {
        e.dataTransfer.setData("text", e.target.id);
    };
}

for (let square of boardSquares) {
    square.ondragover = function(e) {
        e.preventDefault();
    };
    square.ondrop = function(e) {
        e.preventDefault();
        let pieceId = e.dataTransfer.getData("text");
        let movingPiece = document.getElementById(pieceId);
        if (e.target.tagName === "TD") {
            e.target.appendChild(movingPiece);
        } else if (e.target.tagName === "SPAN") {
            let occupyingPiece = e.target;
            let parentSquare = occupyingPiece.parentNode;
            parentSquare.appendChild(movingPiece);
            // Move the occupying piece back to the correct box
            if (occupyingPiece.className === "white") {
                whiteBox.appendChild(occupyingPiece);
            } else {
                blackBox.appendChild(occupyingPiece);
            }
        }
    };
}