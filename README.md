# Analisis salarial de la industria tecnológica 2025

## Resumen del proyecto

### Objetivo principal: 
El objetivo es comprender cómo varían los salarios según: el país, tipo de puesto, nivel educativo, años de experiencia, modalidad laboral e industria.

### Objetivos secundarios:
1. Explorar la distribución general del salario de la industria tecnológica.
2. Comparar salarios por país y evaluar posibles brechas regionales.
3. Estudiar diferencias salariales por tipo de puesto del desarrollador.
4. Analizar la relación entre nivel educativo y salario.
5. Examinar el impacto de la experiencia laboral en el salario.
6. Evaluar los salarios por industria y modalidad laboral.

## Sobre la base de datos de Stack Overflow:

Encuesta anual para desarrolladores del 2025 de Stack Overflow, presenta una visualización de las necesidades de la comunidad global de desarrolladores. En esta quinta edición se registraron más de 49,000 respuestas de 177 países y un nuevo enfoque en herramientas de Inteligencia Artificial, LLM y plataformas comunitarias.

Se Compuesta de sesenta y dos preguntas, se centra en cinco temas:
1. Perfil de los desarrolladores (edad, país de origen, educación, experiencia, tipo de empleo, etc.)
2. Tecnología (lenguaje de programación, desarrollo en la nube, tecnologías web, etc.)
3. Inteligencia Artificial (sentimiento y uso, herramientas para desarrolladores, agentes de IA)
4. Trabajo (salario, situación laboral, información de la empresa, modalidad laboral, etc.)
5. Uso del sitio Stack Overflow (cuenta activa, antigüedad, frecuencia de visita, etc.)

Liga de consulta: [Consulta aquí](https://survey.stackoverflow.co/) 

## Descripción del proyecto:

Tipo de investigación: Cuantitativa, enfocada a medir, evaluar tendencias y realizar reportes. Se centra en los datos duros e información que pueda contabilizarse. 

Tipo de análisis: Exploratorio: A fin de conocer las relaciones entre el salario y el país, tipo de puesto del desarrollador, nivel educativo, años de experiencia, modalidad laboral e industria se examinó la información para identificar patrones, formular algúnas hipótesis para proyectos futuros y la propuesta de alternativas para resolver problemas específicos. 

## Herramienta de análisis de datos utilizado: 

RStudio: Elegida por su precisión estadística y gráficos potentes. 

Librerías utilizadas:
* dplyr
* ggplot2
* tidyr
* readr
  
## Metodología implementada: 

A fin de asegurar que el análisis sea ordenado, confiable, reproducible y efectivo se eligió la metodología tradicional del análisis de datos, la cual, en general, se compone de las siguientes etapas:

* Definición del problema
* Carga de datos
  * Selección de variables relevantes
* Inspección, limpieza y preparación de la base:
  * Eliminación de na,
  * Outliers (Método Tukey),
  * Datos inválidos,
  * Homogenización de la base de datos y
  * Estandarización de categorías
* Análisis exploratorio de datos (EDA)
  * Histogramas
  * Boxplots
  * Density plot
  * Análisis de asimetría y outliers
  * ANOTAR LAS PREGUNTAS A RESPONDER... 
* Aplicación de técnicas estadísticas o modelos
* Interpretación y comunicación de resultados

## Analisis de datos: 


1. Carga de base de datos y revisión general.

*** IMAGEN ***

- Las variables tienen el formato correcto.
- Los nombres de las variables están homologadas, es decir, no hay presencia de etiquetas atípicas
- Hay presencia de "NA" en la base
- Hay presencia de datos atípicos que cesgan el promedio, específicamente en la variable salario, con valores cercanos a los 50,000,000 USD
- Hay existencia de datos ilógicos, específicamente en años de experiencia, se indica que hay valores cercanos a los 100 años

Los detalles presentes en la base de datos se irán corrigiendo conforme se avance en el análisis a fin de adaptar las modificaciones a cada variable.

# 1.1 Analisis general del salario.

** IMAGEN HISTOGRAMA CON OUTLIERS Y SUMMARY **

De acuerdo con la revisión de las metricas de tendencia central y del histograma, hay presencia de datos extremos que están cesgando la media. El 75% de los encuestados ganan menos de 120,596 USD, sin embargo, el valor máximo mostrado es de 50,000,000 USD. Los datos extremos del salario están generándo que la media sea alrededor de 101 mil USD, mientras que la mediana es de 75 mil USD. Por lo que se requiere aplicar el método IQR de Tukey, útil para definir los límites inferior y superior a partir de los cuales un valor se considera outlier.

** IMAGEN **
Como puede observarse el primer cuartil es igual a 38,171 USD y el tercer cuartil igual a 120,596 USD, dando como resultado un IQR igual a 82,425 USD. El cual nos permite definir los limites inferior y superior:

limite inferior = -85,465 USD (no relevante ya que no hay salarios negativos)
limite superior = 244,233 USD (salarios superiores a este valor se considerarán como outliers y serán eliminados)


*** IMAGEN HISTOGRAMA SIN OUTLIERS ****


Aplicando el tratamiento anterior la nueva media es de 71,929 USD y la mediana de 79,574, reduciendo así la diferencia entre ambas y generando una base de datos más homogenea para el analisis (vease la gráfica de arriba). A pesar del tratamiento, existe un sesgo a la derecha, ya que típicamente los salarios se comportan de esta forma, es decir, mucha gente gana salarios bajos o medianos y poca gente gana salarios altos. 

# 1.2 Analisis por factores (País, Tipo de puesto, Nivel educativo, Años de experiencia, Modalidad e Industria. 


## 1.2.1 Analisis por país

Primero se define la nueva base de datos para eliminar NA de las variables a utilizar, posteriormente se definen las métricas a evaluar (promedios y medias del salario por país) y finalmente se genera la gráfica (se eligió la mediana para representar al trabajador "tipico" ya que este dato no se ve afectado ante rangos extremos). Sin embargo, cabe mencionar que este top tiene sus limitaciones, ya que la muestra para generar las medidas de tendencia central varía en gran medida, hay datos con n=1, hasta datos con n= 4,487. 

*** Anexar gráfica del top de 15 paises con mediana salarial más alta) ***

