import os
import argparse
import pandas as pd
from PyPDF2 import PdfFileReader

def parse_pdf_impl(filenames):
    # --- Read in data from all the files ------------------------------
    parsed_data = []

    for file in filenames:
        with open(file, "rb") as con:
            pdf = PdfFileReader(con)
            fields = pdf.getFields()

            for column, objects in fields.items():
                    fields[column] = str(objects["/V"]) if "/V" in objects else ""

            parsed_data.append(fields)

    # --- return as Pandas DataFrame ------------------------------
    parsed_data = pd.DataFrame(parsed_data)
    return parsed_data
