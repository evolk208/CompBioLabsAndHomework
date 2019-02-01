# =========
# Computational Biology, Spring 2019 
# Basic R programming exercises 
# Lab 3, Emily Volk 
# =========
# ==== Part 1, Prompt: Hosting a party with chips and guests ====
# Lab Step 3: Storing start vars 
# 1- Start with 5 bags of chips 
chips <- 5
# Expect 8 guests to be coming 
guests <- 8

# Lab Step 5 
# Expecting each guest to eat avg of .4 bags of chips
rate_eat <- .4 

# Lab Step 7
# Calculate expected amount of leftover chips 
leftovers <- chips - (guests*rate_eat)
# From first vals, expecting that there will be 1.8 bags of chips leftover 

# ==== Part 2, Prompt: Movies, Objects, and Functions # Lab Step 8: Make vectors for individual movie rankings 
# Rankings 
Self <- c(7,6,5,1,2,3,4)
Penny <- c(5,7,6,3,1,2,4)
Jenny <- c(4,3,2,7,6,5,1)
Lenny <- c(1,7,3,4,6,5,2)
Stewie <- c(6,7,5,4,3,1,2)

# Lab Step 9: Indexing 
# Penny's ranking for episode IV 
PennyIV <- Penny[4]
# Lenny's ranking for episode IV  
LennyIV <- Lenny[4]

# Lab Step 10: Cocatenate vecs of rankings into matrix
ranking_mat <- cbind(Self, Penny, Jenny, Lenny, Stewie)
# Check dimensions to check 
dim(ranking_mat)

# Lab Step 11: Inspect var structures 
str(PennyIV)
str(Penny)
str(ranking_mat)
# PennyIV is a number, Penny is a vector of numbers and ranking_mat is a matrix of vectors of numbers that includes character headers for each column. 

# Lab Step 12: Make data frame 
# Option 1: data.frame 
# Data.frame takes vectors to combine into data frame 
str(data.frame(cbind(Self, Penny, Jenny, Lenny, Stewie)))
# Option 2: as.data.frame 
# As.data.frame converts something with similar structure to data frame into a data frame 
str(as.data.frame(ranking_mat))
# Using str to compare output. Output of these two options is the same 
# Storing as "rankings" data frame 
rankings <- as.data.frame(ranking_mat)

# Lab Step 13: Comparing matrix and df 
str(ranking_mat)
str(rankings)
dim(ranking_mat)
dim(rankings)
typeof(ranking_mat)
typeof(rankings)
ranking_mat == rankings
# Though the matrix and the data frame store the same numeric values, the data frame combines the vectors as lists under headers, given by the character names that were previously stored as a vector of characters in the matrix. Both the matrix and the data frame have the same dimensions, but the data frame organizes the data into named columns. The matrix is of type double, storing the values and the character headers as such, and the data frame is type list, where the names serve as headers for each set of values. A matrix stores values of the same data type, while a data frame stores a collection of objects. 

# Lab Step 14: Vector of names 
# Storing vector of Episode names as roman numeral characters for movies 
movies <- c("I", "II", "III", "IV", "V", "VI", "VII")
# Naming rows of rankings as episode that ranking applies to 
row.names(rankings) <- movies 

# Accessing elements of matrices and data frames 
# Lab Step 16: Access third row of matrix from step #10 
ranking_mat[3,]

# Lab Step 17: Access fourth col from data frame from step #12 
rankings[,4]

# Lab Step 18: Access self ranking for Episode V 
# Note: can either do these with the roman numeral chr names or with numeric indexing 
rankings["V","Self"]

# Lab Step 19: Access Penny's ranking for Episode II 
rankings["II","Penny"]

# Lab Step 20: Access everyone's rankings for episodes IV-VI
rankings[4:6,]

# Lab Step 21: Access everyone's rankings for episodes II, V, VII
rankings[c(2,5,7),]

# Lab Step 22: Access rankings for P, J, and S for eps IV and VI 
rankings[c(4,6), c("Penny", "Jenny", "Stewie")]

# Use indexing to assign new values to entries in a matrix or data frame 
# Lab Step 23: Switch Lenny's rankings for ep II and V in either mat or df 
rankings$Lenny[c(2,5)] <- rankings$Lenny[c(5,2)]

# Step 24: Accessing for mats and dfs 
rankings["III", "Penny"]
ranking_mat[3,2]

# Step 25: Use name accessing to switch back vals from step 23
#Switch Lenny's rankings for ep II and V in either mat or df 
rankings[c("II","V"), "Lenny"] <- rankings[c("V","II"), "Lenny"]

# Step 26: Re-switch again
rankings$Lenny[c(2,5)] <- rankings$Lenny[c(5,2)]

