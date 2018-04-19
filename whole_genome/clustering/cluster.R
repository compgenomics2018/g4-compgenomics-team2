#!/usr/bin/env Rscript

library(hash)
library(igraph)

# Assign colors to labels
colorCodes = c(H="red", R="green", S="blue", N = "yellow")
labelCol = function(x) {
  if (is.leaf(x)) {
    label = attr(x, "label")
    type = resistance[[label]]
    code = substr(type, 1, 1)
    attr(x, "nodePar") = list(lab.col=colorCodes[code])
  }
  return(x)
}

generateDendrograms = function(edges) {
  graph_obj = graph.data.frame(edges, directed = FALSE)
  adj = as_adjacency_matrix(graph_obj, type="both", names=TRUE, sparse=FALSE, attr="V3")

  cl = hclust(as.dist(adj))
  dend = as.dendrogram(cl)
  par(cex=0.3)
  plot(dend, main="Clustered Genomes", ylab = "MinHash Distance")
  plot(dend, main="Clustered Genomes", xlab = "MinHash Distance", horiz = TRUE)

  par(cex=0.3)
  colored = dendrapply(as.dendrogram(cl), labelCol)
  plot(colored, main="Clustered Genomes", ylab = "MinHash Distance")
  par(cex=1)
  legend("topright", legend = c("Heteroresistant", "Resistant" ,"Susceptible"), col=c("red", "green", "blue"),lty=c(1,1,1), bty="n")
  par(cex=0.3)
  plot(colored, main="Clustered Genomes", xlab = "MinHash Distance", horiz = TRUE)
}


# MinHash distance matrix, in form of an edge list
dist <- read.table("ALL_mash_dist")
metadata <- read.csv("Merged_SRR_Strain.csv")

resistance = hash()
# Create a mapping from SRR to resistance type
for (i in 1:dim(metadata)[1]) {
  resistance[[paste(metadata$SRRID[i], ".fasta", sep = "")]] = metadata$Fosfomycin.Heteroresistance[i]
}

# Create a filtered edgelist (without NAAs)
edgelist = list()
for (i in 1:dim(dist)[1]) {
  # Handle missing samples
  if ((is.null(resistance[[as.character(dist$V1[i])]])) || (is.null(resistance[[as.character(dist$V2[i])]])) ) {
    next
  }
  # Do not include NAA nodes
  if ((resistance[[as.character(dist$V1[i])]] != "NAA") && (resistance[[as.character(dist$V2[i])]] != "NAA")) {
    edgelist[[i]] = dist[i, 1:3]
  }
}
edgelist = do.call(rbind.data.frame, edgelist)
generateDendrograms(edgelist)

# Create another edgelist without outliers
outliers = c("SRR5666568.fasta", "SRR4017929.fasta", "SRR4017833.fasta", "SRR4017925.fasta")
edgelistNoOutliers = list()
for (i in 1:dim(edgelist)[1]) {
  outlier = FALSE
  for (j in 1:length(outliers)) {
    if ((as.character(edgelist$V1[i]) == outliers[j]) || (as.character(edgelist$V2[i]) == outliers[j])) {
      outlier = TRUE
    }
  }
  if (outlier == FALSE) {
    edgelistNoOutliers[[i]] = edgelist[i,]
  }
}
edgelistNoOutliers = do.call(rbind.data.frame, edgelistNoOutliers)
generateDendrograms(edgelistNoOutliers)
