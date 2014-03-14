# Invoice generator

Invoice generator using lots of XML. It generates (X)HTML file from invoice data (XML) and invoice template (XSL) using
the [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html) utility. The generated markup is piped to
[wkhtmltopdf](http://wkhtmltopdf.org/) which generates the final PDF output.

## Installation

Both xsltproc and wkhtmltopdf must be installed already. Xsltproc is installed by default on
most Linux distros and OS X.

The `install` target will intall into `/opt/invoice` and symlink the command to `/usr/local/bin/invoice`.

    make install

## Using

See example invoice and output in the `example` directory. Processing an invoice file:

    invoice <lang identifier> path/to/invoice.xml

This will create a .pdf file in the same directory the .xml file is in.

## License

The MIT License. See the LICENSE file.

Take and modify templates for your needs if you find this useful.
