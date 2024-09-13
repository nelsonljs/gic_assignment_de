import sqlite3

# ## Load standard script
# with open('master-reference-sql.sql', 'r') as sql_file:
#     sql_script = sql_file.read()

# db = sqlite3.connect('source.db')
# cursor = db.cursor()
# cursor.executescript(sql_script)
# db.commit()
# db.close()

 ## Load standard script
with open('data-engineering/load_external_funds.sql', 'r') as sql_file:
    sql_script = sql_file.read()

db = sqlite3.connect('data/source.db')
cursor = db.cursor()
cursor.executescript(sql_script)
db.commit()
db.close()

## Load some funds for convenience.

import pandas as pd
import os
import dateutil.parser

db = sqlite3.connect('data/source.db')
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
        continue

    df.to_sql('external_funds', db, if_exists='append', index=False)

