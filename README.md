# Banking Database Project

## Overview
This project involves the design and implementation of a database system for a banking application. It encompasses the creation of an Entity-Relationship (ER/EER) schema, mapping it to a relational database schema, and implementing it using Oracle/MySQL. Furthermore, the project includes data loading, query generation, transaction implementation, and trigger creation.

## Documentation

### Part 1: Entity-Relationship (ER/EER) Schema Design
- Identification of requirements, missing or incomplete, and assumptions made.
- Design choices explained, including the EER-to-relational mapping strategy.

### Part 2: Relational Database Schema Implementation
- SQL `CREATE TABLE` statements for defining the database schema.
- Constraints and relationships specified based on the ER/EER schema design.

### Part 3: Data Loading, Queries, Transactions, and Triggers
- Python scripts and SQL queries to load initial data into the database.
- Implementation of update transactions and retrieval queries.
- Creation of triggers to automate certain database operations.

## Documentation Details

- **Missing or Incomplete Requirements:**
  - Specifies areas where the project requirements lack detail or clarity.
  - Highlights the importance of addressing security, data validation, and account types.

- **Assumptions:**
  - Assumptions made during the project regarding interest rates, loan payments, employee relationships, and dependent information.
  - Helps users understand the project's limitations and design decisions.

- **EER-to-Relational Mapping:**
  - Describes the process of mapping the ER/EER schema to a relational database schema.
  - Explains the rationale behind design choices, such as introducing new relational tables for many-to-many relationships.

## Usage

1. **Clone the Repository:**
    git clone <repository_url>
    cd <repository_directory>

2. **Database Setup:**
- Execute the SQL `CREATE TABLE` statements provided in `create_table.sql` to set up the database schema.

3. **Data Loading:**
- Run the Python script `data_loading.py` to load initial data into the database tables.
- Ensure the script has necessary permissions and database connection details are correctly configured.

4. **Queries and Transactions:**
- Utilize the provided SQL queries in `generate_report.sql` to generate reports and retrieve information from the database.
- Execute transactions using the Python script `transactions.py`, providing input through a user-friendly interface.

5. **Triggers:**
- Execute the SQL statements in `triggers.sql` to create triggers for automated database operations.

## Additional Notes

- Dummy data files provided in the `data/` directory can be used for testing and demonstration purposes.
- Review the project documentation thoroughly to understand design choices, assumptions, and limitations.

## Contributors

- [Your Name](https://github.com/mohd-ishraq)


