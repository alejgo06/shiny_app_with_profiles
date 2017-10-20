tipoErrorLogin=0
tabla<-read.table(paste0(getwd(),"/usuarios"),sep=",",header=T,stringsAsFactors = F)
tabla<-as.data.frame(tabla)
if(user%in%tabla$usuario){
  if(password==tabla$password[tabla$usuario%in%user]){
    assign('loginCorrect', TRUE, envir = .GlobalEnv)
    if(tabla$tipo[tabla$usuario%in%user]=="Admin"){
      assign('UserAdmin', TRUE, envir = .GlobalEnv)
    }
  }else{
    tipoErrorLogin=2
    cat("\ncontraseña incorrecta")
  }
}else{
  cat("\nusuario no existe")
  tipoErrorLogin=1
}

