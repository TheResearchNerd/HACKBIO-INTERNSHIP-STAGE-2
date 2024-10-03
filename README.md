# HACKBIO-INTERNSHIP-STAGE-2
Gene Expression Analysis, Visualisation and Downstream Functional Enrichment Analysis of A Glioblastoma Dataset
Task Objective
In this task, a gene expression dataset for glioblastoma was visualized and interpreted to generate a heatmap and downstream functional enrichment analysis was performed. This helped to understand and interpret patterns of gene expression and the biological significance of differentially expressed genes (DEGs). The task involved data preprocessing, visualization, and interpretation of functional enrichment results.

Steps involved in gene expression analysis
Download the following dataset: https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/Cancer2024/glioblastoma.csv

Generate a heatmap for the entire dataset. Use a diverging and sequential color palette to generate two color variants of the same heatmap using the heatmap.2() function from the gplots package in R. 

With the same heatmap, generate a variant of your heatmap with dendrograms to:

Cluster the genes (rows) alone,
Cluster the samples (col) alone,
Cluster both genes and sample together.
Group the data based on the columns (samples).

Get the means, fold change and p-values of the two groups.

Visualise the fold change and negative log10 of p-values using the plot() function.

Subset genes that are significantly upregulated and genes that are significantly downregulated. Set the p-value cut-off as 0.05, with log2fold-change of 21 to 3 for significantly upregulated genes and -22 to -3 for significantly downregulated genes.

Steps involved in functional enrichment analysis
Perform functional enrichment analysis with ShinyGO by pasting the list of gene IDs and set the p-value cutoff at 0.05.

Download the results provided for the top enriched KEGG pathways.

Using the top 5 pathways, create a straightforward visualization (such as a lollipop plot, dot plot, line plot or bubble plot) that displays the number of genes associated with each pathway. The plot should also reflect the significance of each pathway by scaling the points according to the negative log10 of the p-value.

For the same list of genes, set the ‘Pathway database’ to ‘GO Biological Process’.

Download the results provided for the top enriched pathways.

Describe the top 3 enriched pathways according to GO biological process.
