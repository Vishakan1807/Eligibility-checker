Attendance-Based Scholarship and Exam Eligibility Checker

Description:
This project implements a system to determine student eligibility for scholarships and exam permissions based on attendance records. The system uses Prolog for logical reasoning and rule definition, with attendance data stored in a CSV file. A REST API and a web interface allow users to query student eligibility using their IDs.

Key Features:

Attendance Threshold Rules in Prolog:

Scholarship eligibility and exam permissions are determined by attendance thresholds defined in eligibility_checker.pl.
Prolog rules analyze data and provide outputs based on specified criteria.
CSV Data Integration:

Attendance data is read from data.csv and dynamically loaded into the Prolog knowledge base.
REST API Integration:

A REST API facilitates interaction between the Prolog-based backend and the web application.
The API enables users to query eligibility and debarment status by sending a student ID.
Web Interface:

A simple, user-friendly HTML-based interface (index.html) allows users to input a student ID to check their eligibility status.
The web app integrates with the REST API to fetch and display the results.
Usage:

Load data.csv into the Prolog environment.
Use Prolog's inference engine to evaluate eligibility conditions.
Start the REST API server for external interaction.
Access the index.html page via a browser to query student eligibility statuses.
