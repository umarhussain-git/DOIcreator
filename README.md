# DOIcreator

DOIcreator is an R package that helps you automatically add DOIs to references in a Word (.docx) file.

## Installation

```r
# Install from CRAN (if published)
install.packages("DOIcreator")

# Or install from GitHub
# remotes::install_github("username/DOIcreator")
```

## Load the Package

```r
library(DOIcreator)
```

## How to Use

1. **Prepare Your References File**

   * Create a separate Word document containing **only your references**.
   * Save it on your computer, e.g.:
     `"C:/folder/subfolder/file.docx"`

2. **Choose Output File Name**

   * Pick a new file name to avoid overwriting, e.g.:
     `"C:/folder/subfolder/file_doi.docx"`

3. **Run the Function**

   * Refer to the package help for the specific function:

     ```r
     ?DOIcreator
     ```
   * The function will add DOIs to your references and save a new Word file.

4. **Finalize References**

   * Open the output Word file (`file_doi.docx`).
   * Add numbering in Word: press `Ctrl + A` and click the numbering icon.
   * Copy the updated references into your manuscript.
   * **Important:** Always cross-check DOIs for accuracy.

## Notes

* The output file **does not include numbering** by default.
* This tool is designed to save time, but manual verification is recommended.

## Example

```r
# Example usage
library(DOIcreator)

# Replace with your own file paths
input_file <- "C:/folder/subfolder/file.docx"
output_file <- "C:/folder/subfolder/file_doi.docx"

# Run DOIcreator function
DOIcreator(input_file, output_file)
```

---

This README provides step-by-step guidance for users to generate DOI-enriched references for manuscripts efficiently.

# Maintainer 

Umar Hussain
Assistant professor, Orthodontics, 
Saidu college of Dentistry
drumarhussain@gmail.com
