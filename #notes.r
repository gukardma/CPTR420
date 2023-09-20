# notes
# switch statements
students <- c("Tom", "Jim", "Sue", "Ann", "Tim", "Ken")
# Switch(expression, values, default)
# Example using a string expression with default value
person <- 4
height <- switch(person,
    "Tom" = 6.5,
    "Jim" = 6.2,
    "Sue" = 5.9,
    "Ann" = 5.2,
    "Tim" = 5.8,
    "Ken" = 6.0,
    "Too tall"
)
height

# example using a numeric expression
person <- 5
height <- switch(person, ifelse(person<1, "too short,", person * 2)
    6.5,
    6.2,
    5.9,
    5.2,
    5.8,
    6.0,
    "Too tall"
)
height
