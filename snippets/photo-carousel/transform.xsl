<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes" />

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="table[contains(concat(' ', normalize-space(@class), ' '), ' ou-snippets ')][contains(concat(' ', normalize-space(@class), ' '), ' photo-carousel ')]">
    <xsl:variable name="label" select="normalize-space(tbody/tr/td[contains(concat(' ', normalize-space(@class), ' '), ' carousel-label ')][1])" />
    <xsl:variable name="slides" select="tbody/tr[contains(concat(' ', normalize-space(@class), ' '), ' snippet-row ')][td[contains(concat(' ', normalize-space(@class), ' '), ' carousel-image ')]//img]" />

    <xsl:choose>
      <xsl:when test="count($slides) &gt; 0">
        <section class="uwg-c-photo-carousel" data-uwg-photo-carousel="" role="region">
          <xsl:attribute name="aria-label">
            <xsl:choose>
              <xsl:when test="$label != ''">
                <xsl:value-of select="$label" />
              </xsl:when>
              <xsl:otherwise>Photo gallery</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>

          <div class="uwg-c-photo-carousel__viewport">
            <ol class="uwg-c-photo-carousel__slides">
              <xsl:for-each select="$slides">
                <xsl:variable name="image" select="td[contains(concat(' ', normalize-space(@class), ' '), ' carousel-image ')]//img[1]" />
                <xsl:variable name="caption" select="td[contains(concat(' ', normalize-space(@class), ' '), ' photo-carousel-caption ')][1]" />

                <li class="uwg-c-photo-carousel__slide" data-uwg-photo-carousel-slide="">
                  <xsl:attribute name="aria-hidden">
                    <xsl:value-of select="position() != 1" />
                  </xsl:attribute>
                  <xsl:if test="position() != 1">
                    <xsl:attribute name="hidden">hidden</xsl:attribute>
                  </xsl:if>

                  <figure class="uwg-c-photo-carousel__figure">
                    <img>
                      <xsl:for-each select="$image/@*[name() != 'class']">
                        <xsl:copy />
                      </xsl:for-each>
                      <xsl:if test="not($image/@alt)">
                        <xsl:attribute name="alt"></xsl:attribute>
                      </xsl:if>
                      <xsl:attribute name="class">
                        <xsl:text>uwg-c-photo-carousel__image</xsl:text>
                        <xsl:if test="normalize-space($image/@class) != ''">
                          <xsl:text> </xsl:text>
                          <xsl:value-of select="normalize-space($image/@class)" />
                        </xsl:if>
                      </xsl:attribute>
                    </img>

                    <xsl:if test="normalize-space($caption) != ''">
                      <figcaption class="uwg-c-photo-carousel__caption">
                        <xsl:copy-of select="$caption/node()" />
                      </figcaption>
                    </xsl:if>
                  </figure>
                </li>
              </xsl:for-each>
            </ol>
          </div>

          <div class="uwg-c-photo-carousel__controls">
            <button type="button" class="uwg-c-photo-carousel__button" data-uwg-photo-carousel-prev="" aria-label="Show previous slide">
              <span aria-hidden="true">&lt;</span>
            </button>
            <p class="uwg-c-photo-carousel__status" data-uwg-photo-carousel-status="" aria-live="polite">
              <xsl:text>Slide 1 of </xsl:text>
              <xsl:value-of select="count($slides)" />
            </p>
            <button type="button" class="uwg-c-photo-carousel__button" data-uwg-photo-carousel-next="" aria-label="Show next slide">
              <span aria-hidden="true">&gt;</span>
            </button>
          </div>

          <div class="uwg-c-photo-carousel__dots" aria-label="Choose slide">
            <xsl:for-each select="$slides">
              <button type="button" data-uwg-photo-carousel-dot="">
                <xsl:attribute name="aria-label">
                  <xsl:text>Show slide </xsl:text>
                  <xsl:value-of select="position()" />
                </xsl:attribute>
                <xsl:if test="position() = 1">
                  <xsl:attribute name="aria-current">true</xsl:attribute>
                </xsl:if>
                <span class="uwg-c-photo-carousel__sr-only">
                  <xsl:text>Slide </xsl:text>
                  <xsl:value-of select="position()" />
                </span>
              </button>
            </xsl:for-each>
          </div>
        </section>
      </xsl:when>
      <xsl:otherwise>
        <xsl:comment> Photo carousel snippet omitted because no image rows were provided. </xsl:comment>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="h4[contains(concat(' ', normalize-space(@class), ' '), ' wysiwyg-spacer ')][preceding-sibling::*[1][self::table[contains(concat(' ', normalize-space(@class), ' '), ' ou-snippets ')][contains(concat(' ', normalize-space(@class), ' '), ' photo-carousel ')]]]" />
</xsl:stylesheet>
