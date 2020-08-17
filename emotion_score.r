#load the library syuzhet
library(syuzhet)

#load the library tm
library(tm)

#load the library readr
library(readr)

#load the library stringi
library(stringi)

#load the library ggplot2
library(ggplot2)

#mydataCopy is a term document,generated from cleaning #comments.csv 
mydataCopy <- mydata

#carryout sentiment mining using the get_nrc_sentiment()function #log the findings under a variable result
result <- get_nrc_sentiment(as.character(mydataCopy))

#count the words in a comment
WordCount <- stringi::stri_count_words(transcripts$comment)

#Divide the emotion score with number of words for each comment
result0 <- (result/WordCount)

#change result from a list to a data frame and transpose it 
result1<-data.frame(t(result0))

#rowSums computes column sums across rows for each level of a #grouping variable.
new_result <- data.frame(rowSums(result1))

#name rows and columns of the dataframe
names(new_result)[1] <- "count"
new_result <- cbind("sentiment" = rownames(new_result), new_result)
rownames(new_result) <- NULL

#plot the first 8 rows,the distinct emotions
qplot(sentiment, data=new_result[1:8,], weight=count, geom="bar",fill=sentiment)+ggtitle("Emotion")

#plot the last 2 rows ,positive and negative
qplot(sentiment, data=new_result[9:10,], weight=count, geom="bar",fill=sentiment)+ggtitle("Sentiment")