async function refreshHits() {
    const target = document.getElementById("hit-count");

    if (!target) {
        return;
    }

    try {
        const response = await fetch("/api/hits");
        const data = await response.json();
        target.textContent = data.hits;
    } catch (error) {
        target.textContent = "unavailable";
    }
}

refreshHits();
setInterval(refreshHits, 3000);
