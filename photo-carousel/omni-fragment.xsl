<!-- =================== -->
<!-- Photo Carousel      -->
<!-- =================== -->

<xsl:template match="table[contains(concat(' ', normalize-space(@class), ' '), ' photo-carousel ')]" mode="collect-header-assets">
    <xsl:sequence select="'https://www.westga.edu/_z_resources/css/photo-carousel.css'"/>
</xsl:template>

<xsl:template match="table[contains(concat(' ', normalize-space(@class), ' '), ' photo-carousel ')]" mode="collect-footer-assets">
    <xsl:sequence select="'https://www.westga.edu/_z_resources/js/photo-carousel.js'"/>
</xsl:template>

<xsl:template match="table[contains(@class,'photo-carousel')]">

    <xsl:variable name="carousel-label"
                  select="normalize-space(tbody/tr/td[@class='carousel-label'])"/>

    <xsl:variable name="slides"
                  select="tbody/tr[contains(@class,'snippet-row')]
                          [td[@class='carousel-image']//img]"/>

    <xsl:if test="count($slides) &gt; 0">

        <section class="uwg-c-photo-carousel"
                 data-uwg-photo-carousel=""
                 aria-roledescription="carousel">

            <xsl:attribute name="aria-label">
                <xsl:choose>
                    <xsl:when test="$carousel-label != ''">
                        <xsl:value-of select="$carousel-label"/>
                    </xsl:when>
                    <xsl:otherwise>Photo gallery</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <div class="uwg-c-photo-carousel__viewport">
                <ol class="uwg-c-photo-carousel__slides">

                    <xsl:for-each select="$slides">

                        <xsl:variable name="image"
                                      select="td[@class='carousel-image']//img[1]"/>

                        <li class="uwg-c-photo-carousel__slide"
                            data-uwg-photo-carousel-slide="">

                            <xsl:if test="position() &gt; 1">
                                <xsl:attribute name="hidden">hidden</xsl:attribute>
                            </xsl:if>

                            <figure class="uwg-c-photo-carousel__figure">

                                <img class="uwg-c-photo-carousel__image">

                                    <xsl:attribute name="src">
                                        <xsl:value-of select="$image/@src"/>
                                    </xsl:attribute>

                                    <xsl:attribute name="alt">
                                        <xsl:value-of select="$image/@alt"/>
                                    </xsl:attribute>

                                    <xsl:if test="position() &gt; 1">
                                        <xsl:attribute name="loading">lazy</xsl:attribute>
                                    </xsl:if>

                                </img>

                                <xsl:if test="normalize-space(
                                    td[@class='photo-carousel-caption']
                                ) != ''">

                                    <figcaption class="uwg-c-photo-carousel__caption">
                                        <xsl:apply-templates
                                            select="td[@class='photo-carousel-caption']/node()"/>
                                    </figcaption>

                                </xsl:if>

                            </figure>
                        </li>

                    </xsl:for-each>

                </ol>
            </div>

            <div class="uwg-c-photo-carousel__controls">

                <button class="uwg-c-photo-carousel__button"
                        type="button"
                        data-uwg-photo-carousel-prev="">

                    <span aria-hidden="true">&#8249;</span>

                    <span class="uwg-c-photo-carousel__sr-only">
                        Previous slide
                    </span>

                </button>

                <p class="uwg-c-photo-carousel__status"
                   data-uwg-photo-carousel-status=""
                   aria-live="polite"
                   aria-atomic="true">

                    <xsl:text>Slide 1 of </xsl:text>
                    <xsl:value-of select="count($slides)"/>

                </p>

                <button class="uwg-c-photo-carousel__button"
                        type="button"
                        data-uwg-photo-carousel-next="">

                    <span aria-hidden="true">&#8250;</span>

                    <span class="uwg-c-photo-carousel__sr-only">
                        Next slide
                    </span>

                </button>

            </div>

            <div class="uwg-c-photo-carousel__dots"
                 role="group"
                 aria-label="Choose slide">

                <xsl:for-each select="$slides">

                    <button type="button"
                            data-uwg-photo-carousel-dot="">

                        <xsl:attribute name="aria-label">
                            <xsl:text>Show slide </xsl:text>
                            <xsl:value-of select="position()"/>
                        </xsl:attribute>

                        <xsl:if test="position() = 1">
                            <xsl:attribute name="aria-current">true</xsl:attribute>
                        </xsl:if>

                    </button>

                </xsl:for-each>

            </div>

        </section>

    </xsl:if>

</xsl:template>

