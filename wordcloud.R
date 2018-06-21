rm(list=ls())
library(wordcloud)
library(Rfacebook)
library(KoNLP)
facebook_crawling <- function(token, page, output) {
  # ABC News 페이스북 데이터 수집
  facebookData <- getPage(page, token, n=100)
  # ABC News 뉴스피드 데이터를 파일에 저장
  write(facebookData$message, output)
}


# ABC News 페이지에서 데이터 수집# ABC Ne 
page <- "ABCNews" 		       # ABC News 페이지 ID
token <- ""	# 페이스북 개발자 토큰
output <- "abcnews_fb_data.txt"	# 저장할 결과 파일 이름

facebook_crawling(token, page, output)

# 텍스트마이닝을 이용한 데이터 정제 및 분석

## 1) 페이스북 데이터 읽어오기
facebookPosts <- readLines(output)
## 2) NA 데이터 제거
facebookPosts <- facebookPosts[!is.na(facebookPosts)]
## 3) 명사 추출
facebookWords <- sapply(facebookPosts,extractNoun,USE.NAMES=F)
## 4) 특수문자, 숫자, 공백, 불필요한 단어 제거
interest<-gsub("[[:punct:][:digit:][:space:]]", "", unlist(facebookWords))
interest <- base::Filter(function(x){nchar(x)>3},interest)
word_count <- table(interest)

# 분석 결과 저장 및 시각화
write.table(sort(word_count, decreasing = T), file = "abcnews_interest.txt")

# [조건] 최소 빈도수 15 이상인 단어를 워드클라우드로 시각화
palette <- brewer.pal(8, "Set2")
wordcloud(names(word_count),freq=word_count, scale=c(3,0.5),rot.per = 0.25,min.freq = 5, random.order = F, colors = palette)
