Academic Journal Management System
An editorial management system for academic journals built with Flask, MariaDB, and Python. Features a full double-blind peer-review workflow, role-based access control, reporting, and data auditing using Stored Procedures, Views, and Triggers.

Prerequisites

To run this system locally or on a server, ensure you have the following installed:
    Operating System: Linux (Recommended for production), macOS, or Windows.
    Python: Version 3.10 or higher.
    Database: MySQL or MariaDB server.
    System Tools: unzip for extracting the project and pip.
    System Libraries (Linux only): libmysqlclient-dev required to compile the MySQL driver for Python.

Steps to Run the System:

1. Extract the Project Files
Place the proyecto_revista.zip file in your desired directory and extract its contents:

On Linux/macOS:
    sudo apt-get install unzip
    unzip proyecto_revista.zip
    cd proyecto_revista

On Windows:
Right-click the zip file and select "Extract All", then open the folder in your terminal, CMD or PowerShell.

2. Set Up the Database
Log into your MySQL/MariaDB server as root:
                             
    mysql -u root -p

Create the database and a dedicated user:

    CREATE DATABASE IF NOT EXISTS revista_academica;
    CREATE USER 'ra_usuario'@'localhost' IDENTIFIED BY '666';
    GRANT ALL PRIVILEGES ON revista_academica.* TO 'ra_usuario'@'localhost';
    FLUSH PRIVILEGES;
    EXIT;

Load the database dump:
Make sure the file dump.sql is in the current folder.

    mysql -u ra_usuario -p revista_academica < dumpproyecto.sql

3. Install Python Dependencies
It is highly recommended to use a virtual environment to avoid conflicts.

    python3 -m venv venv

# Activate the environment
# Linux/macOS:
    source venv/bin/activate
# Windows:
    venv\Scripts\activate

# Install the required libraries
    pip install -r requirements.txt


4. Configure Environment Variables
Create a .env file in the root directory of the project (app/) to store your configuration securely.

    File: .env
    DB_HOST=localhost
    DB_USER=ra_usuario
    DB_PASSWORD=password123
    DB_NAME=revista_academica
    SECRET_KEY=your_secure_random_key


5. Run the Application
Set the Flask environment variable and start the server:

On Linux/macOS:

    export FLASK_APP=app.py
    flask run --host=0.0.0.0


On Windows (PowerShell):

    $env:FLASK_APP = "app.py"
    flask run --host=0.0.0.0

By default, the application runs on port 5000.

Access the System
Open your web browser and navigate to:
                             
    http://localhost:5000

Test Credentials
The system comes pre-loaded with users representing different roles in the editorial workflow. The password for all test accounts is: '123'

Role
Username
Permissions
Editor in Chief
editorjefe
Manage articles, assign reviewers, view audit logs, publish issues.
Author
a.einstein
Submit articles, upload new versions, check status.
Reviewer
i.newton
Receive assignments, download manuscripts, submit reviews.
Hybrid User
m.curie
Has both Author and Reviewer panels enabled.

Technical Features
Advanced Database Design: Database schema normalized to 3rd Normal Form (3NF).
Business Logic in DB: Heavy use of Stored Procedures for atomic operations (assignments, versioning) and Triggers for business rules (e.g., blocking assignments if a reviewer is overloaded or has a conflict of interest).
Auditing: Automatic logging of all INSERT, UPDATE, and DELETE operations on critical tables via triggers.
Real-time Metrics: Dashboard powered by SQL Views and Chart.js.

Important Notes
File Uploads: Ensure the static/uploads directory exists and has write permissions, as this is where article files (PDF/DOCX) are stored.
Production: For a production environment, do not use the built-in Flask development server. Use a WSGI server like Gunicorn or uWSGI behind a reverse proxy like Nginx.
This application relies on a comprehensive database schema. You must load the provided SQL dump which contains the structure (tables, views, triggers, procedures) and initial data.
