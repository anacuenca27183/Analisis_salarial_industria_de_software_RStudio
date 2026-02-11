#====================================================#
# Proyecto: Análisis salarial en la Industria Tech   #
# Fecha: 10/02/2026                                  #
# Autora: Mtra. Ana Cuenca San Juan                  #
#====================================================#

# Limpieza inicial de consola ----

rm(list = ls())

# Condicional de existencia de pacman ----

if(require("pacman", quietly = T)){
  cat("El paquete de pacman se encuentra instalado")
} else{
  install.packages("pacman", dependencies = T)
}

# Llamado e instalación de paquetes ----

pacman::p_load(
  "tidyverse",
  "dplyr",
  "tseries",
  "readxl",
  "openxlsx",
  "haven",
  "foreign",
  "lubridate",
  "cowplot",
  "png",
  "grid",
  "magick",
  "ggtext",
  "extrafont",
  "scales"
)

# Carga de la base de datos y revisión general ---

datos <- read.csv("Bases de datos/survey_results_public.csv")

glimpse(datos)


# Filtrado de base y renombrado de columnas ---

datos_l <- datos %>% 
  select(ConvertedCompYearly,Country, DevType, EdLevel, WorkExp, RemoteWork, Industry) %>% 
  rename(
    Salario = ConvertedCompYearly,
    País= Country, 
    Puesto = DevType,
    Nivel_ed = EdLevel, 
    Experiencia = WorkExp, 
    Modalidad= RemoteWork,
    Industria = Industry)


glimpse(datos_l)

# Resumen de méticas principales de la base filtrada --- 

datos_l %>% 
  summary(datos_1)

datos_l %>% 
  select(Salario, País, Puesto, Nivel_ed, Experiencia, Modalidad, Industria) %>% 
  summarise(across(everything(), ~ sum(is.na(.))))


# Analisis general del salario --- 

datos_l %>% 
  select(Salario) %>% 
  summary(Salario)

# Histograma del salario con outliers ----

datos_l %>% 
  filter(is.finite(Salario)) %>%
  ggplot(aes(x=Salario,))+
  geom_histogram(bins = 40, 
                 fill = "#003247")+
  labs(title = "Histograma del salario anual (USD)",
       subtitle = "Con outliers",
       caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
       x = "Salario",
       y= "Frecuencia")+
  scale_x_continuous(labels = dollar_format(prefix = "$",
                                            big.mark = ","))+
  scale_y_continuous(labels = comma)+
  theme_gray()


# Aplicación del método IQR Tukey ---- 

## Filtrar los NA de la variable salario

datos_s <- datos_l %>% 
  filter(!is.na(Salario))


Q1 <- quantile(datos_s$Salario, 0.25)
Q3 <- quantile(datos_s$Salario, 0.75)
IQR <- Q3 - Q1

lim_inf <- Q1 - 1.5 * IQR
lim_sup <- Q3 + 1.5 * IQR

Q1 
Q3 
IQR
lim_inf
lim_sup


datos_sf <- datos_s %>% 
  filter(Salario <= lim_sup)

summary(datos_sf$Salario)

# Graficado del salario ---

## Histograma del salario anual sin outliers ---

ggplot(datos_sf, aes(x=Salario))+
  geom_histogram(bins = 40, fill = "#003247", color="white")+
  labs(title = "Histograma del salario anual (USD)",
       subtitle = "Sin outliers",
       caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
       x = "Salario",
       y= "Frecuencia")+
  scale_x_continuous(labels = dollar_format(prefix = "$",
                                            big.mark = ","))+
  scale_y_continuous(labels = comma)+
  theme_gray()


## Boxplot del salario anual sin outliers ---

ggplot(datos_sf, aes(y=Salario))+
  geom_boxplot(fill="#003247", color="white")+
  labs(title= "Diagrama de caja del salario anual (USD)",
       subtitle = "Sin outliers",
       caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
       y = "Salario")+
  scale_y_continuous(labels = dollar_format(prefix = "$",
                                            big.mark = ","))+
  theme_gray()

