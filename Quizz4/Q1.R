dt <- data.table(read.csv("./Quizz4/ss06hid.csv"))

varNames <- names(dt)
varNamesSplit <- strsplit(varNames, "wgtp")
varNamesSplit[[123]]