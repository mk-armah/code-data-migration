"""
Purpose : Creates an ODBC Connection to SQL Database

Author : Ing Michael Kofi Armah
Date Created :01 December,2022, 10:25 
"""

import pyodbc


class OdbcConnection:

	def __init__(self,server_name,database,logger_file_name='',**kwargs):

		self.conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server_name+';DATABASE='+database+'')
		self.database = database
		self.logger_file_name=logger_file_name
		self.cursor = self.conn.cursor()



	def select_data(self,sql_string):
	
		table_data = self.cursor.execute(sql_string)
		table_data =  self.cursor.fetchall()
		return table_data


	def insert_into_sql(self,sql_string,data):
		"""insert many rows into sql database
			Args:
				sql_string: Insert statement
				data:tuple values to insert
			Return: dict | keys(status,curser)
				status: status code after execution | 0 ==> success, 1 ==> failed execution
			
			NB: Commit changes after execution
		"""

		try:
			self.cursor.execute(sql_string,data)
			response = {'status': 0,"message":"Loading successful, remember to commit changes"}
			return response
		
		except pyodbc.Error as ex:
			response = {'status': 1,"message":ex}
			return response

	
	def run_sql_data(self,sql_string):
		try:
			cursor = self.cursor()
			cursor.execute(sql_string)
			cursor.commit()
		except pyodbc.Error as ex:
			return -1
        
