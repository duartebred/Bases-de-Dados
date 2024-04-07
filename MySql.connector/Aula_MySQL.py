-:q
:q!
#!/usr/bin/python
# -*- coding: UTF-8 -*-
'''
Created on 05/12/2013

@author: Ru13en
'''

import mysql.connector

from mysql.connector import errorcode


def create_database( cursor, DB_NAME ):
    #Cria a base de dados, o cursor é o objecto que advem do Cursor() e o DB_NAME é a string com o nome da database
    try:
        cursor.execute( "CREATE DATABASE {} DEFAULT CHARACTER SET 'utf8'".format( DB_NAME ) )
        
    except mysql.connector.Error as err:
        print("Failed creating database: {}".format( err ) )
        exit( 1 )

def setup_db( DB_NAME = 'employees', user_ = "root", password_ = "root"):
    #vai ser utilizado um dicionario  para tornar esta função mais generica.
    #para criar outras tabelas basta adicionar ao dicionario
    TABLES = { }
    
    TABLES[ 'employees' ] = (
        "CREATE TABLE 'employees' ( "
        "  'emp_no' int( 11 ) NOT NULL AUTO_INCREMENT, "
        "  `first_name` varchar( 14 ) NOT NULL, "
        "  `last_name` varchar( 16 ) NOT NULL, "
        "  `salary` int(11) NOT NULL, "
        "  PRIMARY KEY ( `emp_no` ) "
        ") ENGINE = InnoDB " )
    
    cnx = mysql.connector.connect( user = user_, password = password_ )
    cursor = cnx.cursor( )
    
    try:
        cnx.database = DB_NAME    
    
    except mysql.connector.Error as err:
        if err.errno == errorcode.ER_BAD_DB_ERROR:
            create_database( cursor, DB_NAME )
            cnx.database = DB_NAME
            
        else:
            print( err )
            
        exit( 1 )
        
    for name, ddl in TABLES.items( ):
        try:
            print( "Creating table {}: ".format( name ), end='' )
            cursor.execute( ddl )
        
        except mysql.connector.Error as err:
            if err.errno == errorcode.ER_TABLE_EXISTS_ERROR:
                print( "already exists." )
            
            else:
                print( err.msg )
        
        else:
            print( "OK" )
            
    cursor.close( )
    cnx.close( )

def test_db( user = 'root', password = 'root', host = '127.0.0.1', database = 'employees', rs = True ):
    #verifica se a base de dados está funcional/criada
    try:
        config = {
          'user': user,
          'password': password,
          'host': host,
          'database': database,
          'raise_on_warnings': rs,
        }
    
        cnx = mysql.connector.connect(**config)
        print( "Connection OK." )
    
    except mysql.connector.Error as err:
        
        if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
            print("Something is wrong with your user name or password")
        
        elif err.errno == errorcode.ER_BAD_DB_ERROR:
            print("Database does not exists")
        
        else:
            print( err )
    
    else:
        
        cnx.close( )

def add_employee( first_name, last_name, salary, user_ = 'root', password_ = 'root', database_ = 'employees' ):
    #adiciona SEMPRE uma nova linha à tabela criada, os argumentos são os nomes e valores de salarios (ver o main() ).
    #ATENCAO: Caso tenham várias tabelas, têm que adicionar varios querys com datas e fazer o seu execute nesta função
    cnx = mysql.connector.connect( user = user_ , password = password_ , database = database_ )
    cursor = cnx.cursor( )
    query = ( 
                "INSERT INTO employees "
                " ( first_name, last_name, salary ) "
                " VALUES ( %s, %s, %s ) " )
    data = ( first_name, last_name, salary )
    
    cursor.execute( query, data )
    cnx.commit( )
    cursor.close( )
    cnx.close( )

def read_data( user_ = 'root', password_ = 'root', database_ = 'employees' ):
    #Faz a leitura da tabela e imprime na consola o resultado
    cnx = mysql.connector.connect( user = user_ , password = password_ , database = database_ )
    cursor = cnx.cursor( )
    query = ( "SELECT first_name, last_name, salary FROM employees " )
    cursor.execute( query )
        
    
    for ( first_name, last_name, salary ) in cursor:
        print( "{} {} has a salary of {}€".format( first_name, last_name, salary ) )
    cursor.close( )
    cnx.close( )

def read2_data( user_ = 'root', password_ = 'root', database_ = 'employees' ):
    #Faz a leitura da tabela e imprime na consola o resultado
    cnx = mysql.connector.connect( user = user_ , password = password_ , database = database_ )
    cursor = cnx.cursor( )
    query = ( "SELECT first_name, last_name, salary FROM employees " )
    cursor.execute( query )
    resultados = cursor.fetchall()
    print (resultados)
    print ("Foram selecionados "+str(len(resultados)) + " Registos")

    for linha in resultados:
        print (linha)
    
    cursor.close( )
    cnx.close( )
     
def main( ):
    test_db( )
    setup_db( )
    #add_employee( 'Maria', 'Silva', 2000 )
    #add_employee( 'António', 'Costa', 1800 )
    #add_employee( 'Ana', 'Antunes', 1950 )
    read_data( )
    
main()