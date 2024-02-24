

# Generate figure 1
ggplot() +
  geom_sf(data = chicago_ca_clean, alpha = .7) +
  geom_sf(data = target_area, fill = "#510C76") +
  ggtitle("Target Community \nAreas") +
  theme(
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_blank(), # Remove x-axis labels
    axis.text.y = element_blank(), # Remove y-axis labels
    axis.ticks = element_blank(), # Remove axis ticks
    panel.background = element_rect(fill = "white"), # Set background to white
    plot.title = element_text(face = "bold", size = 20) # Bold and larger title
  )

ggsave("figs/target_community_areas.png")

# Generate Figure 2
ggplot() +
  geom_sf(data = st_union(target_area)) +
  geom_sf(data = target_stations, color = "#510C76") +
  ggtitle("Target Stations") +
  theme(
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    axis.text.x = element_blank(), # Remove x-axis labels
    axis.text.y = element_blank(), # Remove y-axis labels
    axis.ticks = element_blank(), # Remove axis ticks
    panel.background = element_rect(fill = "white"), # Set background to white
    plot.title = element_text(face = "bold", size = 20, hjust = 0.5),
    plot.background = element_rect(fill = "white", color = NA),
    panel.border = element_rect(color = "black", fill = NA, size = 1)
  )

ggsave("figs/target_stations.png")




mase_df <- data.frame(Node = names(mase_per_node_h6), MASE = as.numeric(mase_per_node_h6)) %>% 
  arrange(desc(MASE))

# Plot
ggplot(mase_df, aes(x = reorder(Node, -MASE), y = MASE)) +
  geom_bar(stat = "identity", fill = "#510C76") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  labs(x = "Node", y = "MASE", title = "MASE per Node Horizon 6")

ggsave("figs/mase_per_node.png")


rmse_df <- data.frame(Node = names(rmse_per_node_h6), MASE = as.numeric(rmse_per_node_h6)) %>% 
  arrange(desc(MASE))

# Plot
ggplot(rmse_df, aes(x = reorder(Node, -MASE), y = MASE)) +
  geom_bar(stat = "identity", fill = "#510C76") +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  labs(x = "Node", y = "RMSE", title = "RMSE per Node Horizon 6") 

ggsave("figs/rmse_per_node.png")


