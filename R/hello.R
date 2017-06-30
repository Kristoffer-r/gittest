
hello <- function() {
  print("Hello, world!")
  require(devtools)

}

updatePackageVersion <- function(packageLocation ="."){
  desc <- readLines(file.path(packageLocation, "DESCRIPTION"))
  vLine <- grep("^Version\\:", desc)
  dLine = grep("^Date\\:", desc)
  if(length(dLine) == 0){
    desc = c(desc, paste("Date:", Sys.Date()))
  }else{
    desc[dLine] = paste("Date:", Sys.Date())
  }
  vNumber <- gsub("^Version\\:\\s*", "", desc[vLine])
  versionNumber <- strsplit(vNumber, "\\.")[[1]]
  versionParts <- length(versionNumber)
  vNumberKeep <- paste(versionNumber[1:(versionParts-1)], sep= "", collapse= ".")
  vNumberUpdate <- versionNumber[versionParts]
  oldVersion <- as.numeric(vNumberUpdate)
  newVersion <- oldVersion + 1
  vFinal <- paste(vNumberKeep, newVersion, sep = ".")
  desc[vLine] <- paste0("Version: ", vFinal )
  writeLines(desc, file.path(packageLocation, "DESCRIPTION"))
 return(vFinal)
}
git_commit = function(message, push_now=T){
  require(git2r)
  files = dir(".", recursive = T)
  exts = tools::file_ext (files)
  files = files[!exts %in% c("Rproj")]
  repo = init(".")
  add(repo, files)
  commit(repo, message)
  if(push_now){
    push(repo)
  }
}

