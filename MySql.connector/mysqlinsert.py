
import mysql.connector
from mysql.connector import errorcode

cnx = mysql.connector.connect(user='root',password='',
                                database='Duarte')

cursor = cnx.cursor()

add_t1 = ("INSERT INTO t1 "
               "(a,b) "
               "VALUES (%s, %s)") 

data_t1 = (6,'Linha 6')

cursor.execute(add_t1,data_t1) 
cnx.commit()

cursor.close


cursor = cnx.cursor()

query = ("SELECT a,b FROM t1")

cursor.execute(query)

for (a,b) in cursor:
      print("{}, {}".format(
      a,b))

cursor.close()
cnx.close()
