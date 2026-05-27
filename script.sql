
----- DUPLICATES -----------------------------------------------------------------------------------------------------------------

-- IDENTIFY DUPLICATES - retrieves all rows from the players_data_v1 table that appear more than once in an identical form (matching in all columns)
-- Total rows: 39

SELECT 
    as_of, country, tracker_id, tracker_name, user_id, 
    signup_date, signup_year, first_deposit_date, first_deposit_year, 
    first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue, project_name, platform,
    COUNT(*) as occurrence_count
FROM players_data_v1
GROUP BY 
    as_of, country, tracker_id, tracker_name, user_id, 
    signup_date, signup_year, first_deposit_date, first_deposit_year, 
    first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue, project_name, platform
HAVING COUNT(*) > 1;

-- IDENTIFY DUPLICATES - retrieves all rows from the players_data_v2 table that appear more than once in an identical form (matching in all columns)
-- Total rows: 8 835

SELECT 
    as_of, country, tracker_id, tracker_name, user_id, 
    signup_date, signup_year, first_deposit_date, first_deposit_year, 
    first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue, project_name, platform,
    COUNT(*) as occurrence_count
FROM players_data_v2
GROUP BY 
    as_of, country, tracker_id, tracker_name, user_id, 
    signup_date, signup_year, first_deposit_date, first_deposit_year, 
    first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue, project_name, platform
HAVING COUNT(*) > 1;

----------------------------------------------------------------------------------------------------------------------------------
-- UNION (ALL) could be used to merge duplicates from each table
----------------------------------------------------------------------------------------------------------------------------------

----- MISSING VALUES -------------------------------------------------------------------------------------------------------------

-- EMPTY COLUMN - retrieves all rows from the players_data_v1 table that contain null or empty value
-- Total rows: 12 265

SELECT *
FROM players_data_v1
WHERE as_of IS NULL 
   OR country IS NULL OR country = ''
   OR tracker_id IS NULL OR tracker_id = ''
   OR tracker_name IS NULL OR tracker_name = ''
   OR user_id IS NULL 
   OR signup_date IS NULL 
   OR signup_year IS NULL 
   OR first_deposit_date IS NULL 
   OR first_deposit_year IS NULL 
   OR first_deposit_amount IS NULL 
   OR sports_bets_turnover IS NULL 
   OR sportsbook_net_revenue IS NULL 
   OR total_net_revenue IS NULL 
   OR deposits IS NULL 
   OR revenue IS NULL 
   OR project_name IS NULL OR project_name = ''
   OR platform IS NULL OR platform = '';

-- EMPTY COLUMN - retrieves all rows from the players_data_v2 table that contain null or empty value
-- Total rows: 12 742

SELECT *
FROM players_data_v2
WHERE as_of IS NULL 
   OR country IS NULL OR country = ''
   OR tracker_id IS NULL OR tracker_id = ''
   OR tracker_name IS NULL OR tracker_name = ''
   OR user_id IS NULL 
   OR signup_date IS NULL 
   OR signup_year IS NULL 
   OR first_deposit_date IS NULL 
   OR first_deposit_year IS NULL 
   OR first_deposit_amount IS NULL 
   OR sports_bets_turnover IS NULL 
   OR sportsbook_net_revenue IS NULL 
   OR total_net_revenue IS NULL 
   OR deposits IS NULL 
   OR revenue IS NULL 
   OR project_name IS NULL OR project_name = ''
   OR platform IS NULL OR platform = '';

----------------------------------------------------------------------------------------------------------------------------------
-- UNION (ALL) could be used to merge reults from each table
-- command could be simplified to identify missing values in one column at once
----------------------------------------------------------------------------------------------------------------------------------

----- NUMERIC COLUMN DISCREPANCIES -----------------------------------------------------------------------------------------------

-- IDENTIFY DISCREPANCIES - retrieves all rows from the players_data_v1 table that are missing or have different values in the players_data_v2 table based on user_id
-- Total rows: 197 254

SELECT 
    user_id, first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue
FROM players_data_v1

EXCEPT

SELECT 
    user_id, first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue
FROM players_data_v2;

-- IDENTIFY DISCREPANCIES - retrieves all rows from the players_data_v2 table that are missing or have different values in the players_data_v1 table based on user_id
-- Total rows: 196 012

SELECT 
    user_id, first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue
FROM players_data_v2

EXCEPT

SELECT 
    user_id, first_deposit_amount, sports_bets_turnover, sportsbook_net_revenue, 
    total_net_revenue, deposits, revenue
FROM players_data_v1;

----------------------------------------------------------------------------------------------------------------------------------
-- UNION (ALL) could be used to merge reults from each table (brackets needed for commands on both sides of union all)
-- Result interpretation : tables don't include identical data
----------------------------------------------------------------------------------------------------------------------------------

----- DATE INCONSISTENCIES -------------------------------------------------------------------------------------------------------


-- YEAR MATCH - retrieves all rows from the players_data_v2 table where the signup_year does not match year from signup_date
-- Total rows: 205 070 (table players_data_v2: 0)

SELECT 
    user_id, signup_date, signup_year, as_of
FROM public.players_data_v2
WHERE signup_year != EXTRACT(YEAR FROM signup_date)

-- SIGNUP FROM FUTURE - retrieves all rows from the players_data_v1 table where the signup_date is after the as_of (assuming export timestampt)
-- Total rows: 10 028 (table players_data_v2: 10 429)

SELECT 
    user_id, signup_date, signup_year, as_of
FROM public.players_data_v1
WHERE signup_date > as_of


----------------------------------------------------------------------------------------------------------------------------------
-- UNION (ALL) could be used to merge reults from each query and table
----------------------------------------------------------------------------------------------------------------------------------

----- TRACKER ID-TEXT RELATIONSHIP -----------------------------------------------------------------------------------------------

-- MORE TRACKER NAMES - retrieves all rows from the players_data_v1 table where there are more than one tracker_name for one tracker_id
-- Total rows: 2 x 2 = 4 (table players_data_v2: 28 x 2 = 56)

SELECT 
    tracker_id, 
    COUNT(DISTINCT tracker_name) AS different_names_count,
    STRING_AGG(DISTINCT tracker_name, ' | ') AS found_names
FROM public.players_data_v1
WHERE tracker_id IS NOT NULL
GROUP BY tracker_id
HAVING COUNT(DISTINCT tracker_name) > 1;

----------------------------------------------------------------------------------------------------------------------------------
-- UNION (ALL) could be used to merge reults from each table
----------------------------------------------------------------------------------------------------------------------------------

----- TABLE ROW COUNT ------------------------------------------------------------------------------------------------------------

-- players_data_v1: 197 516
-- players_data_v2: 205 070

-- The difference is given mainly by the fact that tables present different data, but also by the number of duplicates.