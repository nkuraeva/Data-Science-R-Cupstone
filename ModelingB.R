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
BsampleBlogs <- blogs[sample(1:length(blogs), 0.3*length(blogs), replace=FALSE)]
BsampleNews <- news[sample(1:length(news), 0.3*length(news), replace=FALSE)]
BsampleTwitter <- twitter[sample(1:length(twitter), 0.3*length(twitter), replace=FALSE)]
library(tm)
# Cleaning
BsampleBlogs <- iconv(BsampleBlogs, "UTF-8", "ASCII", sub="")
BsampleNews <- iconv(BsampleNews, "UTF-8", "ASCII", sub="")
BsampleTwitter <- iconv(BsampleTwitter, "UTF-8", "ASCII", sub="")
Bdata.sample <- c(BsampleBlogs,BsampleNews,BsampleTwitter)
Bmt.data <- removeNumbers(Bdata.sample)
Bmt.data <- removePunctuation(Bmt.data)
Bmt.data <- removeWords(Bmt.data, stopwords("en"))
Bmt.data <- stripWhitespace(Bmt.data)
