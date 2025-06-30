// app/javascript/custom/article_counter.js

// On attend que la page soit entièrement chargée
document.addEventListener("turbo:load", function () {
  // On cherche le bouton par son ID
  const countButton = document.getElementById("count-btn");

  // Si le bouton existe sur la page...
  if (countButton) {
    countButton.addEventListener("click", () => {
      // On compte tous les éléments qui ont la classe "article-card"
      const articleCount = document.querySelectorAll(".article-card").length;

      // On cherche l'élément où afficher le résultat
      const countDisplay = document.getElementById("article-count");

      // On met à jour son contenu avec le nombre trouvé
      countDisplay.textContent = articleCount;
    });
  }
});
