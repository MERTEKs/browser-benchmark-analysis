# browser-benchmark-analysis
This repository contains benchmark results comparing popular web browsers on PC. If you'd like me to include additional browsers, please feel free to suggest them.

# Browser Benchmark Comparison
browser_data <- data.frame(
  Browser = c("Chrome", "Opera GX", "Edge"),
  Speedometer = c(14.67, 11.63, 15.07),
  JetStream = c(184.68, 164.75, 185.59),
  MotionMark = c(675.59, 642.31, 837.45),
  Kraken_ms = c(762.57, 802.93, 759.73)  # Düşük olan iyi
)

browser_data

library(tidyr)
library(dplyr)

browser_long <- browser_data %>%
  pivot_longer(cols = -Browser,
               names_to = "Test",
               values_to = "Score")

browser_long


library(ggplot2)

# Speedometer, JetStream, MotionMark Graph
browser_long %>%
  filter(Test != "Kraken_ms") %>%
  ggplot(aes(x = Browser, y = Score, fill = Browser)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~Test, scales = "free_y") +
  labs(title = "Browser Benchmark Comparison",
       subtitle = "Speedometer, JetStream and MotionMark (higher score is better)",
       y = "Score", x = "Browser") +
  theme_minimal()

# Kraken Graph
browser_long %>%
  filter(Test == "Kraken_ms") %>%
  ggplot(aes(x = Browser, y = Score, fill = Browser)) +
  geom_bar(stat = "identity") +
  labs(title = "Kraken 1.1 Comparison",
       subtitle = "Lower score is better (ms)",
       y = "Time (ms)", x = "Browser") +
  theme_minimal()

library(tidyr)
library(dplyr)
library(ggplot2)

# 1) Dataset
browser_data <- data.frame(
  Browser = c("Chrome", "Opera GX", "Edge"),
  Speedometer = c(14.67, 11.63, 15.07),
  JetStream = c(184.68, 164.75, 185.59),
  MotionMark = c(675.59, 642.31, 837.45),
  Kraken_ms = c(762.57, 802.93, 759.73)
)

# 2) Convert to long format
browser_long <- browser_data %>%
  pivot_longer(cols = -Browser,
               names_to = "Test",
               values_to = "Score")

# 3) Faceted bar chart
ggplot(browser_long, aes(x = Browser, y = Score, fill = Browser)) +
  geom_bar(stat = "identity") +
  facet_wrap(~Test, scales = "free_y") +
  labs(title = "Browser Benchmark Comparison",
       subtitle = "Speedometer / JetStream / MotionMark: higher is better | Kraken: lower is better",
       x = "Browser", y = "Score") +
  theme_minimal() +
  theme(legend.position = "none")

