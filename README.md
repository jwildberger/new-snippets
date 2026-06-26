# New Snippets

Reusable snippet source files for Omni CMS-style authoring tables and their rendered output.

## Snippets

### Photo Carousel

Creates an accessible, progressively enhanced photo carousel.

| File | Purpose |
| --- | --- |
| `assets/css/photo-carousel.css` | Carousel styles copied from `https://www.westga.edu/_z_resources/css/photo-carousel.css`. |
| `assets/js/photo-carousel.js` | Carousel behavior copied from `https://www.westga.edu/_z_resources/js/photo-carousel.js`. |
| `snippets/photo-carousel/table.html` | Blank authoring table for inserting into the WYSIWYG editor. |
| `snippets/photo-carousel/transform.xsl` | XSLT that converts the authoring table into final carousel markup. |
| `examples/photo-carousel.table.html` | Example authoring table with real content filled in. |
| `examples/photo-carousel.output.html` | Example transformed page. |

The XSLT transforms only tables with both `ou-snippets` and `photo-carousel` classes. Blank slide rows are ignored. Each slide row should include one image in the `carousel-image` cell and optional caption content in the `photo-carousel-caption` cell.

## Output Requirements

Pages using the rendered carousel need the CSS and JS assets loaded:

```html
<link rel="stylesheet" href="/_z_resources/css/photo-carousel.css" />
<script src="/_z_resources/js/photo-carousel.js" defer></script>
```

