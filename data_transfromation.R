library("readr")
install.packages("dplyr")

## read csv file into Rstudio
imdb <- read_csv("imdb.csv")

## review data structure
glimpse(imdb)

## print head and tail of data
head(imdb,10)
tail(imdb,10)

## select columns
select(imdb, MOVIE_NAME, RATING)
select(imdb,1,5)

select(imdb, movie_name = MOVIE_NAME, released_year = YEAR)

## pipe operator
imdb %>% 
  select (movie_name = MOVIE_NAME, released_year = YEAR) %>%
  head(10)

## filter Data
filter(imdb, SCORE >= 9.0)

imdb %>% filter(SCORE >= 9.0)

## lower col names
names(imdb) <- tolower(names(imdb))

imdb %>%
  select(movie_name, year, score)%>%
  filter(score >= 9 & year > 2000)

imdb %>%
  select(movie_name, length, score) %>%
  filter(score == 8.8 | score == 8.3)

imdb %>%
  select(movie_name, length, score) %>%
  filter(score %in% c(8.3,8.8,9.0))

##filter string in columns
imdb %>% 
  select(movie_name, genre, rating) %>%
  filter(grepl("Drama", imdb$genre))

## create new columns
imdb %>%
  mutate(score_group = if_else(score >= 9, "High Rating", "Low Rating"),
         length_group = if_else(length >= 120, "Long Film", "Short Film"))

imdb %>%
  select(movie_name, score) %>%
  mutate(score = score + 0.1) %>%
  head(10)

## Arrange Data
head(imdb)

imdb %>% 
  arrange(desc(length)) %>% 
  head(10)

imdb %>% 
  arrange(rating,desc(length))

## Summarise and group_by
imdb %>%
  filter(rating != "") %>% 
  group_by(rating) %>% 
  summarise(mean_length = mean(length),
            sum_length = sum(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length),
            n = n())

## Join data

favourite_films <- data.frame(id = c(5,10,25,30,98))

favourite_films %>% 
  inner_join(imdb, by = c("id" = "no"))


## Write csv file (export result)
imdb_prep <- imdb %>% 
  select(movie_name, released_year = year, rating, length, score) %>% 
  filter(rating == "R" & released_year > 2000)

## export file
write_csv(imdb_prep,"imdb_prep.csv")










































