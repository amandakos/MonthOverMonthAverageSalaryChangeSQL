-- Trying to put some things together. Wish me luck! And that hard work pays off when doing hard things.

SELECT * 
FROM salaries;

WITH monthly_metrics AS
(
	SELECT EXTRACT(year from from_date) as year,
				EXTRACT(month from from_date) as month,
                AVG(salary) as salary
	FROM salaries
    GROUP BY 1, 2
)
SELECT year as current_year,
			month as current_month,
            salary as salary_current_month,
            LAG(year, 12) OVER (ORDER BY year, month) as previous_year,
            LAG(month, 12) OVER (ORDER BY year, month) as month_comparing_with,
            LAG(salary, 12) OVER (ORDER BY year, month) as revenue_12_mo_ago,
            salary - LAG(salary,12) OVER (ORDER BY year, month) as mo_to_mo_difference,
            ((salary - LAG(salary, 12) OVER (ORDER BY year, month))/ (LAG(salary, 12) OVER (ORDER BY year, month))) * 100 as percent_change
FROM monthly_metrics
ORDER BY 1,2;


