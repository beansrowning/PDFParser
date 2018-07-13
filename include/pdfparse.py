import os
import sys
import argparse
from _csv import QUOTE_NONNUMERIC
from csv import DictWriter
from PyPDF2 import PdfFileReader

def main():
    # --- Parse argv ---------------------------------------------------
    arg_parser = argparse.ArgumentParser(description='PDF field parser')

    arg_parser.add_argument('filenames', metavar='file', nargs='+',
     help='Path to one or more PDF to parse')

    arg_parser.add_argument('-o',
        metavar='output_file', dest='output', default = "output.csv",
        help='Output filename (default: output.csv)')

    args = arg_parser.parse_args()

    # --- Read in data from all the files ------------------------------
    parsed_data = []

    for file in args.filenames:
        with open(file, "rb") as con:
            pdf = PdfFileReader(con)
            fields = pdf.getFields()

            for column, objects in fields.items():
                    fields[column] = str(objects["/V"]) if "/V" in objects else ""

            parsed_data.append(fields)


    # If our dictionary is empty, assume that we have no data and exit
    # TODO: This only checks the first file. This could be more robust.
    if parsed_data[0] is None:
        sys.exit(0)

    # --- Write out data to the CSV file ------------------------------
    with open(args.output, "w") as outfile:

        csvwriter = DictWriter(
        outfile,
        delimiter=",",
        quotechar="\"",
        lineterminator="\n",
        quoting=QUOTE_NONNUMERIC,
        fieldnames = parsed_data[0].keys()
        )

        csvwriter.writeheader()

        for row in parsed_data:
            csvwriter.writerow(row)

if __name__ == "__main__":
    main()
