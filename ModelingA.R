#Here I create a corpus based on 10% of the data provided for analysis.

# File path
file.blogs <- "en_US/en_US.blogs.txt" # blog.txt file
file.twitter <- "en_US/en_US.twitter.txt" # twitter.txt file
file.news <- "en_US/en_US.news.txt" # news.txt file

# read files
connect <- file(file.blogs, open="rb")
blogs <- readLines(connect, encoding="UTF-8"); close(connect)
connect <- file(file.twitter, open="rb")
twitter <- readLines(connect, encoding="UTF-8"); close(connect)
connect <- file(file.news, open="rb")
news <- readLines(connect, encoding="UTF-8"); close(connect)
rm(connect)

set.seed(123) # Since I am going to use the shuffle feature, I am setting the seed for future reproducibility.
# Sampling
AsampleBlogs <- blogs[sample(1:length(blogs), 0.1*length(blogs), replace=FALSE)]
AsampleNews <- news[sample(1:length(news), 0.1*length(news), replace=FALSE)]
AsampleTwitter <- twitter[sample(1:length(twitter), 0.1*length(twitter), replace=FALSE)]
library(tm)
# Cleaning
AsampleBlogs <- iconv(AsampleBlogs, "UTF-8", "ASCII", sub="")
AsampleNews <- iconv(AsampleNews, "UTF-8", "ASCII", sub="")
AsampleTwitter <- iconv(AsampleTwitter, "UTF-8", "ASCII", sub="")
Adata.sample <- c(AsampleBlogs,AsampleNews,AsampleTwitter)
Amt.data <- removeNumbers(Adata.sample)
Amt.data <- removePunctuation(Amt.data)
Amt.data <- removeWords(Amt.data, stopwords("en"))
Amt.data <- stripWhitespace(Amt.data)
