rm(list=ls())
library(wordcloud)
library(Rfacebook)
library(KoNLP)
facebook_crawling <- function(token, page, output) {
  facebookData <- getPage(page, token, n=100)
  write(facebookData$message, output)
}
page <- "ABCNews" 		       # ABC News 페이지 ID
token <- ""	# 페이스북 개발자 토큰
output <- "abcnews_fb_data.txt"	# 저장할 결과 파일 이름

facebook_crawling(token, page, output)
facebookPosts <- readLines(output)
facebookPosts <- facebookPosts[!is.na(facebookPosts)]
facebookWords <- sapply(facebookPosts,extractNoun,USE.NAMES=F)
interest<-gsub("[[:punct:][:digit:][:space:]]", "", unlist(facebookWords))
interest <- base::Filter(function(x){nchar(x)>3},interest)
word_count <- table(interest)
write.table(sort(word_count, decreasing = T), file = "abcnews_interest.txt")
palette <- brewer.pal(8, "Set2")
wordcloud(names(word_count),freq=word_count, scale=c(3,0.5),rot.per = 0.25,min.freq = 5, random.order = F, colors = palette)
