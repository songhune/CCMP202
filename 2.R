install.packages('igraph')
library(igraph)

df <-read.csv()

df<-as.data.frame(df)
class(df)

df<-graph.data.frame(df,directed = F)
plot(df,vertex.label=v(df)$name, vertex.size = degree(df)*5)