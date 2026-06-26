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

`transform.xsl` replaces the table with a `<section class="uwg-c-photo-carousel">` component that matches the shipped CSS and JS. It also removes the WYSIWYG spacer heading immediately following the snippet table.

The output includes previous/next buttons, live slide status text, and dot buttons for direct slide navigation.

