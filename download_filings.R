## Reginald Edwards
## 26 April 2018
##
## Download EDGAR filings

## Load package data
##  - urls
DATA_DIR <- ""
URLS_DB_DIR <- paste(DATA_DIR, "urls-db.txt", sep = "/")

get_cik <- function(ticker){
  cik <- ""
  return(cik)
}

get_filing_url <- function(cik, year){
  ## year: filing year
  cik <- as.numeric(cik)
  urls.db <- read.delim("urls-db.txt", stringsAsFactors = FALSE)
  urls.db$filing.year <- substr(urls.db$filingdate,1,4)
  filing.url <- urls.db[which(urls.db$cik == cik & urls.db$filing.year == year), "url"]
  return(filing.url)
}

download_filing_cik <- function(cik, year){
  cik <- as.numeric(cik)
  filing.url <- get_filing_url(cik, year)
  filename <- paste(cik, year, sep = "-")
  filename <- paste(filename, "html", sep = ".")
  filing <- download.file(filing.url, destfile = filename, quiet = TRUE)
  if(filing == 0) return(filename)
}


download_filing_ticker <- function(ticker, year){
  cik <- get_cik(ticker)
  filing.url <- get_filing_url(cik, year)
}

download_filing <- function(firm.id, firm.id.type, year){
  filename <- ""
  if(firm.id.type == 'ticker'){
    filename <- download_filing_ticker(firm.id, year)
  }else
  if(firm.id.type == 'cik'){
    filename <- download_filing_cik(firm.id, year)
  }
  if(length(filename)>0) filing <- readChar(filename, file.info(filename)$size)
  return(filing)
}

download_filings <- function(firm.ids, years){
  
}

fb_cik <-  "0001326801"
#fb_url <- get_filing_url(fb_cik, 2014)
#fb_filename <- download_filing_cik(fb_cik, 2014)
#fb_filing_2014 <- download_filing(fb_cik, "cik", 2014)

## TODO: define and return a custom filing object