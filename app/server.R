assign('n_click_trans', 0, envir = .GlobalEnv)
assign('loginCorrect', FALSE, envir = .GlobalEnv)
assign('UserAdmin', FALSE, envir = .GlobalEnv)
shinyServer(function(input, output,session) {
  output$errorMensageDelete <- renderUI({})
  output$errorMensageAdd <- renderUI({}) 
  output$errorMensageLogin <- renderUI({}) 
  observeEvent(input$DeleteuserUI,{output$errorMensageDelete <- renderUI({}) })
  observeEvent(input$AddUserUI,{output$errorMensageAdd <- renderUI({}) })
  observeEvent(input$AddPasswordUI,{output$errorMensageAdd <- renderUI({}) })
  observeEvent(input$userUI,{output$errorMensageLogin <- renderUI({}) })
  observeEvent(input$passwordUI,{output$errorMensageLogin <- renderUI({}) })
  observeEvent(input$AddUser,{
    cat("se añade usuario")
    assign('newusername', input$AddUserUI, envir = .GlobalEnv)
    assign('newuserAdmin', input$AddUser_Admin, envir = .GlobalEnv)
    assign('newuserPassword', input$AddPasswordUI, envir = .GlobalEnv)
    #source("add.R")
    tryCatch(source("add.R"),error = function(e) {
      output$errorMensageAdd <- renderUI( expr =helpText(div('Verifique datos', style = 'color:white'))) 
    })
    if(tipoErrorAdd==1){
      output$errorMensageAdd <- renderUI({expr =helpText(div('usuario repetido', style ='color:red'))})
    }else if(tipoErrorAdd==2){
      output$errorMensageAdd <- renderUI({expr =helpText(div('usuario o contraseña vacio', style ='color:red'))})
    }else if(tipoErrorAdd==3){
      output$errorMensageAdd <- renderUI({expr =helpText(div('usuario o contraseña contiene espacios en blanco', style ='color:red'))})
    }else{
      output$errorMensageAdd <- renderUI({})
      output$TablaPermisos <- renderDataTable ({tabla})
      updateTextInput(session, "AddUserUI", value = "")
      updateTextInput(session, "AddPasswordUI", value = "")
      updateCheckboxInput(session,"AddUser_Admin",value=FALSE)
    }
  })
  observeEvent(input$deleteUser,{
    cat("se borra usuario")
    assign('olduser', input$DeleteuserUI, envir = .GlobalEnv)
    tryCatch(source("delete.R"),error = function(e) {
      output$errorMensageDelete <- renderUI( expr =helpText(div('Verifique datos', style = 
                                                                  'color:white'))) 
    })
    if(tipoErrorDelete==1){
      output$errorMensageDelete <- renderUI({expr =helpText(div('usuario no existe', style =
                                                                  'color:red'))})
    }else{
      output$errorMensageDelete <- renderUI({})
      output$TablaPermisos <- renderDataTable ({tabla})
      updateTextInput(session, "DeleteuserUI", value = "")
    }
  })
  shinyjs::alert("Introduzca sus credenciales para acceder a la aplicación")
  updateNavbarPage(session, "tabs",selected="Login")
  shinyjs::hide(selector = '#tabs li a[data-value="Inicio"')
  shinyjs::hide(selector = '#tabs li a[data-value="A"')
  shinyjs::hide(selector = '#tabs li a[data-value="B"')
  shinyjs::hide(selector = '#tabs li a[data-value="Logout"')
  shinyjs::hide(selector = '#tabs li a[data-value="Admin"')
  shiny::hideTab(inputId = "tabs", target = "A")
  shiny::hideTab(inputId = "tabs", target = "B")
  shiny::hideTab(inputId = "tabs", target = "Inicio")
  shiny::hideTab(inputId = "tabs", target = "Logout")
  shiny::hideTab(inputId = "tabs", target = "Admin")
  output$TablaPermisos <- renderDataTable ({})
  output$Delete1<-renderUI({})
  output$Delete2<-renderUI({})
  output$Add1<-renderUI({})
  output$Add2<-renderUI({})
  output$Add3<-renderUI({})
  output$Add4<-renderUI({})
  observeEvent(input$login,{
    assign('user', input$userUI, envir = .GlobalEnv)
    assign('password', input$passwordUI, envir = .GlobalEnv)
    tryCatch(source("login.R"),error = function(e) {
      output$errorMensageLogin <- renderUI( expr =helpText(div('Verifique datos', style = 'color:white'))) 
    })
    if(loginCorrect==TRUE){
      output$errorMensageLogin <- renderUI({}) 
      shiny::showTab(inputId = "tabs", target = "A")
      shiny::showTab(inputId = "tabs", target = "B")
      shiny::hideTab(inputId = "tabs", target = "Login")
      shiny::showTab(inputId = "tabs", target = "Logout")
      shinyjs::show(selector = '#tabs li a[data-value="A"')
      shinyjs::show(selector = '#tabs li a[data-value="B"')
      shinyjs::show(selector = '#tabs li a[data-value="Logout"')
      hideTab(inputId = "tabs", target = "Login")
      shiny::showTab(inputId = "tabs", target = "Inicio")
      shinyjs::show(selector = '#tabs li a[data-value="Inicio"')
      updateNavbarPage(session, "tabs",selected = "Inicio")
      if(UserAdmin==TRUE){
        shiny::showTab(inputId = "tabs", target = "Admin")
        shinyjs::show(selector = '#tabs li a[data-value="Admin"')
        output$TablaPermisos <- renderDataTable ({tabla}) 
        output$Delete1<-renderUI({
          textInput("DeleteuserUI","nombre Usuario que deseas borrar")
        })
        output$Delete2<-renderUI({
          actionButton("deleteUser","borrar", style = 'color:white; background:#D9230F; border:#D9230F')
        })
        output$Add1<-renderUI({
          textInput("AddUserUI","nombre Usuario que deseas añadir")
        })
        output$Add2<-renderUI({
          actionButton("AddUser","añadir", style = 'color:white; background:#D9230F; border:#D9230F')
        })
        output$Add3<-renderUI({
          checkboxInput('AddUser_Admin', strong('Administrador'), FALSE)
        })
        output$Add4<-renderUI({
          textInput("AddPasswordUI","contraseña del nuevo usuario")
        })
      }
    }else{
      if(tipoErrorLogin==1){
        output$errorMensageLogin <- renderUI({expr =helpText(div('usuario no existe', style ='color:red'))}) 
      }else if(tipoErrorLogin==2){
        output$errorMensageLogin <- renderUI({expr =helpText(div('contraseña incorrecta', style ='color:red'))})
      }
    }
  })
  observeEvent(input$logout,{
    assign('loginCorrect', FALSE, envir = .GlobalEnv)
    assign('UserAdmin', FALSE, envir = .GlobalEnv)
    updateTextInput(session, "userUI", value = "")
    updateTextInput(session, "passwordUI", value = "")
    shinyjs::alert("Introduzca sus credenciales para acceder a la aplicación")
    updateNavbarPage(session, "tabs",selected="Login")
    shinyjs::hide(selector = '#tabs li a[data-value="Inicio"')
    shinyjs::hide(selector = '#tabs li a[data-value="A"')
    shinyjs::hide(selector = '#tabs li a[data-value="B"')
    shinyjs::hide(selector = '#tabs li a[data-value="Logout"')
    shinyjs::hide(selector = '#tabs li a[data-value="Admin"')
    shinyjs::show(selector = '#tabs li a[data-value="Login"')
    shiny::hideTab(inputId = "tabs", target = "A")
    shiny::hideTab(inputId = "tabs", target = "B")
    shiny::hideTab(inputId = "tabs", target = "Inicio")
    shiny::hideTab(inputId = "tabs", target = "Logout")
    shiny::hideTab(inputId = "tabs", target = "Admin")
    shiny::showTab(inputId = "tabs", target = "Login")
    output$TablaPermisos <- renderDataTable ({})
    output$Delete1<-renderUI({})
    output$Delete2<-renderUI({})
    output$Add1<-renderUI({})
    output$Add2<-renderUI({})
    output$Add3<-renderUI({})
    output$Add4<-renderUI({})
    output$errorMensageLogin <- renderUI({}) 
  })
  
})