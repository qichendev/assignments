var video = document.getElementById("example");
var videoSource = document.getElementById("vid-src");
var descriptionSource = document.getElementById("despsrc");

function hamburger() {
  var menu = document.getElementById("menu-links");
  var logo = document.getElementById("ffc-logo");
  if (menu.style.display === "block" && logo.style.display === "none") {
    menu.style.display = "none";
    logo.style.display = "block";
  } else {
    menu.style.display = "block";
    logo.style.display = "none";
  }
}

function burpees() {
  videoSource.src = "media/burpees.mp4";
  descriptionSource.src = "media/burpees-description.vtt";
  video.style.display = "block";
  video.load();
}

function plank() {
  videoSource.src = "media/plank.mp4";
  descriptionSource.src = "media/plank-description.vtt";
  video.style.display = "block";
  video.load();
}

function mountain() {
  videoSource.src = "media/mc.mp4";
  descriptionSource.src = "media/mountain-description.vtt";
  video.style.display = "block";
  video.load();
}

function discount() {
  var promo = document.getElementById("special");
  promo.firstChild.nodeValue = "Promo code: D25START";
  promo.style.color = "#ff0000";
  promo.style.fontSize = "2em";
}
