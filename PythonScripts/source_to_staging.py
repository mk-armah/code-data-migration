"""ETL Script for standby schema
Extracts sheets from excel (Extracts)
Remove all anamalies and inconsistencies (Transform)
Loads data to staging area database (Load)

Author: Ing Michael Kofi Armah
Date Create : 22nd November 2022, 06:28
"""


import os
import pandas as pd
import numpy as np
import pyodbc
import json
from odbc_connect import OdbcConnection
from tqdm import tqdm
from process_logger import LogEtlTask

log = LogEtlTask()

@log
def Extract(sheet_name,file_dir = "..",file_name = 'IC_WITH_PHONE_NUMBERS_EDITED_II (1).xlsx'):

    file_dir = os.path.join(file_dir,file_name)

    
    retries = 12
    for i in range(3,retries):
        try:
            
            df = pd.read_excel(file_dir,sheet_name = sheet_name,skiprows = i)
            columns = ["CENTRE NAME","REGISTRATION NUMBER","NAME","LEVEL","LONG NAME","CODE","TITLE","SESSION"]
            assert [x for x in df.columns] == columns
            return df
            
        except AssertionError:
            return None

@log
def Transform(df:pd.DataFrame)->pd.DataFrame:
    
    """ clean and transform data """
    
    df = df.dropna() #drops all empty spaces in from the dataframe
    new_columns = [x.replace(" ","_") for x in df.columns] #replace spaces in column names with underscores ("_")
    df.columns = new_columns

    df.set_index("CENTRE_NAME",inplace = True)
    try:
        df.drop('CENTRE NAME',axis = 0,inplace = True)
    except KeyError as keyerror:
        print('CENTRE NAME is not present in dataframe |', keyerror)
        raise keyerror

    index_ = [i for i in range(1,len(df)+1)]
    index_ = list(range(1,len(df)+1))
    df = df.reset_index()
    df.index = index_
    
    try:
        assert 'CENTRE NAME' not in df['CENTRE_NAME'].unique() #check whether CENTRE NAME is present in the rows

    except AssertionError:
        print("center name still exists")

    return df


@log
def Load(df,table_name)->bool:
    #to folder destination
    
    #load to sql database
    odbc = OdbcConnection(server_name= 'MKA-MSI\MKASERVER',database= 'CoDE_Staging') 
    sql_string = f"INSERT INTO standby.{table_name} (StudyCentre, RegistrationNumber,FullName,[Level],DegreeTitle,CourseCode,CourseTitle,[Session]) values(?,?,?,?,?,?,?,?)"
    
    for index, row in df.iterrows():
        data = (row.CENTRE_NAME, row.REGISTRATION_NUMBER,
        row.NAME,row.LEVEL,row.LONG_NAME,row.CODE,
        row.TITLE,row.SESSION)

        response = odbc.insert_into_sql(sql_string = sql_string, data = data)
        if response['status'] == 0:
            print(f"Loading {table_name} to Staging | index: {index}")
            if index == len(df):
                odbc.cursor.commit()
                return True
            continue

        else:
            print(f"Failed to load {table_name} to Staging Database | index : {index}")
            print(response['message'])
            return False
        

def ETL():

    
    with open('../rawfile_meta_data.json','r') as file:
        meta_data = json.load(file)
    

    for sheet_name in tqdm(dict(meta_data).keys()):
        df = Extract(
                        sheet_name = sheet_name,
                        file_dir = "..",
                        file_name = 'IC_WITH_PHONE_NUMBERS_EDITED_II (1).xlsx'
                        )

        df = Transform(df = df)
        response = Load(df = df,table_name = sheet_name)

        

if __name__== '__main__':
    ETL()