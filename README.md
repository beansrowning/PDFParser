# A Python-based PDF form data parser  
*Sean Browning (oet5)*    

## What do it do  
Given one or more PDFs that contain typed data in fillable fields, this script scrapes all fields and outputs the data into a CSV file for easier extraction. One could probably do this with Acrobat Pro or similar software, but then it probably wouldn't be free.  

## Okay, but how can I use it?  
- Load the R package interface for additional processing within R as a tibble  
  - Python DataFrame -> R tibble through reticulate  
- Extend the Python script for additional processing within Python  
- Use the Executable file for simple CSV file output (located in `include/pdfparse.exe`)  

## How to use the Executable  
_Note: Currently all PDFs being processed in a batch job must be the same form_  
- Select the PDF files you wish to extract data from    
- Drag and drop the files ontop of `pdfparse`  
- The output will return in the same directory as `output.csv`  
- Optionally call from the command line to supply the CSV file name  

## Installing the R package  
*requires Python 3.x, PyPDF2, Pandas, and the dev version of reticulate*  
*Will only install with the Python architecture you have set up (x64 or i386)*  
- `pip install PyPDF2 pandas`  
- From R: `devtools::install_github("rstudio/reticulate")`  
- Clone this repo  
- From the containing folder: `R CMD build pdfparse`  
- `R CMD INSTALL $tar_file$ --no-multiarch`  

## Compiling the executable  
*Requires Python 3.x, PyPDF2, and pyinstaller*  
- `pip install PyPDF2 pyinstaller`  
- `pyinstaller include\pdfparse.py --onefile --distpath include`  
- TODO: Create a makefile  
