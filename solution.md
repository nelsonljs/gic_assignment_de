## Requirements

1. Code up a solution that could potentially be deployed, and describe the gaps/dependencies you will need work on to achieve a production version.

2. Attempt test-driven development to ensure that your solution is robust.

3. Generate a price reconcilliation report that shows the difference between `the price on EOM date` from the reference data vs `the price` in the fund report. The report output should be in Excel. We would prefer the solutuion to be in python and leveraging data manipulation libraries like pandas/polars etc.
	a. show the break with instrument date ref price vs fund price.
	b. describe how can make it scalable for `N` number of fund reports in future

4. Based on your understanding of the data, attempt to create a SQL view/views which gives a report as to which was the best performing fund for equities every month and the cumulative profit / loss for that fund for equities.


