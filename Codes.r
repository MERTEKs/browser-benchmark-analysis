library(tidyr)
library(dplyr)
library(ggplot2)

# 1) Raw data (3 runs per test)
browser_data <- data.frame(
  Browser = c("Chrome", "Opera GX", "Edge", "Firefox", "Opera", "Brave"),
  
  Speed1 = c(14.2, 11.7, 14.8, 8.77, 13.3, 13.8),
  Speed2 = c(14.9, 11.2, 15.5, 11.1, 13.2, 13.5),
  Speed3 = c(14.9, 12.0, 14.9, 11.6, 12.6, 13.2),
  
  Jet1 = c(185.490, 162.463, 185.843, 121.207, 164.476, 179.680),
  Jet2 = c(186.411, 163.458, 186.137, 118.565, 165.039, 179.945),
  Jet3 = c(182.141, 168.323, 184.792, 118.286, 164.761, 184.289),
  
  Motion1 = c(675.15, 648.52, 842.75, 717.03, 656.56, 1071.32),
  Motion2 = c(678.28, 642.28, 840.54, 707.12, 624.32, 1059.87),
  Motion3 = c(673.33, 636.13, 829.06, 517.62, 640.74, 1066.88),
  
  Kraken1 = c(763.7, 801.6, 764.5, 1214.5, 809.2, 760.0),
  Kraken2 = c(761.4, 803.8, 755.3, 1197.7, 809.1, 759.1),
  Kraken3 = c(762.6, 803.4, 759.4, 1202.8, 798.9, 767.8)
)

# 2) Calculate averages
browser_avg <- browser_data %>%
  mutate(
    Speedometer = rowMeans(select(., Speed1:Speed3)),
    JetStream   = rowMeans(select(., Jet1:Jet3)),
    MotionMark  = rowMeans(select(., Motion1:Motion3)),
    Kraken_ms   = rowMeans(select(., Kraken1:Kraken3))
  ) %>%
  select(Browser, Speedometer, JetStream, MotionMark, Kraken_ms)

# 3) Convert to long format
browser_long <- browser_avg %>%
  pivot_longer(cols = -Browser,
               names_to = "Test",
               values_to = "Score")

# 4) Faceted horizontal bar chart
ggplot(browser_long, aes(x = reorder(Browser, Score), y = Score, fill = Browser)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  facet_wrap(~Test, scales = "free_x") +
  labs(title = "Browser Benchmark Comparison",
       subtitle = "Speedometer / JetStream / MotionMark: higher is better | Kraken: lower is better",
       x = "Browser", y = "Score") +
  theme_minimal() +
  theme(legend.position = "none")
