# simple-calc-ios-2
## support any device screen size
UI should look "more or less" the same across differnt devices  
meaning, buttons in roughly the same place, same relative size, etc  
in other words, use AutoLayout to create a generic display  
support screen rotation  
be able to use the device in any orientation without losing state
## add a new button labeled "History"
segue to a new screen that contains a UIScrollView
this should in turn contain UILabels as children
each label should have a "history" of the most recent calculations
display as "2 + 2 = 4" "4 / 4 = 1", and so on
have a button to return to the main display
