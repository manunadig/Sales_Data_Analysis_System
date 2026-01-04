library(ggplot2)
library(dplyr)

# Load cleaned data
sales <- read.csv("C:/Users/LENOVO/Desktop/mtech\salesdata/cleaned_sales.csv")

# ===============================
# 1️⃣ Summary Statistics
# ===============================
summary(sales$revenue)

# ===============================
# 2️⃣ Revenue by Category
# ===============================
category_sales <- sales %>%
  group_by(category) %>%
  summarise(total_revenue = sum(revenue))

print(category_sales)

# 🔹 BAR PLOT: Category-wise Revenue
ggplot(category_sales, aes(x = category, y = total_revenue, fill = category)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Category-wise Revenue Comparison",
    x = "Product Category",
    y = "Total Revenue"
  ) +
  theme_minimal()

# ===============================
# 3️⃣ Revenue Distribution (Histogram)
# ===============================
ggplot(sales, aes(x = revenue)) +
  geom_histogram(binwidth = 5000, fill = "steelblue", color = "black") +
  labs(
    title = "Revenue Distribution",
    x = "Revenue Amount",
    y = "Frequency"
  ) +
  theme_minimal()

# ===============================
# 4️⃣ Monthly Sales Trend
# ===============================
sales$order_date <- as.Date(sales$order_date)
sales$month <- format(sales$order_date, "%Y-%m")

monthly_sales <- sales %>%
  group_by(month) %>%
  summarise(total_revenue = sum(revenue))

print(monthly_sales)

# 🔹 LINE GRAPH: Monthly Trend
ggplot(monthly_sales, aes(x = month, y = total_revenue, group = 1)) +
  geom_line(color = "blue", size = 1) +
  geom_point(size = 3) +
  labs(
    title = "Monthly Sales Trend",
    x = "Month",
    y = "Total Revenue"
  ) +
  theme_minimal()

# 🔹 BAR GRAPH: Monthly Revenue
ggplot(monthly_sales, aes(x = month, y = total_revenue, fill = month)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Monthly Revenue Comparison",
    x = "Month",
    y = "Total Revenue"
  ) +
  theme_minimal()

