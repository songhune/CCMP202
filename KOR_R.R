library(KoNLP)
library(stringr)
library(wordVectors)
library(dplyr)
library(ggplot2)
library(wordcloud)
library(tsne)

train <- read.csv('ratings_train-Copy1.txt', sep = '\t', header = T, fileEncoding = 'UTF-8', stringsAsFactors = F)
train_label <- train[,3]
train_text <- train[,2]
write.table(train_text, file = 'text.txt', row.names = F, col.names = F)

nouns <- extractNoun(train_text)
wordcount<-table(unlist(nouns))
df_word<-as.data.frame(wordcount,stringsAsFactors = F)
df_word<-rename(df_word, word=Var1, freq = Freq)
df_word <-filter(df_word, nchar(word)>=2)
top_20 <-df_word%>%
  arrange(desc(freq)) %>%
  head(20)
order<-arrange(top_20, freq)$word

#시각화1. 빈도단순그래프
ggplot(data = top_20, aes(x=word, y=freq))+
ylim(0,3500)+
geom_col()+
coord_flip()+
scale_x_discrete(limit=order)+
geom_text(aes(label=freq),hjust = -0.3)
#시각화2. 워드클라우드
pal <- brewer.pal(8,"Dark2")
wordcloud(words = df_word$word, freq = df_word$freq,  min.freq = 20,max.words = 100, random.order = F.
          scale = c(3, 1),  colors = pal)  

#시각화3.word2vec model
model = train_word2vec(train_file = 'text.txt', output_file = "D:/NLP/RNLP/vectors.bin", threads=4, vectors=300, window=12) 
nearest_to(model,model[["경제"]], 10)
some = nearest_to(model,model[[c("영화","평점","내용","재미")]], 20)
plot(filter_to_rownames(model,names(some)))

