FROM odoo:15.0

# Set environment variables
ENV ODOO_DATABASE=odoo
ENV ODOO_USER=odoo
ENV ODOO_PASSWORD=odoo

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-dev \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    libevent-dev \
    libsasl2-dev \
    libldap2-dev \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libssl-dev \
    libffi-dev \
    libfontconfig \
    libfreetype6 \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    ttf-mscorefonts-installer \
    npm

# Install Odoo modules
RUN mkdir -p /mnt/extra-addons \
    && git clone --depth 1 https://github.com/OCA/partner-contact.git /mnt/extra-addons/partner-contact \
    && git clone --depth 1 https://github.com/OCA/server-tools.git /mnt/extra-addons/server-tools \
    && git clone --depth 1 https://github.com/OCA/l10n-italy.git /mnt/extra-addons/l10n-italy \
    && git clone --depth 1 https://github.com/OCA/account-financial-reporting.git /mnt/extra-addons/account-financial-reporting \
    && git clone --depth 1 https://github.com/OCA/pos.git /mnt/extra-addons/pos \
    && git clone --depth 1 https://github.com/OCA/hr.git /mnt/extra-addons/hr \
    && git clone --depth 1 https://github.com/OCA/reporting-engine.git /mnt/extra-addons/reporting-engine

# Copy Odoo configuration file
COPY ./odoo.conf /etc/odoo/

# Expose Odoo port
EXPOSE 8069

# Start Odoo server
CMD ["odoo", "--config=/etc/odoo/odoo.conf"]
