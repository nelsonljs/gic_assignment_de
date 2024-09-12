import sqlite3

with open('master-reference-sql.sql', 'r') as sql_file:
    sql_script = sql_file.read()

db = sqlite3.connect('source.db')
cursor = db.cursor()
cursor.executescript(sql_script)
db.commit()
db.close()