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

* Codigo
* Visualizaciones 



