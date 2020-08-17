#loading tm
library(tm)
#loading SnowballC
library(SnowballC)

#loading a text file from local computer
newdata<- readlines(filepath)

#Load data as corpus
#VectorSource() creates character vectors
mydata <- Corpus(VectorSource(newdata))

# convert to lower case
mydata <- tm_map(mydata, content_transformer(tolower))

#remove ������ what would be emojis
mydata<-tm_map(mydata, content_transformer(gsub), pattern="\\W",replace=" ")

# remove URLs
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
mydata <- tm_map(mydata, content_transformer(removeURL)

# remove anything other than English letters or space
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
mydata <- tm_map(mydata, content_transformer(removeNumPunct))

# remove stopwords
mydata <- tm_map(mydata, removeWords, stopwords("english"))

#u can create custom stop words using the code below.
#myStopwords <- c(setdiff(stopwords('english'), c("r", "big")),"use", "see", "used", "via", "amp")
mydata <- tm_map(mydata, removeWords, myStopwords)

# remove extra whitespace
mydata <- tm_map(mydata, stripWhitespace)

# Remove numbers
mydata <- tm_map(mydata, removeNumbers)

# Remove punctuations
mydata <- tm_map(mydata, removePunctuation)

mydata <- tm_map(mydata, stemDocument)

#create a term matrix and store it as dtm
dtm <- TermDocumentMatrix(mydata)