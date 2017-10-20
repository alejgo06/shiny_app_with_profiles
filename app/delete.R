tipoErrorDelete=0
tabla<-read.table(paste0(getwd(),"/usuarios"),sep=",",header=T,stringsAsFactors = F)
tabla<-as.data.frame(tabla)
if(olduser%in%tabla$usuario){
  tabla<-tabla[!tabla$usuario%in%olduser,]
  write.table(tabla,file=paste0(getwd(),"/usuarios"),sep=",",row.names = F)
}else{
  cat("usuario no existe") 
  tipoErrorDelete=1
}