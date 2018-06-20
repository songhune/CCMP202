rm(list=ls())

pc <- sample(1:10,1,replace = F)
user<-1
count <- 1

cat('guess a numver between 1 and 10\n')

while(guess != pc){
  user<-scan(n=1)
  if(user==pc){
    cat('congrats',pc,'is right, you have managed it in ',count,'times')
    break
}
else if(user<pc){
  cat('it\'s bigger')
  count<-count+1
}
else if (user>pc){
  count<-count+1
  }
}
