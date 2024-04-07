 
import mysql.connector
from mysql.connector import errorcode

cnx = mysql.connector.connect(user='root',password='',
                                database='Duarte')


cursor = cnx.cursor()

query = ("SELECT a,b FROM t1")

cursor.execute(query) 
result = cursor.fetchall()
print (result)

for row in result:
	print ("A:",row[0]," B:",row[1])



cursor.close()
cnx.close()














