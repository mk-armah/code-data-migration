
from openpyxl.styles import Font
import openpyxl
from openpyxl import Workbook
from openpyxl.styles import Alignment
from openpyxl.styles import Font
from openpyxl import styles

import os
import pandas as pd
import numpy as np




def execute(dataframe:pd.DataFrame,sheetname)->list:
    
    try:
        assert 'CENTER NAME' not in df['CENTRE NAME'].unique()

    except AssertionError:
        print("center name still exists")

    os.chdir(base_dir+'\\sheets')
    print("current working directory : ",os.getcwd())
    os.mkdir(sheetname) #create directory
    os.chdir(sheetname) #change directory
    
    names = []
    centers = df['CENTRE NAME'].unique()
    for i in centers:
        frame = df[df['CENTRE NAME'] == i]
#         index_ = index_ = [i for i in range(1,len(df)+1)]
#         print(frame)
#         print(i)
#         print(index_)
#         frame.index = index_
        name = i.replace(" ","_").lower()
        name = f'{name}.xlsx'
        #pd.DataFrame([["","",""]], columns=['A','B','C'])
        frame.to_excel(name)
        names.append(name)
        
    return names


def format_names(wb,ws,excel_name,center_name:str,purpose):
    
    cells = []
    for i in range(1,4):
        cells.append(ws.cell(row = i,column = 5))
        
        
    ws.column_dimensions['A'].width = 17
    ws.column_dimensions['B'].width = 13.45
    ws.column_dimensions['C'].width = 15.3
    ws.column_dimensions['D'].width = 5.3
    ws.column_dimensions['E'].width = 20
    ws.column_dimensions['F'].width = 9.15
    ws.column_dimensions['G'].width = 27
    ws.column_dimensions['H'].width = 7.9
        
    cells[0].value = 'UNIVERSITY OF CAPE COAST'
    cells[1].value = purpose
    cells[2].value = center_name
    
    cells[0].alignment = Alignment(horizontal = 'center',vertical = 'center')
    cells[1].alignment = Alignment(horizontal = 'center',vertical = 'center')
    cells[2].alignment = Alignment(horizontal = 'center',vertical = 'center')
    
    fontStyle = Font(size = "18",bold = True)
    cells[0].font = fontStyle
    cells[1].font = fontStyle
    cells[2].font = fontStyle
    

    wb.save(excel_name)
    print('workbook saved')
    
    return True


def main(sheetname,purpose:str):
    try:
        excel_names = execute(sheetname)
    except Exception as err:
        print("First Execution Failed",err)
        
    for i in os.listdir():
        wb = openpyxl.load_workbook(i)
        ws = wb['Sheet1']
        ws.insert_rows(0,4)
        try:  
            remove_xls = i.replace(".xlsx","")
            remove_underscores = remove_xls.replace("_"," ")
            center_names = remove_underscores.upper()
            output = format_names(wb,ws = ws,excel_name = i,center_name = center_names,purpose = purpose)
            assert output == True
        except AssertionError:
            print('Second Execution Failed')
            print('SUCCESS')


# def save_data():
#     dims = {}
#     for row in ws.rows:
#         for cell in row:
#             if cell.value:
#                 dims[cell.column_letter] = max((dims.get(cell.column_letter, 0), len(str(cell.value))))    
#     for col, value in dims.items():
#         dims[cell.column_letter] = max((dims.get(cell.column_letter, 0), len(str(cell.value))))
        
#     wb.save('abetifi_college_of_education - Copy.xlsx')