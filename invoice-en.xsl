<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exslt="http://exslt.org/common">

    <xsl:output method="html"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" indent="yes" />

    <xsl:variable name="lineTotals">
        <xsl:for-each select="/invoice/lines/line">
            <value line="{position()}">
                <xsl:value-of select="format-number(amount * price, '#.00')" />
            </value>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/invoice">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>
                    <xsl:value-of select="concat('Invoice # ', number)" />
                </title>
                <base href="file://{$base}" />
                <link rel="stylesheet" href="invoice.css" type="text/css" />
            </head>
            <body>
                <div class="header">
                    <div class="invoice-title">
                        <h1><xsl:value-of select="concat('Invoice # ', number)" /></h1>
                    </div>
                    <div class="invoice-date">
                        <xsl:value-of select="date" />
                    </div>
                </div>

                <h2>From</h2>
                <div class="invoice-issuer">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="2" class="head">Infdot OÜ</td>
                        </tr>
                        <tr>
                            <td class="field">Register code</td>
                            <td class="data">11925706</td>
                        </tr>
                        <tr>
                            <td class="field">Address</td>
                            <td class="data">Nooruse 13-39, Elva, Tartumaa, 61507, Estonia</td>
                        </tr>
                        <tr>
                            <td class="field">Contact</td>
                            <td class="data">Raivo Laanemets (info@infdot.com)</td>
                        </tr>
                    </table>
                </div>

                <h2>To</h2>
                <div class="invoice-recipient">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="2" class="head">
                                <xsl:value-of select="recipient/name" />
                            </td>
                        </tr>
                        <tr>
                            <td class="field">Address</td>
                            <td>
                                <xsl:value-of select="recipient/address" />
                            </td>
                        </tr>
                        <tr>
                            <td class="field">Contact</td>
                            <td>
                                <xsl:value-of select="recipient/contact" />
                            </td>
                        </tr>
                    </table>
                </div>

                <h2>Items</h2>
                <div class="invoice-lines">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <th class="table-text table-header">Activity</th>
                            <th class="table-number lines-amount table-header">Amount</th>
                            <th class="table-number lines-unit table-header">Unit price</th>
                            <th class="table-number lines-total table-header">Total</th>
                        </tr>
                        <xsl:for-each select="lines/line">
                            <tr>
                                <td class="table-text">
                                    <xsl:value-of select="description" />
                                </td>
                                <td class="table-number">
                                    <xsl:value-of select="amount" /><xsl:text> </xsl:text><xsl:value-of select="unit" />
                                </td>
                                <td class="table-number">
                                    <xsl:value-of select="price" /><xsl:text> </xsl:text><xsl:value-of select="/invoice/currency" />/<xsl:value-of select="unit" />
                                </td>
                                <td class="table-number">
                                    <xsl:variable name="line" select="position()" />
                                    <xsl:value-of select="exslt:node-set($lineTotals)/value[position() = $line]" /><xsl:text> </xsl:text><xsl:value-of select="/invoice/currency" />
                                </td>
                            </tr>
                        </xsl:for-each>
                        <tr>
                            <td colspan="2"></td>
                            <th class="table-number table-total">Grand total</th>
                            <td class="table-number table-total">
                                <xsl:value-of select="sum(exslt:node-set($lineTotals)/value)" /><xsl:text> </xsl:text><xsl:value-of select="/invoice/currency" />
                            </td>
                        </tr>
                    </table>
                </div>

                <h2>Payment</h2>
                <div class="invoice-payment">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="field">Receiver</td>
                            <td>INFDOT OÜ</td>
                        </tr>
                        <tr>
                            <td class="field">Bank account</td>
                            <td>IBAN: EE787700771000825297, BIC: LHVBEE22, AS LHV Pank</td>
                        </tr>
                        <tr>
                            <td class="field">Due to</td>
                            <td><xsl:value-of select="due-date"/></td>
                        </tr>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
