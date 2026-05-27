# Livesport Data Engineer - Internship Task

## 📝 Project Description
This repository contains a solution for the technical assignment as part of the hiring process for the Summer Internship 2026 at Livesport. 

The goal of this task is to analyze and perform data quality profiling on two datasets provided by an affiliate partner (`players_data_v1.csv` and `players_data_v2.csv`). The included SQL queries identify discrepancies between the two tables, search for missing values, isolate duplicate records, and cross-validate column relationships to ensure data integrity.

## 🛠️ Project Structure

```text
├── Data_Engineer_task.pdf  # The original assignment instructions
├── docker-compose.yml      # Orchestration for the local PostgreSQL database instance
├── README.md               # Project documentation
└── script.sql              # Commented SQL script
```

## 🚀 Database Setup via Docker Compose
You can quickly spin up a local PostgreSQL instance to run the script.
1. **Prerequisites:**

Make sure you have Docker and Docker Compose installed. Docker Desktop includes both.

2. **Run the Container:**

Run the following command in your terminal to start the database in the background:

```bash
docker compose up -d
```

## 🤖 Use of AI

**Why AI was used:** I used AI purely as a productivity booster to automate repetitive tasks and save time writing boilerplate code. Specifically, I used it to generate the initial CREATE TABLE schema based on a screenshot of the data columns with explicit data type definitions. Later, I passed an existing query for a single column and had the AI replicate and expand the logic across all remaining 16 columns, while specifing the logic behind it.


**Prompt provided:** "Can you extend this query so it covers all the columns according to the types?" or "Generate a SQL query to find a row with these columns..."


**Validation/Adjustment:** Since the requirements were straightforward and highly specified from the start, the generated outputs were accurate. I carefully reviewed the resulting queries.

