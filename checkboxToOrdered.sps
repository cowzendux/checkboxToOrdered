﻿* Encoding: UTF-8.
* checkboxToOrdered
* by Jamie DeCoster

* This function takes a list of existing binary variables and converts them into a single
categorical variable based on an ordered list. If none of the boxes are selected, the 
categorical variable is missing. If one or more of the checkboxes are selected, the 
value of the categorical variable is based on the highest value in the list. The function
also assigns value labels corresponding to the highest checkbox selected.

**** usage: checkboxToOrdered(varlist, orderedVar)
**** "varlist" is a list of variables in the existing data set that are to be considered when
* calculating the value of the ordered variable. These variables should all be numeric
* and binary (coded 0 or 1). The list should be ordered so that if an
* individual selects two of the checkbox variables, the variable you want represented in
* the ordered variable occurs later in the list. 
**** "orderedVar" is the name of the new categorical variable to be created.

**** example: checkboxToOrdered(varlist = ["HS", "Bachelors", "Masters", "Doctorate"], 
orderedVar = "Education")
**** The function will create a new variable called "Education" that has values ranging from
* 1 to 4. If participants only selected HS, then they would have a value of 1. If they only 
* selected Bachelors or selected HS and Bachelors, they would have a value of 2. If they
* only selected Masters or they selected Masters and any of the lower degrees, they would
* have a value of 3. If they only selected Doctorate or they selected Doctorate and any
* of the other degrees, they would have a value of 4.

BEGIN PROGRAM PYTHON3.
import spss

def checkboxToOrdered(varlist, orderedVar):
    submitstring = "numeric {0} (f8).".format(orderedVar)
    for t in range(len(varlist)):
        submitstring += "\nif ({0} > 0) {1} = {2}.".format(varlist[t], orderedVar, t+1)
    submitstring += """\nexecute.
value labels {0}""".format(orderedVar)
    for t in range(len(varlist)):
        submitstring += "\n{0} {1}".format(t+1, varlist[t])
    spss.Submit(submitstring)
end program python.

**********
* Version History
**********
* 2020-07-20 Created
