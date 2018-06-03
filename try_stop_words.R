rm(list=ls())
library(KoNLP) 
library(wordcloud)
library(Rfacebook)

#contrib01. pacman이라는 패키지를 추가합니다. install.packages() + library()
if (!require("pacman")) {install.packages("pacman")}
pacman::p_load_gh(
  "trinker/qdap")

facebook_crawling <- function(token, page, output) {
  # ABC News 페이스북 데이터 수집
  facebookData <- getPage(page, token, n=100)
  # ABC News 뉴스피드 데이터를 파일에 저장
  write(facebookData$message, output)
}

# ABC News 페이지에서 데이터 수집
page <- "ABCNews" 		       # ABC News 페이지 ID
token <- "EAACEdEose0cBAOZB5tdmke2gtWUVPRE0eZCg8l1taGrrGRnIxvjX5JgupZBMjmzNE5EhVRMZBdAnDRcSPWWyIJZAdG7WmvDiLIwZClc3N2MXxSJ4G3DQu5D8ytWpUBYoctOCiVwvmCHIRQAtCShAdqJ0z5MybChwH5BO3YpSTVaxQUfvVB3uG8mF8v3ce5ohUZD"	# 페이스북 개발자 토큰
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


#contrib03-1 stopwords가 제외된 단어만을 추출합니다.
sub_interest<-rm_stopwords(interest, stopwords = tm::stopwords("english"))
sub_interest<-unlist(sub_interest)

#contrib03-2 stopwords들의 목록은 이하를 통해 볼 수 있습니다.
library(tm)
head(stopwords(kind = 'en'),10)
print(length(stopwords(kind='en')))#174개

# 5) 단어길이 3개 보다 큰 단어만 통과
#contrib03 namespace collision으로 인해 문제가 발생할 경우, 아래와 같이 수정합니다.
interest <- base::Filter(function(x) {nchar(x) > 3}, interest)
sub_interest <- base::Filter(function(x) {nchar(x) > 3}, sub_interest)
# 6) 데이터 빈도 분석
word_count<-table(interest)
sub_word_count <- table(sub_interest)
head(sort(word_count, decreasing = T), 30)

# 분석 결과 저장 및 시각화
write.table(sort(sub_word_count, decreasing = T), file = "abcnews_interest.txt")
# [조건] 최소 빈도수 15 이상인 단어를 워드클라우드로 시각화
par(mfrow=c(1,2))
wordcloud(names(word_count),freq=word_count, scale=c(3,0.5),rot.per = 0.25,min.freq = 5, random.order = F, colors = brewer.pal(8, "Blues"))
wordcloud(names(sub_word_count), freq=sub_word_count, rot.per = 0.25, scale=c(3,0.5),min.freq = 4, random.order = F, colors = brewer.pal(8, "Reds"))
