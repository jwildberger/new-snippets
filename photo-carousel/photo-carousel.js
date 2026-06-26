(function () {
  const carousels = document.querySelectorAll("[data-uwg-photo-carousel]");

  carousels.forEach(function initCarousel(carousel) {
    const slides = Array.from(carousel.querySelectorAll("[data-uwg-photo-carousel-slide]"));
    const dots = Array.from(carousel.querySelectorAll("[data-uwg-photo-carousel-dot]"));
    const previousButton = carousel.querySelector("[data-uwg-photo-carousel-prev]");
    const nextButton = carousel.querySelector("[data-uwg-photo-carousel-next]");
    const status = carousel.querySelector("[data-uwg-photo-carousel-status]");

    if (!slides.length || !previousButton || !nextButton || !status) {
      return;
    }

    let currentIndex = 0;
    let touchStartX = null;
    let touchStartY = null;

    function normalizeIndex(index) {
      if (index < 0) return slides.length - 1;
      if (index >= slides.length) return 0;
      return index;
    }

    function showSlide(index) {
      currentIndex = normalizeIndex(index);

      const previousIndex = slides.length > 2 ? normalizeIndex(currentIndex - 1) : -1;
      const nextIndex = slides.length > 1 ? normalizeIndex(currentIndex + 1) : -1;

      slides.forEach(function (slide, slideIndex) {
        const isCurrent = slideIndex === currentIndex;
        const isPrevious = slideIndex === previousIndex;
        const isNext = slideIndex === nextIndex;
        const position = isCurrent ? "current" : isPrevious ? "previous" : isNext ? "next" : "";

        slide.hidden = !position;
        slide.setAttribute("aria-hidden", String(!isCurrent));

        if (position) {
          slide.setAttribute("data-uwg-photo-carousel-position", position);
        } else {
          slide.removeAttribute("data-uwg-photo-carousel-position");
        }
      });

      dots.forEach(function (dot, dotIndex) {
        if (dotIndex === currentIndex) {
          dot.setAttribute("aria-current", "true");
        } else {
          dot.removeAttribute("aria-current");
        }
      });

      status.textContent = "Slide " + (currentIndex + 1) + " of " + slides.length;
    }

    previousButton.addEventListener("click", function () {
      showSlide(currentIndex - 1);
    });

    nextButton.addEventListener("click", function () {
      showSlide(currentIndex + 1);
    });

    dots.forEach(function (dot, dotIndex) {
      dot.addEventListener("click", function () {
        showSlide(dotIndex);
      });

      dot.addEventListener("keydown", function (event) {
        const key = event.key;

        if (key === "ArrowLeft" || key === "ArrowUp") {
          event.preventDefault();

          const previousIndex = normalizeIndex(dotIndex - 1);

          showSlide(previousIndex);
          dots[previousIndex].focus();
        }

        if (key === "ArrowRight" || key === "ArrowDown") {
          event.preventDefault();

          const nextIndex = normalizeIndex(dotIndex + 1);

          showSlide(nextIndex);
          dots[nextIndex].focus();
        }

        if (key === "Home") {
          event.preventDefault();

          showSlide(0);
          dots[0].focus();
        }

        if (key === "End") {
          event.preventDefault();

          const lastIndex = slides.length - 1;

          showSlide(lastIndex);
          dots[lastIndex].focus();
        }
      });
    });

    carousel.addEventListener(
      "touchstart",
      function (event) {
        const touch = event.changedTouches[0];

        touchStartX = touch.screenX;
        touchStartY = touch.screenY;
      },
      { passive: true }
    );

    carousel.addEventListener(
      "touchend",
      function (event) {
        if (touchStartX === null || touchStartY === null) {
          return;
        }

        const touch = event.changedTouches[0];
        const diffX = touch.screenX - touchStartX;
        const diffY = touch.screenY - touchStartY;

        touchStartX = null;
        touchStartY = null;

        if (Math.abs(diffX) < 50 || Math.abs(diffX) < Math.abs(diffY)) {
          return;
        }

        if (diffX > 0) {
          showSlide(currentIndex - 1);
        } else {
          showSlide(currentIndex + 1);
        }
      },
      { passive: true }
    );

    showSlide(0);
  });
})();
