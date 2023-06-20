'
In this script a graph is produced to show the change in X and Y values over
time combined with the addition of a dummy variable.

For the script there are packages used which must be installed and loaded, 
these are:
ggplot2
readxl


To import these type into the console
install.packages("ggplot2")
install.packages("readxl")

Then load them by typing
library("ggplot2")
library("readxl")
'
# Reading in Dataframe
df <- read_xlsx("for graph.xlsx", skip=3)

# Creating empty vector to find how many dates have dummy variables active
dummy = c()


# Creating range for for loop
my_range <- length(df[[1]])

'
This loop will produce a vector consisting of an arbrituary value much larger
than that of the X and Y values. This will therefore create a vector that
matches the length of the dates where the dummy variable is active and can
therefore be used when plotting as bars.
'
#S tart of loop
for( i in 1:my_range)
{
  # If statement for when the dummy variable is active
  if (df[i,4] == 1)
  {
    # When the dummy is active the vector length is increased by 1
    dummy <- append(dummy,50)
    
  }
}

# Plotting use ggplot
p =  ggplot() +
  
  # Creating bar chart of dummy variables
  geom_bar(aes(x = df[1][df[4]==1], y= dummy, fill = "Dummy Variable"), 
           stat = "identity", alpha=0.6, 
           colour = "#c0c0c0") +
  
  # Removing grid lines and a changing background to white
  theme_classic()+
  
  # Creating Y value line
  geom_line(data = df, aes(x = Year, y = Y, color = "Y"), stat="identity") +
  
  # Creating X value line
  geom_line(data = df, aes(x = Year, y = X, color = "X"), stat="identity") +
  
  # Creating title
  ggtitle("Changes of X and Y Over Time With Dummy Variable")+
  
  # Axes labels
  xlab('Year') +
  ylab('X and Y Values')+
  
  # Creating color scheme
  scale_color_manual(breaks = c("Y", "X"),
                     values=c("blue", "red"))+
  scale_fill_manual("legend", values = c("Dummy Variable" = "#9a9a9a"))+
  
  # Setting legend name
  guides(fill=guide_legend(title=""), color=guide_legend(title=''))+
  
  # Setting title to center
  theme(plot.title = element_text(hjust = 0.5),panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        # Remove panel background
        panel.background = element_blank(),
        # Add axis line
        panel.border = element_rect(colour = "black", fill=NA, size=0.5)
  ) +
  
  # Number of ticks on axis
  scale_y_continuous(n.breaks=10) +
  scale_x_datetime(date_breaks = "2 year", date_labels = "%Y") +
  
  # Dimensions of graph
  coord_cartesian(ylim=c(0.665,14))+
  
  # Adjusting position of legend
  theme(legend.position = c(0.85, 0.78))

# Printing graph 
print(p)