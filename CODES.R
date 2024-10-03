# ---------STEP 1---------- #

# Load the gplots package
library(gplots)

# Define the URL and load the dataset
url <- "https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/Cancer2024/glioblastoma.csv"
glioblastoma_data <- read.csv(url, row.names = 1)

# Check the first few rows of the data frame
head(glioblastoma_data)

# View the data frame
View(glioblastoma_data)

# Generate the heatmap
heatmap.2(as.matrix(glioblastoma_data), main = "Heatmap of Glioblastoma Data", trace = 'none')

# Scale the data
heatmap.2(as.matrix(glioblastoma_data), main = "Heatmap of Glioblastoma Data", trace = 'none', 
          scale='row', dendrogram = 'col', 
          Colv = TRUE, Rowv = FALSE)

# Add colors (diverging colour palette)
heatmap.2(as.matrix(glioblastoma_data), main = "Heatmap of Glioblastoma Data (Diverging Palette)", trace = 'none', 
          scale='row', dendrogram = 'none', 
          Colv = TRUE, Rowv = FALSE,
          col=hcl.colors(10, palette = 'Blue-Red 2'))


# Add colors (sequential colour palette)
heatmap.2(as.matrix(glioblastoma_data), main = "Heatmap of Glioblastoma Data (Sequential Palette)", trace = 'none', 
          scale='row', dendrogram = 'none', 
          Colv = TRUE, Rowv = FALSE,
          col=hcl.colors(10, palette = 'Blues3'))



# ---------STEP 2---------- #

# Cluster the genes (rows) alone
heatmap.2(as.matrix(glioblastoma_data), main = "Heatmap of Glioblastoma Data", trace = 'none', 
          scale='row', dendrogram = 'row', 
          Colv = FALSE, Rowv = TRUE)

# Cluster the samples (columns) alone
heatmap.2(as.matrix(glioblastoma_data), main = "Heatmap of Glioblastoma Data", trace = 'none', 
          scale='row', dendrogram = 'col', 
          Colv = TRUE, Rowv = FALSE)

# Cluster both genes and samples together
heatmap.2(as.matrix(glioblastoma_data), main = "Heatmap of Glioblastoma Data", trace = 'none', 
          scale='row', dendrogram = 'both')



# ---------STEP 3 & 4---------- #

# Get the column names
colnames(glioblastoma_data)


# Select the groups by index positions
group1 <- c(1,2,3,4,5)
group2 <- c(6,7,8,9,10)

# Get data for the groups
group1_data <- glioblastoma_data[, group1]
group2_data <- glioblastoma_data[, group2]

# Get means of the groups
group1_mean <- rowMeans(group1_data)
group2_mean <- rowMeans(group2_data)

# Get the fold-change values
fold_change <- log2(group2_mean) - log2(group1_mean)
fold_change

# Get the p-values
p_values <- apply(glioblastoma_data, 1, function(row) {
  t.test(row[1:5], row[6:10])$p.value})

# Visualize the fold-change and negative log10 of p-values
plot(fold_change, -log10(p_values), 
     xlab = "Fold Change", ylab = "-Log10 adjusted p-value", 
     main = "Volcano Plot of Glioblastoma Data", pch = 19, 
     col = ifelse(pvalues < 0.05, "red", "black"))

# Horizontal line for p-value threshold
abline(h = -log10(0.05), col = "blue", lty = 2)

# Vertical line for fold-change thresholds
abline(v = c(-2, 2), col = "green", lty = 2)

gene_names <- paste0("glioblastoma_data", seq_along(fold_change))

# Set cut-off value for fold-change and p-values
p_value_cutoff <- 0.05
fold_change_cutoff <- 2

significant_genes <- p_values < p_value_cutoff

# Up-regulated genes
up_regulated_genes <- fold_change > fold_change_cutoff & significant_genes

# Down-regulated genes
down_regulated_genes <- fold_change < -fold_change_cutoff & significant_genes

# Up-regulated genes
up_regulated_genes_names <- gene_names[up_regulated_genes]
up_regulated_genes_fold_change <- fold_change[up_regulated_genes]
up_regulated_genes_p_values <- p_values[up_regulated_genes]

# Down-regulated genes
down_regulated_genes_names <- gene_names[down_regulated_genes]
down_regulated_genes_fold_change <- fold_change[down_regulated_genes]
down_regulated_genes_p_values <- p_values[down_regulated_genes]

# Output results
cat("Up-regulated genes:\n")
print(data.frame(
  Gene = up_regulated_genes_names,
  FoldChange = up_regulated_genes_fold_change,
  PValue = up_regulated_genes_p_values))

cat("\nDown-regulated genes:\n")
print(data.frame(
  Gene = down_regulated_genes_names,
  FoldChange = down_regulated_genes_fold_change,
  PValue = down_regulated_genes_p_values))
