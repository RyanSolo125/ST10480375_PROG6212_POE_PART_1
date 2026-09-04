# RaceDay

RaceDay is a web-based event management system for South African road running, walking and cycling events (like the Comrades Marathon, Cape Town Cycle Tour, Soweto Marathon, etc.). Right now event organisers manage everything with paper and spreadsheets, so this system lets them create events online and lets participants browse events, enter them, and check their results.

This is Part 1 of the project (POE). This part is just the planning which consists of the ERD, the API endpoint plan, and the SQL database script. No application code has been created yet.

## What's in this repo

Inside the `Documents` folder:
- `ST10480375_POE_PART_1_ERD.docx` the Entity Relationship Diagram for the database
- `ST10480375_POE_PART_1_API_ENDPOINT_PLAN.docx` table of every API endpoint the system will need
- `RaceDayDB.sql` SQL script that creates the database and tables, with sample data

## The two roles

**Organiser**
- Can create, edit and delete events
- Can manage the categories for their events (e.g. 5km, 10km, 21km)
- Can capture participant results
- Can view all enrolments for their events

**Participant**
- Can create an account
- Can browse events
- Can enter an event by choosing a category
- Can view their own enrolments and results

## Database

There are 6 tables: Users, Events, Categories, Enrolments, Results and Payments. Users holds both Organisers and Participants (there's a Role column to tell them apart). Everything else links back to either Users or Events depending on what it is.

## How to run the SQL script

1. Open SQL Server Management Studio (SSMS)
2. Connect to your local SQL Server instance
3. Open `RaceDayDB.sql`
4. Click Execute
5. This creates the `RaceDayDB` database with all tables and some sample data

## CI/CD

<img width="998" height="402" alt="image" src="https://github.com/user-attachments/assets/c11b3c02-38a9-4709-8f9a-bc45ead9dc7f" />


## Video

Here's my video walking through the ERD, the endpoint plan, and running the SQL script:

*(insert YouTube link here)*