Cómo puede observarse los países mejor pagados son Suiza (136,392 USD), EE.UU.AA. (136,000 USD) e Israel (132,470 USD). La mayoría de salarios altos se encuentran en países europeos con medias salariales que rondan entre los 88,900 USD y los 136,00 USD. 


*** Anexar gráfica del top de 15 países con mediana salarial más baja) ***

Por otro lado, los 15 peores países pagados son La República Democrática de la Gente de Laos, Micronesia y Antigüa y Barbuda, con medias salariales de 1 USD (datos que podrían deberse a errores de captura). Asimismo, la mayoría de salarios corresponde a países que se encuentran en África, con medias salariales que rondan entre 1 USD y 2,822 USD. 

## 1.2.2 Analisis por tipo de puesto 

*** Anexar imagen mediana salarial por tipo de puesto ***


Las tres medianas salariales más altas son: gerente de ingeniería (116,015 USD), ejecutivo sénior (112,997 USD) y arquitecto de software o soluciones (96,000 USD). Las tres medianas salariales más bajas son: investigador académico (51,447.14), retirado (40,063.5 USD) y estudiante (7,948 USD). En este sentido el nivel de especialización y experiencia jugarían un papel clave para un aumento salarial, puestos en dónde se requiere de mayor responsailidad, conocimiento, experiencia y uso de herramientas tecnológicas más especializadas son los que tienen mayores salarios. No obstante, la media salarial de entrada al mercado laboral es de más de 7 mil USD. 

*** Anexar Bloxplot de la distribución salarial por tipo de puesto ***

Por otro lado, la gráfica de cajas nos muestra el grado de distribución de cada puesto, se ordenaron de mayor a menos salario. En este sentido, no hay mucha diferencia con los mejor y peor pagados señalados en la gráfica anterior, pero si podemos observar que aquellas boxplots más "anchas" muestran mayor diversidad en los salarios, por ejemplo: el ingeniero o analista financiero (con salarios entre los 20,000 USD y casi los 140,000 USD aprox.), ingeniero en Machine Learning e Intaligencia Artificial ( con salarios entre más de 20,000 USD y los 135,000 USD aprox.) y Ejecutivo Senior (con salarios entre los 40,000 USD y cerca de 170,000 USD aprox.). Por otro lado, los boxplots más "cortos" muestran menor diversidad salarial, por ejemplo: estudiantes (con sueldos por debajo de los 25,000 USD aprox.), investigadores académicos (entre 25,00 USD y los 65,000 USD aprox.), administrador de sistema (con sueldos entre los 25,00 USD y los 80,000 USD aprox.)