# ANALISIS POR FACTORES (PAÍS, TIPO DE PUESTO, NIVEL EDUCATIVO, AÑOS DE EXP., MODALIDAD E INDUSTRIA ---

# 1. SALARIOS POR PAÍS --- 

salario_pais <- datos_sf %>% 
  select(País, Salario) %>% 
  filter(!is.na(Salario), !is.na(País)) %>% 
  mutate(País = recode(País,
                          "United Kingdom of Great Britain and Northern Ireland"=
                            "UK"),
         País= recode(País,
                "United States of America"=
                  "USA")) %>% 
  group_by(País) %>% 
  summarise(
    n = n(),
    sal_prom = mean(Salario),
    sal_med = median(Salario),
    sal_sd = sd(Salario)) %>% 
  arrange(desc(sal_med))

salario_pais


salario_top15 <- salario_pais %>% 
  arrange(desc(sal_med))%>% 
  slice(1:15)
  
ggplot(salario_top15, aes(x = reorder(País, sal_med), 
                         y = sal_med)) +
  geom_point(size = 3, color = "#003247") +
  coord_flip() +
  labs(
    title = "Top 15 países con la mediana salarial más alta (USD)",
    subtitle = "Sin outliers",
    caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
    x = "País",
    y = "Salario"
  ) +
  scale_y_continuous(labels = dollar_format(prefix = "$", 
                                            big.mark = ","))+
  theme_gray()

#Grafica del top 15 países con menor mediana salarial ---


salarios_last_15 <- salario_pais %>% 
  arrange(desc(sal_med)) %>% 
  slice(149:164)


ggplot(salarios_last_15, aes(x=reorder(País, sal_med),
                             y = sal_med))+
  geom_point(size=3,  color= "#003247")+
  coord_flip()+
  labs(
    title="Los 15 países con mediana salarial más baja (USD)",
    subtitle = "Sin outliers",
    caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
    x= "País",
    y= "Salario"
  )+
  scale_y_continuous(labels = dollar_format(prefix = "$",
                                            big.mark = ","))+
  theme_gray()


# 2. Salarios por tipo de puesto del desarrollador ---


datos_puesto <- datos_sf %>% 
  select(Puesto, Salario) %>% 
  filter(!is.na(Salario), !is.na(Puesto))

head(datos_puesto)

salario_puesto <- datos_puesto %>% 
  group_by(Puesto) %>% 
  summarise(
    n = n(),
    sal_prom_d = mean(Salario),
    sal_med_d = median(Salario),
    sd_d = sd(Salario)) %>% 
  arrange(desc(sal_med_d))

salario_puesto

ggplot(salario_puesto, aes(x = reorder(Puesto, sal_med_d), 
                           y = sal_med_d)) +
  geom_point(size = 3, color = "#003247") +
  coord_flip() +
  labs(
    title = "Mediana salarial por tipo de puesto (USD)",
    subtitle = "(Sin outliers, ordenados de mayor a menor)",
    caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
    x = "Tipo de puesto",
    y = "Salario"
  ) +
  scale_y_continuous(breaks = seq(0, 120000, by=20000),
    labels = dollar_format(prefix = "$", 
                                            big.mark = ","))+
  theme_gray()

# Boxplot del salario por tipo de puesto ----

ggplot(datos_sf, aes(x= reorder(Puesto, Salario),
                     y=Salario))+
  geom_boxplot(fill= "#00B2FF", alpha=0.5, color="black")+
  coord_flip()+
  scale_y_continuous(labels = dollar_format(prefix = "$"),
                     breaks = seq(0, 260000, by=20000))+
  labs(title = "Diagrama de cajas del salarial por tipo de puesto (USD)",
       subtitle = "Sin outliers",
       caption= "Fuente. Encuesta anual para desarrolladores Stack Overflow. (2025)",
       x= "Tipo de puesto",
       y= "Salario")

unique(datos_sf$Puesto)


# 3. Salarios por nivel educativo ----

datos_edu <- datos_sf %>% 
  select(Nivel_ed, Salario) %>% 
  filter(!is.na(Nivel_ed), !is.na(Salario))

