#!/usr/bin/Rscript

## Simple script to plot the histogram of some numbers
## Diego Garrido-Martín
## 18/11/2018

## Load libraries
library(optparse)

## Parse arguments
option_list = list(
  make_option(c("-i", "--input"), type = "character",
              help = "Input data", metavar = "character"),
  make_option(c("-o", "--output"), type="character",
              metavar = "character", help = "Output PDF file"),
  make_option(c("-v", "--verbose"), action = "store_true", default = FALSE,
	      help = "Prints the R version [default %default]")
)

opt_parser <- OptionParser(option_list=option_list)
opt <- parse_args(opt_parser)

if (is.null(opt$input) || is.null(opt$output)){
  print_help(opt_parser) 
  stop("Arguments 'input' and 'output' are required\n", call. = FALSE)
}

## Run

# Get R version (e.g. 3.3.4 -> 334)
r_vs <- paste(R.Version()$major, R.Version()$minor, sep = ".")
r_vs_n <- as.numeric(gsub("\\.", "", r_vs)) 

# Load input data
tb <- read.table(opt$input, header = F)

# Transform input data depending on R version
tb[, 1] <- tb[, 1] + r_vs_n*1e-3

# Print summary

cat (sprintf("\nSummary of data in '%s'\n", opt$input))
print(summary(tb[, 1]))
cat("\n")

if(opt$verbose){
  cat("Your R version is", r_vs, "\n\n")
}

# Plot histogram of input data in PDF
pdf(opt$output, paper = 'a4r')

  hist(tb[, 1], main = "", xlab = sprintf("Data in '%s'", opt$input))

off <- dev.off()
