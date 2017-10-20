shinyUI(navbarPage('App', theme = shinytheme("simplex"),id = "tabs",
                   
                   fluidRow(
                     useShinyjs(),
                     br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                     column(12, align = 'center',
                        img(
                          src = "RStudio.png",
                          height = 90.2812 * 2.2,
                          width = 287.375 * 2.2
                        )
                     )
                   )
                   ,
                   tabPanel("Inicio",
                            fluidRow(
                              useShinyjs(),
                              br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),br(),
                              column(12, align = 'center',
                                  img(
                                    src = "RStudio.png",
                                    height = 90.2812 * 2.2,
                                    width = 287.375 * 2.2
                                  )
                              )
                            )
                   ),
                   navbarMenu("A",
                       tabPanel("A 1"), 
                       tabPanel("A 2"),
                       tabPanel("A 3"), 
                       tabPanel("A 4") 
                   ), 
                   tabPanel("B"),  
                   tabPanel("Login"
                            ,
                            fluidRow(
                              column(4, align = 'left',
                                     textInput(
                                       "userUI",
                                       width = 1250,
                                       label = div("Usuario", style = 'font-weight:bold; font-size: 15px; color:#777777'),
                                       value = ''
                                     ),
                                     passwordInput(
                                       "passwordUI",
                                       width = 1250,
                                       label = div("contraseña", style = 'font-weight:bold; font-size: 15px; color:#777777'),
                                       value = ''
                                     ),
                                     actionButton('login', 'login', style = 'color:white; background:#D9230F; border:#D9230F'),
                                     uiOutput("errorMensageLogin")
                              )
                            )
                            
                   )
                   ,
                   tabPanel("Logout"
                            ,
                            fluidRow( 
                              column(4, align = 'left',
                                     actionButton('logout', 'logout', style = 'color:white; background:#D9230F; border:#D9230F')
                              )
                            )
                            
                   )
                   ,
                   tabPanel("Admin"
                            ,
                            fluidRow( 
                              
                              column(4,
                                     uiOutput("Delete1")
                                     
                              ),
                              br(),
                              column(4,
                                     uiOutput("Delete2")
                                     
                              ),
                              column(3,
                                     uiOutput("errorMensageDelete")
                                     
                              )
                            ),hr(),
                            fluidRow(
                              
                              column(3,
                                     uiOutput("Add1")
                                     
                              ),
                              column(3,
                                     uiOutput("Add4")
                                     
                              ),br(),
                              column(3,
                                     uiOutput("Add3")
                                     
                              ),
                              column(3,
                                     uiOutput("Add2")
                                     
                              ),
                              column(3,
                                     uiOutput("errorMensageAdd")
                                     
                              )
                            ),hr(),
                            fluidRow(
                              column(10, align = 'center',
                                     dataTableOutput ('TablaPermisos')  
                              )
                            )
                            
                   )
                   
                   
)) 
