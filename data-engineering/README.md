# Introduction

This is a data engineering coding interview question.

The expectation is for the candidate to code up a Python solution to the case study. You are free to choose the libraries that you are familiar with to solve the problem.


## Dataset provided.

You should receive the following files:
- `external-funds` that contains the funds data of instruments that you hold a position to.
- `master-reference-sql.sql` that contains the master reference data of the universe of instruments.


## Case Study

Assume your investment firm has started an investment strategy that invests its capital with 10 funds.

Every month each of the 10 fund sends over their end of month positions. This will include the instrument price and profit & loss information. The sample funds breakdown data `external-funds` is shared which contains the simulated data for:

- master reference data for bond and equity instruments including reference prices in open db format. You may wish to use any preferred db technology to import this reference data. A suggestion would be in postgres.
- 10 Funds with 13 months of position change, price & market value data in csv format
- the names of the 10 funds are:

	- Whitestone
	- Wallington
	- Catalysm
	- Belaware
	- Gohen
	- Applebead
	- Magnum
	- Trustmind
	- Leeder
	- Virtous

## TODO

Please setup a sample database with your preferred database (eg. Postgres) which has the reference data setup and the csv data imported. Do ensure you are able to perform sample CRUD operation on these datasets. Feel free to go through the dataset to get familiarized.


## Useful Glossary/Tips

1. Position is the amount of a security, asset, or property that is owned (or sold short).

2. Market value is the term used to describe how much an asset or a company is worth on the financial market, according to market participants.

3. A fund is a pool of money set aside for a specific purpose.The pool of money in a fund is often invested and professionally managed in order to generate returns for its investors.

4. An instrument is an implement which is used to store or transfer value or financial obligations. A financial instrument is a tradable or negotiable asset, security, or contract.

5. Buying equity securities, or stocks, means you are buying a very small ownership stake in a company. While bonds/ Debt-based instruments are essentially loans made by an investor to the owner of the asset

6. Reference DB tables :
	a. Bond/Equity Prices - Table with price information for different instruments as of each applicable date
	b. Bond/Equity Refernce - Table with all static information related to bond/equity Instruments


## Requirements

1. Code up a solution that could potentially be deployed, and describe the gaps/dependencies you will need work on to achieve a production version.

2. Attempt test-driven development to ensure that your solution is robust.

3. Generate a price reconcilliation report that shows the difference between `the price on EOM date` from the reference data vs `the price` in the fund report. The report output should be in Excel. We would prefer the solutuion to be in python and leveraging data manipulation libraries like pandas/polars etc.
	a. show the break with instrument date ref price vs fund price.
	b. describe how can make it scalable for `N` number of fund reports in future

4. Based on your understanding of the data, attempt to create a SQL view/views which gives a report as to which was the best performing fund for equities every month and the cumulative profit / loss for that fund for equities.
