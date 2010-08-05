<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="id"/>
  <xsl:param name="type"/>
  <xsl:param name="search"/>
  <xsl:param name="style"/>
  <xsl:param name="size"/>

  <xsl:key name="GetItemById" match="data/*/*" use="@id"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>SSYP 2009</title>
        <xsl:variable name="css_style" select="/data/*/style[@id=$style]"/>
        <xsl:choose>
          <xsl:when test="$css_style/path">
            <link type="text/css" href="{$css_style/path/text()}" rel="stylesheet"/>
          </xsl:when>
          <xsl:otherwise>
            <link type="text/css" href="./templates/blue.css" rel="stylesheet"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:variable name="css_size" select="/data/*/style[@id=$size]"/>
        <xsl:choose>
          <xsl:when test="$css_size/path">
            <link type="text/css" href="{$css_size/path/text()}" rel="stylesheet"/>
          </xsl:when>
          <xsl:otherwise>
            <link type="text/css" href="./templates/normal.css" rel="stylesheet"/>
          </xsl:otherwise>
        </xsl:choose>
      </head>
      <body>
        <center>
          <div class="main">
            <div class="top">
              <table class="top_table">
                <tr>
                  <td class="top_link">
                    <a class="top" href="?">главная</a>
                  </td>
                  <td class="top_link">
                    <a class="top" href="?id=sozdateli-2009">создатели</a>
                  </td>
                  <td class="top_link">
                    <xsl:text> </xsl:text>
                  </td>
                  <td class="middle_table">
                  </td>
                  <td class="search">
                    <form action="?" method="get">
                      <input type="text" name="search" />
                      <input type="submit" value="Поиск" />
                    </form>
                  </td>
                </tr>
              </table>
            </div>
            <div class="body">
              <table border="0">
                <tr>
                  <td valign="top" width="140">
                    <div  class="nvg">
                      <div class="logo">
                        <img src="img/logo.png" style="border:0px;" width="140" height="120"/>
                      </div>
                      <div class="nav">
                        <br/>
                        <div class="link_menu" onmouseover = "this.className = 'link_menu_effect'" onmouseout = "this.className = 'link_menu'">
                          <a class="menu" href="?">главная</a>
                        </div>
                        <div class="link_menu" onmouseover = "this.className = 'link_menu_effect'" onmouseout = "this.className = 'link_menu'">
                          <a class="menu" href="?type=collection">коллекции</a>
                        </div>
                        <div class="link_menu" onmouseover = "this.className = 'link_menu_effect'" onmouseout = "this.className = 'link_menu'">
                          <a class="menu" href="?type=person">люди</a>
                        </div>
                        <div class="link_menu" onmouseover = "this.className = 'link_menu_effect'" onmouseout = "this.className = 'link_menu'">
                          <a class="menu" href="?type=mastersk">мастерские</a>
                        </div>
                        <div class="link_menu" onmouseover = "this.className = 'link_menu_effect'" onmouseout = "this.className = 'link_menu'">
                          <a class="menu" href="?id=sozdateli-2009">создатели</a>
                        </div>
                        <div class="link_menu" onmouseover = "this.className = 'link_menu_effect'" onmouseout = "this.className = 'link_menu'">
                          <a class="menu" href="http://school.iis.nsk.su">ЛШЮП</a>
                        </div>
                        <hr/>
                        <div class="link_menu">
                          <a class="menu" style="font-size: 13px;" href="?style=blue&amp;id={$id}">blue /</a>
                          <a class="menu" style="font-size: 13px;" href="?style=gray&amp;id={$id}"> gray /</a>
                          <a class="menu" style="font-size: 13px;" href="?style=emo&amp;id={$id}"> emo</a>
                        </div>
                        <div class="link_menu">
                          <a class="menu" style="font-size: 13px;" href="?size=small&amp;id={$id}">small /</a>
                          <a class="menu" style="font-size: 13px;" href="?size=normal&amp;id={$id}"> normal /</a>
                          <a class="menu" style="font-size: 13px;" href="?size=big&amp;id={$id}"> big</a>
                        </div>
                      </div>
                    </div>
                  </td>
                  <td valign="top" width="717">
                    <div class="content">
                      <xsl:apply-templates select="data"/>
                      <br/>
                      <br/>
                    </div>
                  </td>
                </tr>
              </table>
              <div style="font-size:8pt; margin-top: 30px;">
                <span style="color: #f9f7f7;">няяяяяяяяя</span>
                <br />
                All rights reserved. Best view with <a class="podpis" href="http://getfirefox.com">Firefox</a>, <a class="podpis" href="http://opera.com">Opera</a>, <a class="podpis" href="http://google.com/chrome">Chrome</a>.
                <br/>
                by <a class="podpis" href="?id=syp2009_p68">Dr.Overclock</a> &amp; <a class="podpis" href="?id=syp2009_p67">mMaxy</a><br/>
                Release
              </div>
            </div>
          </div>
        </center>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="data">
    <xsl:call-template name="db"/>
  </xsl:template>

  <xsl:template name="db">
    <xsl:choose>
      <xsl:when test="$id">
        <xsl:apply-templates select="key('GetItemById',$id)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$type">
            <xsl:variable name="items" select="/data/*/*[name()=$type]"/>
            <xsl:for-each select="$items">
              <xsl:sort select="./name/text()"/>
              <xsl:apply-templates select=".">
                <xsl:with-param name="type" select="$type"/>
              </xsl:apply-templates>
            </xsl:for-each>
          </xsl:when>
          <xsl:when test="$search">
            <xsl:variable name="items" select="/data/*/*[starts-with(translate
                          (name,'qazwsxedcrfvtgbyhnujmikolpйфяцычувскамепинртгоьшлбщдюзжхэъё',
                                'QAZWSXEDCRFVTGBYHNUJMIKOLPЙФЯЦЫЧУВСКАМЕПИНРТГОЬШЛБЩДЮЗЖХЭЪЁ'),
                          translate($search,'qazwsxedcrfvtgbyhnujmikolpйфяцычувскамепинртгоьшлбщдюзжхэъё',
                                            'QAZWSXEDCRFVTGBYHNUJMIKOLPЙФЯЦЫЧУВСКАМЕПИНРТГОЬШЛБЩДЮЗЖХЭЪЁ'))]"/>
            <xsl:for-each select="$items">
              <xsl:apply-templates select="."/>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="list"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="def" match="*">
    <xsl:variable name="item" select="key('GetItemById',$id)"/>
    <h3>
      <xsl:value-of select="name($item)"/>
    </h3>
    <table border="1">
      <xsl:for-each select="$item/*">
        <tr>
          <td>
            <xsl:value-of select="name(.)"/>
          </td>
          <td>
            <xsl:choose>
              <xsl:when test="@ref">
                <xsl:call-template name="ViewItemTable">
                  <xsl:with-param name="p_inline" select="@ref"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="text()"/>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:variable name="link" select="/data/*/*/*[@ref=$id]" />
      <xsl:for-each select="$link">
        <xsl:variable name="parent" select="parent::*" />
        <xsl:call-template name="ViewItemTable">
          <xsl:with-param name="p_inline" select="$parent/@id" />
        </xsl:call-template>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template name="ViewItemTable">
    <xsl:param name="p_inline"/>
    <xsl:variable name ="i_inline" select="key('GetItemById',$p_inline)" />
    <xsl:for-each select="$i_inline/*">
      <xsl:choose>
        <xsl:when test="@ref=$id">
          <xsl:value-of select="text()"/>
        </xsl:when>
        <xsl:when test="@ref">
          <xsl:call-template name="ViewItemTable">
            <xsl:with-param name="p_inline" select="@ref"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <tr>
            <td>
              <xsl:value-of select="name(.)"/>
            </td>
            <td>
              <a href="?id={$i_inline/@id}">
                <xsl:value-of select="text()"/>
              </a>
            </td>
          </tr>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="mastersk">
    <xsl:choose>
      <xsl:when test="$type">
        <center>
          <xsl:for-each select="/data/*/mastersk">
            <xsl:sort select="./name/text()"/>
            <div class="elem_div_400">
              <a href="?id={@id}" class="menu">
                <xsl:value-of select="./name"/>
              </a>
            </div>
          </xsl:for-each>
        </center>
      </xsl:when>
      <xsl:otherwise>
        <div class="header">
          Мастерская:
          <a href="?id={@id}">
            <xsl:value-of select="./name"/>
          </a>
        </div>
        <center>
          <xsl:variable name="entry" select="./@id" />
          <xsl:variable name="link" select="/data/*/org-relatives/*[@ref=$entry]" />
          <xsl:for-each select="$link">
            <xsl:variable name="link_par" select="parent::*"/>
            <xsl:variable name="link_org" select="$link_par/org-parent/@ref"/>
            <xsl:variable name="org" select="/data/*/org-sys[@id=$link_org]"/>
            <xsl:if test="$org/from-date">
              <div class="elem_div_40">
                <a href="?id={$org/@id}">
                  <xsl:value-of select="$org/name"/>
                </a>
              </div>
              <br/>
            </xsl:if>
          </xsl:for-each>
          <xsl:variable name="entry2" select="./@id" />
          <xsl:variable name="link3" select="/data/*/reflection/*[@ref=$entry2]"/>
          <xsl:if test="$link3">
            <xsl:for-each select="$link3">
              <xsl:variable name="link3_par" select="parent::*"/>
              <xsl:variable name="link3_photo" select="$link3_par/in-doc/@ref"/>
              <xsl:variable name="photo" select="/data/*/photo-doc[@id=$link3_photo]"/>
              <xsl:if test="$photo">
                <br/>
                <a href="?id={$photo/@id}">
                  <img src="{$photo/published}_M.jpg"/>
                </a>
                <br/>
                <br/>
              </xsl:if>
              <xsl:text> </xsl:text>
            </xsl:for-each>
          </xsl:if>
          <div class="title_div_200">
            Участники
          </div>
          <xsl:variable name="link2" select="/data/*/uchastie/*[@ref=$entry]" />
          <xsl:for-each select="$link2">
            <xsl:variable name="link2_par" select="parent::*"/>
            <xsl:variable name="link2_person" select="$link2_par/uchastnik/@ref"/>
            <xsl:variable name="person2" select="/data/*/person[@id=$link2_person]"/>
            <xsl:choose>
              <xsl:when test="$person2">
                <div class="elem_div_400">
                  <a class="menu" href="?id={$person2/@id}">
                    <xsl:value-of select="$person2/name"/>
                  </a>
                </div>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </center>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="person">
    <xsl:choose>
      <xsl:when test="$type">
        <center>
          <div class="elem_div_400">
            <a href="?id={@id}" class="menu">
              <xsl:value-of select="./name"/>
            </a>
          </div>
        </center>
      </xsl:when>
      <xsl:otherwise>
        <center>
          <xsl:variable name="entry" select="./@id" />
          <div class="header">
            <a href="?id={@id}">
              <xsl:value-of select="./name"/>
            </a>
          </div>
          <table class="pers_all">
            <tr>
              <td class="pers_data">
                <xsl:variable name="link" select="/data/*/uchastie/*[@ref=$entry]"/>
                <xsl:if test="$link">
                  <br/>
                  <div class="elem_div_200">
                    <span class="elem_evident">Имя</span>
                    <xsl:text>: </xsl:text>
                    <a href="?id={./@id}">
                      <xsl:value-of select="./name"/>
                    </a>
                  </div>
                  <br/>
                  <xsl:variable name="from" select="/data/*/living/*[@ref=$entry]"/>
                  <xsl:for-each select="$from">
                    <xsl:variable name="par" select="parent::*"/>
                    <xsl:variable name="city" select="/data/*/city[@id=$par/where/@ref]"/>
                    <xsl:if test="$city">
                      <div class="elem_div_200">
                        <span class="elem_evident">Город</span>
                        <xsl:text>: </xsl:text>
                        <a href="?id={$city/@id}">
                          <xsl:value-of select="$city/name/text()"/>
                        </a>
                      </div>
                    </xsl:if>
                  </xsl:for-each>
                  <br/>
                  <xsl:for-each select="$link">
                    <xsl:variable name="link_par" select="parent::*"/>
                    <xsl:variable name="link_org" select="$link_par/in-org/@ref"/>
                    <xsl:variable name="org" select="/data/*/org-sys[@id=$link_org]"/>
                    <xsl:if test="$org">
                      <xsl:if test="$org/name">
                        <div class="elem_div_200">
                          <span class="elem_evident">Школа</span>
                          <xsl:text>: </xsl:text>
                          <a href="?id={$org/@id}">
                            <xsl:value-of select="$org/name"/>
                          </a>
                        </div>
                      </xsl:if>
                    </xsl:if>
                  </xsl:for-each>
                  <br/>
                  <xsl:for-each select="$link">
                    <xsl:variable name="link_par2" select="parent::*"/>
                    <xsl:variable name="link_org2" select="$link_par2/in-org/@ref"/>
                    <xsl:variable name="org2" select="/data/*/mastersk[@id=$link_org2]"/>
                    <xsl:if test="$org2">
                      <div class="elem_div_200">
                        <span class="elem_evident">Мастерская</span>
                        <xsl:text>: </xsl:text>
                        <a href="?id={$org2/@id}">
                          <xsl:value-of select="$org2/name"/>
                        </a>
                      </div>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:if>
              </td>
              <td class="pers_photo">
                <xsl:variable name="entry2" select="./@id" />
                <xsl:variable name="link3" select="/data/*/reflection/*[@ref=$entry2]"/>
                <xsl:if test="$link3">
                  <xsl:for-each select="$link3">
                    <xsl:variable name="link3_par" select="parent::*"/>
                    <xsl:variable name="link3_photo" select="$link3_par/in-doc/@ref"/>
                    <xsl:variable name="photo" select="/data/*/photo-doc[@id=$link3_photo]"/>
                    <xsl:if test="$photo">
                      <a href="?id={$photo/@id}">
                        <img src="{$photo/published}_s.jpg"/>
                      </a>
                    </xsl:if>
                    <xsl:text> </xsl:text>
                  </xsl:for-each>
                </xsl:if>
              </td>
            </tr>
          </table>
        </center>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="org-sys">
    <center>
      <xsl:variable name="entry" select="./@id" />
      <div class="header">
        <a href="?id={@id}">
          <xsl:value-of select="./name"/>
        </a>
      </div>
      <xsl:variable name="link" select="/data/*/org-relatives/*[@ref=$entry]"/>
      <xsl:if test="$link">
        <br/>
        <div class="spisok_masterskih">
          <div class="title_div_200">
            Мастерские
          </div>
          <xsl:for-each select="$link">
            <xsl:variable name="link_par" select="parent::*"/>
            <xsl:variable name="link_mast" select="$link_par/org-child/@ref"/>
            <xsl:variable name="mast" select="/data/*/mastersk[@id=$link_mast]"/>
            <div class="elem_div_200_color">
              <a href="?id={$mast/@id}" class="menu">
                <xsl:value-of select="$mast"/>
              </a>
            </div>
          </xsl:for-each>
        </div>
      </xsl:if>
      <xsl:variable name="link2" select="/data/*/uchastie/*[@ref=$entry]" />
      <xsl:if test="$link2">
        <div class="sspisok_uchastnikov">
          <div class="title_div_200_r">
            Участники
          </div>
          <br/>
          <br/>
          <xsl:for-each select="$link2">
            <xsl:variable name="link2_par" select="parent::*"/>
            <xsl:variable name="link2_person" select="$link2_par/uchastnik/@ref"/>
            <xsl:variable name="person2" select="/data/*/person[@id=$link2_person]"/>
            <xsl:choose>
              <xsl:when test="$person2">
                <div class="elem_div_400_r">
                  <a href="?id={$person2/@id}" class="menu">
                    <xsl:value-of select="$person2/name"/>
                  </a>
                </div>
                <br/>
              </xsl:when>
            </xsl:choose>
          </xsl:for-each>
        </div>
      </xsl:if>
    </center>
  </xsl:template>

  <xsl:template match="collection">
    <center>
      <div class="elem_div_400">
        <a class="menu" href="?id={@id}">
          <xsl:value-of select="./name/text()"/>
        </a>
      </div>
      <xsl:if test="$id">
        <xsl:variable name="entry" select="./@id"/>
        <xsl:variable name="link" select="/data/*/*/*[@ref=$entry]"/>
        <xsl:for-each select="$link">
          <xsl:variable name="link_par" select="parent::*"/>
          <xsl:variable name="link_elem" select="$link_par/collection-item/@ref"/>
          <xsl:variable name="elem" select="/data/*/*[@id=$link_elem]"/>
          <xsl:choose>
            <xsl:when test="$elem/published">
              <a href="?id={$elem/@id}">
                <img src="{$elem/published}_s.jpg"/>
              </a>
              <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <br/>
              <div class="elem_div_200_col">
                <a class="menu" href="?id={$elem/@id}">
                  <xsl:value-of select="$elem/name"/>
                </a>
              </div>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:if>
    </center>
  </xsl:template>

  <xsl:template match="photo-doc">
    <center>
      <div class="header" style="margin-bottom: 20px;">
        Фото-документ
      </div>
      <div>
        <img src="{./published/text()}_m.jpg"/>
        <xsl:if test="./from-date">
          <div class="year" style="height: 20px; background-color: rgb(218, 225, 232); width: 50px;">
            <xsl:value-of select="./from-date/text()"/>
          </div>
        </xsl:if>
      </div>
      <div class="title_div_200">
        На фотографии присутствуют:
      </div>
      <div>
        <xsl:variable name="link" select="/data/*/reflection/*[@ref=$id]"/>
        <xsl:for-each select="$link">
          <xsl:variable name="link_par" select="parent::*"/>
          <xsl:variable name="link_obj" select="$link_par/reflected/@ref"/>
          <xsl:variable name="pers" select="/data/*/person[@id=$link_obj]"/>
          <xsl:if test="$pers">
            <div class="elem_div_400">
              <a class="menu" href="?id={$pers/@id}">
                <xsl:value-of select="$pers/name/text()"/>
              </a>
            </div>
          </xsl:if>
        </xsl:for-each>
        <br/>
        <xsl:variable name="link2" select="/data/*/reflection/*[@ref=$id]"/>
        <xsl:for-each select="$link2">
          <xsl:variable name="link_par2" select="parent::*"/>
          <xsl:variable name="link_obj2" select="$link_par2/reflected/@ref"/>
          <xsl:variable name="mastersk" select="/data/*/mastersk[@id=$link_obj2]"/>
          <xsl:if test="$mastersk">
            <div class="elem_div_400">
              <a class="menu" href="?id={$mastersk/@id}">
                <xsl:text>Мастерская: </xsl:text>
                <xsl:value-of select="$mastersk/name/text()"/>
              </a>
            </div>
          </xsl:if>
        </xsl:for-each>
      </div>
    </center>
  </xsl:template>

  <xsl:template match='city'>
    <center>
      <xsl:variable name="item" select="."/>
      <div class="header">
        <xsl:value-of select="$item/name"/>
      </div>
      <br/>
      <xsl:for-each select="/data/*/living/where[@ref=$item/@id]">
        <xsl:variable name="refper" select="parent::living/who/@ref" />
        <div class="elem_div_400">
          <a class="menu" href='?id={$refper}'>
            <xsl:value-of select="/data/*/person[@id=$refper]/name/text()"/>
          </a>
        </div>
      </xsl:for-each>
    </center>
  </xsl:template>

  <xsl:template name="list">
    <center>
      <br/>
      <xsl:variable name="item" select="/data/*/org-sys[starts-with(name,'ЛШ')]"/>
      <xsl:for-each select="$item">
        <div class="elem_div_400">
          <a class="menu" href="?id={@id}">
            <xsl:value-of select="./name"/>
          </a>
        </div>
      </xsl:for-each>
    </center>
  </xsl:template>
</xsl:stylesheet>