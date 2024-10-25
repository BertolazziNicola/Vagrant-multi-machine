# Vagrant Project by Nicolà Bertolazzi I4AA

## Project Overview

This project involves creating two Virtual Machines (VMs) using the box `ubuntu/jammy64`. The purpose of the VMs is to set up a web server and a database server, allowing for a backend framework and database management.

### Project Features

- **VM Setup**: Create two VMs, named `web.m340` and `db.m340`, with appropriate hostnames for VirtualBox.
- **Web Server**: Install a web server and a backend framework (PHP, Flask, Node.js, etc.) on the "web" VM.
- **Database Server**: Install a database (MySQL or MariaDB) on the "db" VM.
- **Proxy Configuration**: Set up proxy settings correctly.
- **Database Management Tool**: Suggest installing a database management application such as:
  - [SQLBuddy](http://sqlbuddy.com/)
  - [Adminer](https://www.adminer.org/)
  - Any page that queries the database to demonstrate that the connection works.
- **Configuration through Variables**:
  - **Proxy URL**: Set the proxy using the variable `PROXY_URL = "http://IPPROXY:PORT"`.
  - **Proxy Enable/Disable**: Control the ability to disable the proxy with `PROXY_ENABLE = false`.
  - **Plugin Check**: Ensure that the plugin `vagrant-proxyconf` exists.
- **Network Configuration**:
  - **Base Internal Network**: Set up `BASE_INT_NETWORK = "10.10.20"`; the two VMs will have IPs 10 and 11.
  - **Base Host-Only Network**: Configure `BASE_HOST_ONLY_NETWORK = "192.168.56"`; the web VM will have IP 10.
- **Box Image**: Use the box image `BOX_IMAGE = "ubuntu/jammy64"`.
- **Provisioning**: Set up provisioning for both the web server and database server.
- **Automatic Mounting**: Automatically mount the folder containing website pages via `synced_folder`.
- **Database Connection**: Do not use the root user for connecting the web application to the database.

### Password Management

- The database passwords are generated and stored in the `/passwords` directory.

### Website folder

- The website folder is located at /src in the Vagrant folder and at /var/www/html (default) in the web.m340 Virtual Machine.

### Resources Used

- Online documentation and ChatGPT assistance.