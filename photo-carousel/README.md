# Photo Carousel Snippet

This snippet lets editors build an accessible image carousel from a hidden authoring table.

## Authoring Fields

| Selector | Required | Notes |
| --- | --- | --- |
| `.carousel-label` | Yes | Short accessible name for the carousel region. |
| `.snippet-row` | Yes | Repeatable row for each slide. Blank rows are ignored. |
| `.carousel-image` | Yes | Insert one image and set meaningful alternative text in image properties. |
| `.photo-carousel-caption` | No | Visible caption. Inline formatting is preserved. |

## Transform Behavior

`omni-fragment.xsl` contains the production snippet templates, including the header/footer asset collection modes for the carousel CSS and JS.

`transform.xsl` is a standalone local test harness. It replaces the table with a `<section class="uwg-c-photo-carousel">` component that matches the shipped CSS and JS. It also removes the WYSIWYG spacer heading immediately following the snippet table.

The output includes previous/next buttons, screen-reader button labels, live slide status text, lazy loading after the first slide, and dot buttons for direct slide navigation.

On desktop, the active image is shown large with smaller, subtle cropped previous/next previews on either side. The previews are sized against the image area rather than the image plus caption. On tablet and mobile widths, only the active image is displayed.
