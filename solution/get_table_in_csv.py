 ## Load some funds for convenience.

import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://{user}:{pass}@localhost:5432/analytics')

sql = '''
select * from dbt_nelson_marts.mart_best_performing_fund;
'''
pd.read_sql_query(sql, con=engine).to_csv('best_performing_fund.csv', index=False)

sql = '''
select * from dbt_nelson_marts.mart_price_reconciliation;
'''
pd.read_sql_query(sql, con=engine).to_csv('price_reconciliation_report.csv', index=False)
