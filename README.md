# National Parks Database Project

Database Course Project, Academic Year 2025/2026

## Project Description
This project implements a comprehensive relational database designed to manage the complex ecosystem of national parks. The system models the interactions between natural resources, administrative entities, tourism facilities, and visitors, providing a robust backend for a potential park management application.

### Key Features and Data Model:
*   **Park & Territory Management**: detailed storage of park information (`PARCO`), including geographical data, accessibility status, and regional classification. It also handles the administrative bodies (`ENTE`) responsible for managing these parks.
*   **Tourism & Accommodation**: manages accommodation facilities (`STRUTTURA_RICETTIVA`) such as hotels and eco-lodges, tracking their amenities, location, and sustainability certifications (CETS).
*   **Recreational Activities**:
    *   **Trails (`TRAGITTI`)**: cataloging routes with difficulty levels, duration, and descriptions.
    *   **Tours (`TOUR`)**: organizing guided tours that encompass specific trails.
    *   **Guides (`GUIDA`)**: managing professional guides with licensing and specialization details.
*   **Visitor Services**:
    *   **Visitor Centers (`CENTRO_VISITA`)**: information points with operating hours and available services.
    *   **News**: publishing updates and news related to specific parks.
*   **User Interaction & & Booking**:
    *   **User Management**: distinct profiles for general visitors (`PERSONA`) and registered users (`UTENTE`).
    *   **Bookings**: functionality for reserving accommodation (`RISERVARE`) and booking guided tours (`PRENOTA`).
    *   **Feedback System**: allows users to rate and review trails, supporting both authenticated and anonymous feedback.

## Included Artifacts
*   **Project Specifications**: Requirements and design documents.
*   **ER Diagram**: Conceptual model located in the `ER/` folder (`ER_DEFINITIVO_t.er`).
*   **Relational Schema**: Markdown documentation of the schema in `ER/Schema_Relazionale.md`.
*   **SQL Scripts**:
    *   `SQL/scriptProject.sql`: DDL statements for creating the tables and constraints.
    *   `SQL/dataProject.sql`: DML statements for populating the database with sample data.
    *   `SQL/testQueryProject.sql`: Example queries for data analysis.

## Getting Started
To set up the database:
1.  Open `SQL/scriptProject.sql`.
2.  Execute the script on your preferred SQL server (PostgreSQL or MySQL) to create the schema.
3.  (Optional) Run `SQL/dataProject.sql` to insert sample data.
4.  Use `SQL/testQueryProject.sql` to test the database functionality.