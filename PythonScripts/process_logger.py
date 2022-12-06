"""
Purpose : Logs ETL Processes, thus Errors and Success States 

Author : Ing Michael Kofi Armah
Date Created :05 December,2022 
"""

import logging
import time
import pandas as pd


class LogEtlTask:

    def __init__(self,filename:str = 'etl.log'):

        self.filename = filename
        logging.basicConfig(filename= self.filename,
                            level = logging.INFO,
                            format = '%(asctime)s | %(levelname)s | %(message)s',
                            datefmt='%m/%d/%Y %I:%M:%S %p')
       

    def __call__(self,func):

        def logEtl(**kwargs):
            start_time = time.time()
            if func.__name__ == 'Extract':
                
                try:

                    df = func(kwargs['sheet_name'], kwargs["file_dir"], kwargs['file_name'])
                    assert isinstance(df,pd.DataFrame)

                except AssertionError:
                    logging.error(f"Failed to Extract {kwargs['sheet_name']} from Source")
                
                else:
                    exec_time = time.time() - start_time
                    logging.info(f"{kwargs['sheet_name']} Extraction Successful | Execution Time: {exec_time}")
                    return df

            if func.__name__ == 'Transform':
                
                try:
                    df = func(kwargs['df'])
                    assert isinstance(df,pd.DataFrame)
                
                except AssertionError:
                    logging.error('Failed to Transform Data')
        
                else:
                    exec_time = time.time() - start_time
                    logging.info(f"Transformation Successful | Execution Time: {exec_time}")
                    return df

            if func.__name__ == 'Load':

                try:
                    response = func(kwargs['df'],kwargs['table_name'])
                    assert response == True
                except AssertionError:
                    logging.error(f"Failed to Load {kwargs['table_name']} to Staging Area")

                else:
                    exec_time = time.time() - start_time
                    logging.info(f"Successfully Loaded {kwargs['table_name']} to Staging Area | Execution Time: {exec_time}")
        
        return logEtl