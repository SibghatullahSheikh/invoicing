dest=/opt/invoice

install:
	mkdir -p $(dest)
	/usr/bin/install -m 0755 invoice $(dest)
	/usr/bin/install -m 0644 invoice-ee.xsl $(dest)
	/usr/bin/install -m 0644 invoice-en.xsl $(dest)
	/usr/bin/install -m 0644 invoice.css $(dest)
	ln -sf $(dest)/invoice /usr/local/bin/invoice

.PHONY: install
