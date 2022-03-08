# Packgaes
library(tidyverse)
library(googlesheets4)

# Current libraries
## Update: Use pacman instead for reproducibility
library(shiny)
library(tidyverse)
library(shinydashboard)
library(plotly)
library(gt) # table
library(gtsummary) # creating summaries
library(reactable) # "fun" table
library(viridis)
library(scales)
library(shinyWidgets)
theme_set(theme_light())


# Dataset

# Custom theme
mike_theme = function () { 
    theme_bw() %+replace% 
        theme(
            # keeps only horizontal lines
            panel.grid.major.x= element_blank(), 
            panel.grid.minor.x = element_blank(),
            # Title & subtitle
            plot.title = element_text(size = 18, hjust = 0, vjust = 0.5, 
                                      margin = margin(b = .5, unit = "cm")),
            plot.subtitle = element_text(size = 15, hjust = 0, vjust = 0.5, colour = "grey30",
                                         margin = margin(b = 0.2, unit = "cm")),
            # Caption
            plot.caption = element_text(size = 7, hjust = 1, face = "italic", colour = "grey70",
                                        margin = margin(t = 0.1, unit = "cm")),
            # X - axis
            axis.title.x = element_text(margin = margin(t = .5,unit = "cm"), color = "grey50"),
            # Y - axis
            axis.title.y = element_text(margin = margin(r = .5, unit = "cm"), color = "grey50",angle = 90)
        )
}





# UI -------------
ui <- dashboardPage(
    ## Header
    dashboardHeader(title = "Sunday futsal",dropdownMenuOutput("msg_alert")),
    skin = "yellow",
    ## Sidebar -------------------------------------------------
    dashboardSidebar(
        sidebarMenu(menuItem(text = "Goals",tabName = "goal",icon = icon("goalnet")),
                    menuItem(text = "Game predictions",tabName = "game",icon = icon("futbol")))
        ),
    ## Body --------------------------------------------------------
    dashboardBody(
        tabItems(
            ### Goal section ------
            tabItem(tabName = "goal",
                    titlePanel(title = "Goal stuff goes here"),
                    fluidPage(
                        column(width = 9,
                               box(width = NULL,title = "Top goal scorer",solidHeader = T,status = "primary",plotlyOutput("goal_plot")))
                    )), 
            ### ADD GOAL_PLOT into this section. 
            ### Game predictions
            tabItem(tabName = "game",
                    titlePanel(title = "Game stuff goes here"),
                    fluidPage())
        )
    ))
        
                        
                               
                                
                            
# Server ----------------------------
server<- function(input,output,session) {
    # Goal plot - ggplot to be rendered in plotly
    goal_plot_gg = df %>% 
        group_by(player) %>% 
        summarise(total = sum(goals)) %>% 
        ggplot(aes(x = reorder(player,-total), y = total, fill = player)) +
        geom_col(show.legend = F) +
        labs(x = "Player", y = "Total goals scored") +
        mike_theme()
    
    ##### Time series
    
    # Create plot
    output$goal_plot<- renderPlotly(ggplotly((goal_plot_gg))) # Create plotly object
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)

