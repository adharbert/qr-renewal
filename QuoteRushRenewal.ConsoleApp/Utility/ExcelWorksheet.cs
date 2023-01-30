using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Reflection;

namespace QuoteRushRenewal.ConsoleApp.Utility
{
    public static class ExcelWorksheet
    {

        public static void CreateWorksheet<T>(List<T> data, ref XLWorkbook workbook, string worksheetName)
        {
            
            IXLWorksheet worksheet = workbook.Worksheets.Add(worksheetName);
            PropertyInfo[] fields = typeof(T).GetProperties();
            int currentRow = 1;
            int currentColumn = 1;
            foreach (var field in fields)
            {
                if (field.Name.ToLower() != "item")
                {
                    worksheet.Cell(currentRow, currentColumn++).Value = field.Name;
                }
            }
            try
            {
                foreach (var item in data)
                {
                    currentRow++;
                    currentColumn = 1;
                    foreach (var fieldVal in fields)
                    {
                        if (fieldVal.Name.ToLower() != "item")
                        {
                            worksheet.Cell(currentRow, currentColumn++).Value = typeof(T).GetProperty(fieldVal.Name).GetValue(item, null); //item[fieldVal.Name];
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
            }

            //return workbook;
        }

    }
}
