import psycopg2
# conn = psycopg2.connect("host=localhost dbname=postgres user=postgres password")

## Load standard script
# with open('data-engineering/master-reference-sql.sql', 'r') as sql_file:
#     sql_script = sql_file.read()

# db = psycopg2.connect("host=localhost dbname=analytics user=postgres password=")

# cursor = db.cursor()
# cursor.execute('''
# CREATE SCHEMA IF NOT EXISTS raw;
# SET schema 'raw';
# ''')
# cursor.execute(sql_script)
# db.commit()
# db.close()

# #  ## Load standard script
with open('data-engineering/load_external_funds.sql', 'r') as sql_file:
    sql_script = sql_file.read()
db = psycopg2.connect("host=localhost dbname=analytics user=postgres password=")

cursor = db.cursor()
cursor.execute('''
CREATE SCHEMA IF NOT EXISTS raw;
SET schema 'raw';
''')
cursor.execute(sql_script)
db.commit()
db.close()

 ## Load some funds for convenience.

import pandas as pd
import os
import dateutil.parser
from sqlalchemy import create_engine

# db = psycopg2.connect("host=localhost dbname=analytics user=postgres password=")
engine = create_engine('postgresql://:@localhost:5432/analytics')
# cur = db.cursor()

folder_name = 'data-engineering/external-funds'
for filename in os.listdir(folder_name):
    full_path = f'{folder_name}/{filename}'
    df = pd.read_csv(full_path)

    ## Some cleaning for filename due to sqlite limitations.
    fund_name, report_date, *stuff = filename.split('.')
    report_date = report_date.replace('_', '-').split(' ')[0]
    df['FUND_NAME'] = fund_name
    df['REPORT_DATE'] = dateutil.parser.parse(report_date).strftime('%Y-%m-%d')

    ## Skip handling for column names for sqlite.
    if 'SEDOL' in df.columns:
        df['ISIN'] = df['SEDOL']
        del df['SEDOL']

    df.to_sql('external_funds', engine, if_exists='append', schema='raw', index=False)