salario_edu <- datos_edu %>%
  mutate(
    Nivel_ed = recode(
      Nivel_ed, "Secondary school (e.g. American high school, German Realschule or Gymnasium, etc.)" =
      "Secondary school"))%>%
  mutate(
    Nivel_ed= recode(
      Nivel_ed, "Other (please specify):"="Other")) %>% 
  group_by(Nivel_ed) %>% 
  summarise(
    n = n(),
    salario_edu_prom = mean(Salario),
    salario_edu_med = median(Salario),
    salario_edu_sd = sd(Salario)) %>% 
  arrange(desc(salario_edu_med))

salario_edu


ggplot(salario_edu, aes(x=reorder(Nivel_ed, salario_edu_med),
                        y = salario_edu_med))+
  geom_point(size = 3, color = "#003247")+
  coord_flip()+
  labs(
    title= "Mediana salarial por nivel educativo (USD)",
    subtitle = "Sin outliers",
    caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
    x = "Nivel educativo",
    y = "Salario") +
  scale_y_continuous(labels = dollar_format(prefix = "$",
                                            big.mark = ","))+
  theme_gray()

# 4. Salario por años de experiencia --- 

summary(datos_sf$Experiencia)

datos_exp <- datos_sf %>% 
  select(Experiencia, Salario) %>% 
  filter(!is.na(Experiencia),
         !is.na(Salario),
         Experiencia >= 0,
         Experiencia <=50)

summary(datos_exp$Experiencia)


salario_exp <- datos_exp %>% 
  group_by(Experiencia) %>% 
  summarise(
    n = n(),
    sal_exp_prom = mean(Salario),
    sal_exp_med = median(Salario),
    sal_exp_sd = sd(Salario)) %>%
  arrange(desc(Experiencia))
  
salario_exp


## Grafica de acuerdo con la mediana salarial según experiencia ----

ggplot(salario_exp, aes(x=Experiencia, y=sal_exp_med))+
  geom_line(linewidth = 1.2, color ="#003247")+
  geom_point(size = 3, color = "#0092D1")+
  labs(
    title= "Relación entre años de experiencia y mediana salarial (USD)",
    subtitle = "Sin outliers",
    caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
    x= "Años de experiencia",
    y = "Salario"
  )+
  scale_x_continuous(breaks = seq(0, 50, by=5))+
  scale_y_continuous(breaks = seq(0, 140000, by= 20000),
    labels = dollar_format(prefix = "$",
                                            big.mark = ","))+
  theme_gray()


# 5. Salario por modalidad laboral ----

datos_mod <- datos_sf %>% 
  select(Modalidad, Salario) %>% 
  filter(!is.na(Modalidad),
         !is.na(Salario)) 
  

head(datos_mod)

salario_mod <- datos_mod %>%
  mutate(
    Modalidad =case_when(
      Modalidad == "Remote" ~ "Remoto",
      Modalidad == "Hybrid (some in-person, leans heavy to flexibility)" ~ "Hibrido, tendencia a flexible",
      Modalidad == "Hybrid (some remote, leans heavy to in-person)" ~ "Hibrido,  tendencia a presencial",
      Modalidad == "Your choice (very flexible, you can come in when you want or just as needed)" ~ "Libre elección",
      Modalidad == "In-person" ~ "Presencial",
      TRUE ~ as.character(Modalidad)
    ))%>% 
  group_by(Modalidad) %>% 
  summarise(
    n = n(),
    salario_mod_prom = mean(Salario),
    salario_mod_med = median(Salario),
    salario_mod_sd = sd(Salario)) %>% 
  arrange(desc(salario_mod_med))

salario_mod

# Grafica salario por modalidad laboral 

ggplot(salario_mod, 
       aes(x= reorder(Modalidad, salario_mod_med),
           y= salario_mod_med))+
         geom_point(size = 4, color= "#003247")+
         coord_flip()+
         labs(
           title = "Mediana salarial por modalidad laboral (USD)",
           subtitle = "Sin outliers",
           caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
           x= "Modalidad",
           y= "Salario")+
         scale_y_continuous(labels = dollar_format(prefix = "$",
                                                   big.mark = ","),
                            breaks = seq(0, 100000, by=10000))+
         theme_grey()

