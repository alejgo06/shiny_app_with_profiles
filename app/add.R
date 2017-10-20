tipoErrorAdd=0
tabla<-read.table(paste0(getwd(),"/usuarios"),sep=",",header=T,stringsAsFactors = F)
tabla<-as.data.frame(tabla)
if(newusername%in%tabla$usuario){
  cat("usuario repetido")
  tipoErrorAdd=1
}else if(any(newusername=="",newuserPassword=="")){
  cat("usuario o contraseña vacio") 
  tipoErrorAdd=2
}else if(regexpr(' ', newusername)[1]!=(-1)){
  tipoErrorAdd=3
}else if(regexpr(' ', newuserPassword)[1]!=(-1)){
  tipoErrorAdd=3
}else{
  if(newuserAdmin==TRUE){
    AsAdmin<-c("Admin")
  }else{
    AsAdmin<-c("normal")
  }
  tabla<-rbind(tabla,c(newusername,newuserPassword,AsAdmin))
  write.table(tabla,file=paste0(getwd(),"/usuarios"),sep=",",row.names = F)
  
}