Además, hay puestos con una gran presencia de datos extremos (puntos a la derecha de la caja), por ejemplo: desarrollador back-end, desarrollador full-stack, desarrollador front-end y estudiantes, lo que podría sugerir oportunidades lucrativas para ganar salarios mayores. Algo notorio es que, los puestos con salarios más altos no presentan tantos datos extremos, como el resto. En cuanto a la distribución de la media en general es equilibrada (heterogeneidad en nivel central), lo que no sugiere que haya un sesgo hacia mayores salarios en los puestos (salvo en casos como: el analista o ingeniero financiero y cientifico aplicado). 


## 1.2.3 Análisis por nivel educativo

*** Anexar imagen de la gráfica de mediana salarial por nivel educativo ***


Como puede observarse en la gráfica anterior, el nivel educativo influye positivamente en el nivel de ingreso, es decir aquellos empleados con doctorado, maestría o titulo universitario son los que reciben mayores sueldos (la mediana salarial se encuentra entre 75,000 USD y cerca de 90,000 USD). Esto podría relacionarse con los salarios por tipo de puesto en dónde al tener mayor especialización y roles con habilidades específicas se gana un sueldo mayor. Por otro lado, aquellos que cuentan con nivel secundaria, otros y primaria tienen sueldos menores a los 50,000 USD. Por lo que se sugeriría a los interesados en trabajar en la industria tecnológica continuar con su formación y especialización, especialmente en aquellas áreas con mayores salarios (Nube, Ciberseguridad, Machine Learning e IA). 

## 1.2.4 Análisis por años de experiencia 

Dentro del análisis de la variable años de experiencia se encontraron datos con 100 años de experiencia, estos datos se consideran como errores en su captura, ya que la media de años de experiencia es de 13.45, el promedio de 11 y el 75% de los encuestados cuentan con 20 o menos años de experiencia laboral. Para corregir estas inconsistencias, establecerémos como tope realista de 50 años de experiencia, así una persona que empezó a laborar a los 15 podría tener 65 años en la actualidad y seguir trabajando o encontrarse retirado pero laborando. Esta corrección no tuvo gran impacto en las medidas de tendencia central, pero sí ofrece una visión realista del panorama laboral. 



*** Anexar gráfico de mediana salarial por años de experiencia *** 

Enla gráfica podemos observar que a medida que la experiencia aumenta, también lo hace la mediana salarial. Así la práctica y la especialización progresiva aportan un valor significativo al perfil profesional. Los primeros 10 años muestran un aumento salarial rápido pasándo de salarios de 20,000 USD hasta salarios cercanos a los 80,000 USD. Posteriormente, entre los 10 y 15 años de experiencia, el crecimiento salarial continúa pero a un ritmo más moderado y con fluctuaciones, teniendo salarios de 80,000 USD hasta salarios cercanos a los 90,000. Sin embargo, a partir de los 20 años de experiencia el salario comienza a estabilizarse e incluso puede mostrar desaceleración, manteniendo salarios entre los 90,000 USD y los 120,000 USD. Esto sugiere que, en la industria tecnológica, el mayor impacto salarial se obtiene durante los primeros años de carrera, mientras que después de cierto punto el incremento se suaviza y se mantiene. No obstante, entre los 45 y los 50 años de experiencia se presentan variaciones interesantes, hay medianas salariales de 75,000 USD aprox. pero tambi+en salarios cercanos a los 140,000 USD, esto podría deberse a situaciones en las que las personas eligen retirarse "formalmente" del trabajo y realizan labores eventuales (salarios bajos) o a puestos Senior o Expert (salarios altos).  


## 1.2.5 Análisis por modalidad laboral *** 

* Codigo
* Visualizaciones 