# Boxplot del salario por modalidad laboral *** REVISAR ***

unique(datos_mod_etiquetas$Modalidad)


datos_mod_etiquetas <- datos_sf %>%
  filter(!is.na(Modalidad)) %>% 
  mutate(
    Modalidad =case_when(
      Modalidad == "Remote" ~ "Remoto",
      Modalidad == "Hybrid (some in-person, leans heavy to flexibility)" ~ "Híbrido, tendencia a flexible",
      Modalidad == "Hybrid (some remote, leans heavy to in-person)" ~ "Híbrido,  tendencia a presencial",
      Modalidad == "Your choice (very flexible, you can come in when you want or just as needed)" ~ "Libre elección",
      Modalidad == "In-person" ~ "Presencial",
      TRUE ~ as.character(Modalidad)
    ))
  
  
  

ggplot(datos_mod_etiquetas, aes(x= reorder(Modalidad, Salario),
                      y= Salario,
                      fill= Modalidad))+
  geom_boxplot(alpha = 0.7)+
  scale_y_continuous(labels = scales::dollar_format(prefix = "$",
                                              big.mark = ","),
                                              breaks= seq(0, 250000, by=20000))+
  scale_fill_manual(values=c("#003247", "#005275", "#0072A3", "#0092D1", "#00B2FF"))+
  labs(
    title = "Diagrama de cajas del salario según modalidad laboral (USD)",
    subtitle = "Sin outliers",
    caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
    x= "Modalidad laboral",
    y= "Salario"
  )+
  theme_gray()+
  theme(legend.position = "none")

# Salario por Industria ----

datos_ind <- datos_sf %>% 
  select(Industria, Salario) %>% 
  filter(!is.na(Industria),
         !is.na(Salario))

salarios_ind <- datos_ind %>% 
  group_by(Industria) %>% 
  summarise(
    n = n(),
    salarios_ind_prom = mean(Salario),
    salarios_ind_med = median(Salario),
    salarios_ind_sd = sd(Salario)) %>% 
      arrange(desc(salarios_ind_med))


salarios_ind


## Grafica: Salarios por tipo de industria ---

ggplot(salarios_ind, aes(reorder(Industria, salarios_ind_med),
                         y = salarios_ind_med))+
  geom_point(size= 4, color = "#003247")+
  coord_flip()+
  labs(title = "Mediana salarial por tipo de insdustria (USD)",
       subtitle = "Sin outliers",
       caption= "Fuente. Encuesta Anual para Desarrolladores Stack Overflow. (2025)",
       x = "Industria",
       y = "Salario")+
  scale_y_continuous(labels = dollar_format(prefix = "$",
                                            big.mark = ","),
                     breaks = seq(55000, 150000, by=5000))+
  theme_gray()



## Boxplot salario por tipo de industria 


unique(datos_sf$Industria)

datos_ind_filtrados <- datos_sf %>% 
  filter(!is.na(Industria)) %>% 
  mutate(
    Industria =case_when(
      Industria == "Banking/Financial Services" ~ "Financial Services",
      Industria == "Transportation, or Supply Chain"~ "Transportation/Supply Chain",
      Industria == "Internet, Telecomm or Information Services"~ "Internet/Telecomm/Information Services",
      TRUE ~ as.character(Industria)))

unique(datos_ind_filtrados$Industria)

ggplot(datos_ind_filtrados, aes(x= reorder(Industria, Salario),
                                y= Salario))+
  coord_flip()+
  geom_boxplot(fill= "#0092D1", alpha = 0.7)+
  scale_y_continuous(labels = scales::dollar_format(prefix = "$",
                                                    big.mark = ","),
                     breaks = seq(0, 250000, by=20000))+
  labs(
    title = "Diagrama de cajas del salario por sector industrial (USD)",
    subtitle = "Sin outliers",
    caption= "Fuente. Encuesta anual para desarrolladores Stack Overflow. (2025)",
    x= "Modalidad laboral",
    y= "Salario"
  )+
  theme_gray()


# Fin ---







