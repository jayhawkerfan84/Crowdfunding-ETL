drop table if exists remaining_goal;

-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
select sum(backers_count) as backer_count,c.cf_id from campaign c 
where c.outcome = 'live'
group by c.cf_id
order by backer_count desc;


-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
select count(backers_id) as backer_count,cf_id from backers
group by cf_id
order by backer_count desc



-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
select co.first_name, co.last_name,co.email,c.cf_id,sum(c.goal - c.pledged) as remaining_goal 
into remaining_goal
from campaign c join contacts co on co.contact_id = c.contact_id
where c.outcome = 'live'
group by co.first_name, co.last_name,co.email,c.cf_id



-- Check the table
select * from remaining_goal

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

select b.email,b.first_name,b.last_name,c.cf_id,c.company_name,c.description,c.end_date,rg.remaining_goal as "Left of Goal" 
into email_backers_remaining_goal_amount
from backers b join campaign c on c.cf_id = b.cf_id
join remaining_goal rg on rg.cf_id = c.cf_id
order by b.last_name asc



-- Check the table
select * from email_backers_remaining_goal_amount
