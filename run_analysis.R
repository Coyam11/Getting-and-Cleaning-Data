### Tarea final Getting and Cleaning Data ####

install.packages("dplyr")
library(dplyr)

install.packages("tidyr")
library(tidyr)

installed.packages("tibble")
library(tibble)


### Descargar y descomprimir los archivos ####

files<-"datasetfinal.zip"

if (!file.exists(files)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, files, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(files) 
}


### Cargar el listado con nombres de variables ###

nombres <- read.table("./UCI HAR Dataset/features.txt")
nombres <-paste(nombres[,1], nombres[,2])

### Cargar los archivos de test ###

test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
test_subject <- read.table ("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

names(test)<-nombres

test <- cbind (test, setNames(test_subject, "subject"), setNames(test_labels, "activity"))

### Cargar los archivos de train ####

train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
train_subject <- read.table ("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

names(train)<-nombres

### Crear una nueva variable que tiene siempre el valor "Train" ###

train <- cbind (train, setNames(train_subject, "subject"), setNames(train_labels, "activity"))

### Unir ambas bases para crear test_train ###

testtrain <- rbind(test, train)

### Reconocer las columnas que tienen la palabra mean o std ####

columnas <- grep("(mean\\(\\)|std\\(\\))", nombres)

### Seleccionar las columnas correctas ###

testtrain <- select(testtrain, c(columnas, "subject", "activity"))

### Abrir labels y asignar a la variable activity los nombres correspondientes ###

activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

testtrain$activity<-factor(testtrain$activity, levels = activitylabels$V1,  labels= activitylabels$V2)

### Hacer que los nombres de las variables sean claros ###

varnames<-tolower(names(testtrain))
varnames<-gsub("([0-9]{1,3}) ", "", varnames)
varnames<-gsub("\\()", "", varnames)
varnames<-gsub("-", "", varnames)
varnames<-gsub("^t", "time", varnames)
varnames<-gsub("^f", "frequency", varnames)
varnames<-gsub("bodybody", "body", varnames)

### Poner nombres de variables a la base correspondiente ####

names(testtrain)<-varnames

### Elimnar todo lo creado que no se vaya a utilizar ###

rm(activitylabels, test, test_labels, test_subject, train, train_labels, train_subject, columnas, nombres, varnames)

### Base final ###

testtraintidydata <- testtrain %>% group_by(activity, subject) %>% summarize_each(funs(mean))

### Guardado base final ###

write.table(testtraintidydata, "testrain.txt", row.names = FALSE)

