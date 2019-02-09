require('XLConnect')  # install if necessary
# also install XLConnectJars if not installed as dependency

# read dataframes from Excel spreadsheet
# you'll have to change the sheets and regions
dfCities <- readWorksheetFromFile('transpsheet.xlsx',sheet=1,region='F1:F11')
dfProducts <- readWorksheetFromFile('transpsheet.xlsx',sheet=1,region='H1:H4')
dfTableRoutes <- readWorksheetFromFile('transpsheet.xlsx',sheet=1,region='A2:D65')
dfSupply <- readWorksheetFromFile('transpsheet.xlsx',sheet=1,region='J2:L11')
dfDemand <- readWorksheetFromFile('transpsheet.xlsx',sheet=1,region='J14:L35')

# set to your directory or use Session -> Set Working directory from the menu in RStudio to set directory
# setwd('~/Dropbox/testwrite') # set to your project directory
filename <- 'transp4new.dat' # give your file a name
cat('//--------------------------------------------------\n',file=filename)
con <- file(filename) # get connection to file to close later
cat('// transportation file produced by reading \n',file=filename,append=T)
cat('// excel file into R using XLConnect \n',file=filename,append=T)
cat('// and using R commands to output textfile \n',file=filename,append=T)
cat('//--------------------------------------------------\n\n',file=filename,append=T)

# some helper functions for writing in the right formats for .dat file
writeSet <- function( varName, df, filename ){
  cat( varName, file = filename, append = T )
  cat( ' = { ', file = filename, append = T )
  numRows <- dim(df)[1]
  for (j in 1:numRows){
    cat( df[j,1], file = filename, append = T )
    cat( ' ', file = filename, append = T )
  }
  cat('};\n', file = filename, append = T )
}

writeNumber <- function( varName, x, filename ){
  cat( varName, file = filename, append = T)
  cat( ' = ', file = filename, append = T)
  cat( x, file = filename, append = T)
  cat( ';\n', file = filename, append = T)
}

writeTuplesTable <- function( varName, df, filename){
  cat( varName, file = filename, append = T)
  cat( ' = {\n', file = filename, append = T)
  numRows <- dim( df )[1]
  for (j in 1:numRows){
    cat(' < ', file = filename, append = T)
    write.table( df[j,], file = filename, append = T, quote = F, sep = ', ', 
                 row.names = F, col.names = F, eol = ' >\n' )
  }
  cat('};\n\n', file = filename, append = T)
}

writeTuplesArray <- function( varName, df, filename){
  cat( varName, file = filename, append = T)
  cat( ' = #[\n', file = filename, append = T)
  numRows <- dim( df )[1]
  numCols <- dim( df )[2]
  tupleLen <- numCols - 1
  for (j in 1:numRows){
    cat(' < ', file = filename, append = T)
    write.table( df[j,1:tupleLen], file = filename, append = T, quote = F, sep = ', ', 
                 row.names = F, col.names = F, eol = ' >: ' )
    cat( df[j,numCols] , file = filename, append = T )
    cat( '\n', file = filename, append = T )
  }
  cat(']#;\n\n', file = filename, append = T)
}

# write file

writeSet('Cities',dfCities,filename)
writeSet('Products',dfProducts,filename)
writeNumber('Capacity',625,filename)
writeTuplesTable('TableRoutes',dfTableRoutes,filename)
writeTuplesArray('Supply',dfSupply,filename)
writeTuplesArray('Demand',dfDemand,filename)
close(con) # close connection to file

