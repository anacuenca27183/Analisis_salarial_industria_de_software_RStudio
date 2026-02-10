# Analisis salarial de la industria tecnológica - 2025

## Resumen del proyecto

### Objetivo principal: 

Comprender cómo varían los salarios de los desarrolladores según: el país, tipo de puesto, nivel educativo, años de experiencia, modalidad laboral e industria.

### Objetivos secundarios:
1. Explorar la distribución general del salario en el sector tecnológico.
2. Comparar salarios por país y evaluar brechas regionales.
3. Analizar diferencias salariales por tipo de puesto del desarrollador.
4. Evaluar la relación entre nivel educativo y salario.
5. Examinar el impacto de la experiencia laboral en los ingresos.
6. Estudiar el comportamiento salarial por modalidad laboral e industria.

## Sobre la base de datos de Stack Overflow:

La **Ecuesta Anual para Desarrolladores 2025** de Stack Overflow, recopila información sobre las tendencias, herramientas y condiciones laborales de la comunidad global de desarrolladores. En esta edición se registraron más de 49,000 respuestas de 177 países, con un nuevo enfoque en herramientas de Inteligencia Artificial, modelos de lenguaje y plataformas comunitarias.

La encuesta consta de 62 preguntas distribuidas en cinco ejes temáticos:

1. **Perfil del desarrollador:** edad, país de origen, educación, experiencia, tipo de empleo, etc.
2. **Tecnología:** lenguaje de programación, desarrollo en la nube, tecnologías web, etc.
3. **Inteligencia Artificial:** sentimiento y uso, herramientas para desarrolladores, agentes de IA, etc.
4. **Trabajo:** salario, situación laboral, información de la empresa, modalidad laboral, etc.
5. **Uso del sitio Stack Overflow:** cuenta activa, antigüedad, frecuencia de visita, etc.

Fuente oficial: [Stack Overflow Survey](https://survey.stackoverflow.co/) 

## Descripción del proyecto:

**Tipo de investigación:**

Cuantitativa, enfocada a medir tendencias y analizar los datos objetivos para elaborar reportes y proponer hipótesis futuras.

**Tipo de análisis:**

Exploratorio (EDA). Tiene como fin identificar patrones y relaciones entre el salario y distintas variables (país, tipo de puesto del desarrollador, nivel educativo, años de experiencia, modalidad laboral e industria).

## Herramientas utilizadas: 

RStudio: Elegida por su precisión estadística y gráficos potentes. 

Librerías principales:
* dplyr
* ggplot2
* tidyr
* readr
* dplyr
* scales
  
## Metodología implementada: 

A fin de asegurar que el análisis sea ordenado, reproducible y tecnicamente confiable, se eligió la metodología tradicional del análisis de datos, con las siguientes etapas:

1. Definición del problema
* Carga de datos
  * Selección de variables relevantes
2. Inspección, limpieza y preparación:
  * Eliminación de valores faltantes (NA)
  * Detección y tratamiiento de outliers mediante el **método de Tukey**
  * Depuración de datos inválidos
  * Homogenización y estandarización de categorías
3. Análisis exploratorio de datos (EDA)
  * Histogramas y distribuciones
  * Boxplots comparativos
  * Análisis de asimetría, dispersión y outliers 
4. Aplicación de técnicas estadísticas
5. Interpretación y comunicación de resultados
  * Redacción final del análisis, visualización y conclusiones

## Resultados principales : 


1. Carga de base de datos y revisión general.

<img width="785" height="422" alt="1" src="https://github.com/user-attachments/assets/2f234211-4333-425a-b89f-ab62e7ac0e50" />


- Las variables tienen el formato adecuado.
- Hay que modificar los nombres de las columnas a fin de facilitar su manejo.
- Se observa presencia de datos faltantes ("NA").
- Existen datos atípicos que cesgan distorcionan las medidas de tendencia central, especialmente en la variable salario, donde se registran montos cercanos a los 50,000,000 USD.
- También se detectan valores ilógicos, como años de experiencia cercanos a 100 años.

Estos problemas se corregirán de forma progresiva, adaptando los tratamientos según lo requieran las características de cada variable.

# 1.1 Analisis general del salario.


<img width="940" height="497" alt="2 histograma del salario anual con outliers" src="https://github.com/user-attachments/assets/96282017-264c-4f44-8358-9a94462b314c" />

 
<img width="361" height="202" alt="3 summary salario" src="https://github.com/user-attachments/assets/381e124e-5bbe-420b-b2e4-304e26959068" />


El análisis del histograma y de las métricas de tendencia central revela la presencia de valores extremos que distorcionan la media. el 75% de los encuestados reporta ingresos menores a 120,596 USD; sin embargo, el salario máximo alcanza 50,000,000 USD. Estos valores extremos elevan la media a ~101,000 USD, mientras que la mediana se mantiene en 75,000 USD. Para mitigar este efecto, se aplica el método IQR de Tukey, que permite definir límites interior y superior a partir de los cuartiles:  

* **Q1:** 38,171 USD
* **Q3:** 120,596 USD
* **IQR:** 82,425 USD

Con ello se obtienen los límites:

* **Límite inferior:** –85,465 USD (irrelevante, pues no existen salarios negativos)
* **Límite superior:** 244,233 USD (valores superiores se consideran outliers y se eliminan)

<img width="940" height="497" alt="4 histograma del salario anual" src="https://github.com/user-attachments/assets/83e6bb63-cb50-46e4-9d5e-fd3b37abdcf7" />

<img width="940" height="497" alt="5 diagrama de caja del salario anual" src="https://github.com/user-attachments/assets/90b867fc-6432-47ff-8256-5353afe64ac2" />


Tras el tratamiento, la nueva media se reduce a 71,929 USD y la mediana aumenta ligeramente a 79,574 USD, reduciendo la brecha entre ambas y generando una distribución más homogénea. No obstante, el salario conserva un sesgo positivo, típico de este tipo de variables: la mayoría de personas gana salarios bajos o medianos y pocos individuos reportan salarios altos (obvservese el histograma y el diagrama de caja).

# 1.2 Analisis por factores 

**(País, Tipo de puesto, Nivel educativo, Años de experiencia, Modalidad e Industria)**
---
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


Nota: Las observaciones con valores faltantes en la variable “Puesto” fueron descartadas automáticamente por ggplot2 durante la generación del boxplot. Esto no afecta el cálculo de la distribución salarial por categoría, pero sí reduce el número total de casos considerados para el análisis.

## 1.2.3 Análisis por nivel educativo

*** Anexar imagen de la gráfica de mediana salarial por nivel educativo ***


Como puede observarse en la gráfica anterior, el nivel educativo influye positivamente en el nivel de ingreso, es decir aquellos empleados con doctorado, maestría o titulo universitario son los que reciben mayores sueldos (la mediana salarial se encuentra entre 75,000 USD y cerca de 90,000 USD). Esto podría relacionarse con los salarios por tipo de puesto en dónde al tener mayor especialización y roles con habilidades específicas se gana un sueldo mayor. Por otro lado, aquellos que cuentan con nivel secundaria, otros y primaria tienen sueldos menores a los 50,000 USD. Por lo que se sugeriría a los interesados en trabajar en la industria tecnológica continuar con su formación y especialización, especialmente en aquellas áreas con mayores salarios (Nube, Ciberseguridad, Machine Learning e IA). 

## 1.2.4 Análisis por años de experiencia 

Dentro del análisis de la variable años de experiencia se encontraron datos con 100 años de experiencia, estos datos se consideran como errores en su captura, ya que la media de años de experiencia es de 13.45, el promedio de 11 y el 75% de los encuestados cuentan con 20 o menos años de experiencia laboral. Para corregir estas inconsistencias, establecerémos como tope realista de 50 años de experiencia, así una persona que empezó a laborar a los 15 podría tener 65 años en la actualidad y seguir trabajando o encontrarse retirado pero laborando. Esta corrección no tuvo gran impacto en las medidas de tendencia central, pero sí ofrece una visión realista del panorama laboral. 


*** Anexar gráfico de mediana salarial por años de experiencia *** 

Enla gráfica podemos observar que a medida que la experiencia aumenta, también lo hace la mediana salarial. Así la práctica y la especialización progresiva aportan un valor significativo al perfil profesional. Los primeros 10 años muestran un aumento salarial rápido pasándo de salarios de 20,000 USD hasta salarios cercanos a los 80,000 USD. Posteriormente, entre los 10 y 15 años de experiencia, el crecimiento salarial continúa pero a un ritmo más moderado y con fluctuaciones, teniendo salarios de 80,000 USD hasta salarios cercanos a los 90,000. Sin embargo, a partir de los 20 años de experiencia el salario comienza a estabilizarse e incluso puede mostrar desaceleración, manteniendo salarios entre los 90,000 USD y los 120,000 USD. Esto sugiere que, en la industria tecnológica, el mayor impacto salarial se obtiene durante los primeros años de carrera, mientras que después de cierto punto el incremento se suaviza y se mantiene. No obstante, entre los 45 y los 50 años de experiencia se presentan variaciones interesantes, hay medianas salariales de 75,000 USD aprox. pero tambi+en salarios cercanos a los 140,000 USD, esto podría deberse a situaciones en las que las personas eligen retirarse "formalmente" del trabajo y realizan labores eventuales (salarios bajos) o a puestos Senior o Expert (salarios altos).  


## 1.2.5 Análisis por modalidad laboral *** 

REVISAR CON MÁS DETALLE

*** Anexar gráfica de salarios medios por modalidad laboral *** 

Los trabajos reomotos tienen la media salarial más alta (mayores a 80,000 USD), le sigue la modalidad hibrida (con tendencia a flexible) con salarios cercanos a los 80,000 USD. Aquellos trabajos de libre elección tienen una media salarial cercana a los 75,000 USD y los hibridos (con tendencia a presencial) cerca de los 70,000 USD. Algo muy notorio, es la diferencia existente con los salarios de modalidad presencial que son menores a los 45,000 USD. 

*** Anexar gráfica BOXPLOT  de salarios por modalidad laboral ***

Lo anterior se comprueba al visualizar la distribución salarial de cada modalidad laboral, la media del trabajo remoto es superior al resto, las opciones hibridas y libres en puntos intermedios y la presencial es la categoría con menor media salarial. Asimismo, podemos observar que el trabajo remoto tiene mayor variación salarial. El rango salarial central para la modalidad hibrida con tendencia a presencial se encuentra aproximadamente entre 40,000 USD y 105,000 USD, para hibrido con tendencia a flexible entre 45,000 USD y 115,000 USD aprox., para aquellos que trabajan con libre elección entre 45,000 USD y 110,000 USD aprox., para los que trabajan presencialmente entre 25,000 USD y 85,000 USD aprox. y los que trabajan en remoto los salarios pueden ir desde los 40,000 USD cerca de 140,000 USD aprox., aunque para cada categoría debe tenerse en cuenta los valores extremos que sugieren oportunidades laborales con mayores ingresos. 

Siguiendo con lo anterior, aunque se eliminaron los outliers de la variable salario (se realizó al inicio del analsis), las categorias hibridas, libre elección y presencial cuentan con personas con salarios significativamente más altos respecto al resto del grupo, es decir, existe mayor variabilidad salarial interna (que podría deberse a puestios senior), por otro lado, los puestos remotos no presentan valores extremos, lo que sugiere una distribución salarial más uniforme y consistente entre quienes trabajan completamente a distancia. 


## 1.2.6 Analisis por tipo de industria 

*** Anexar gráfica de salario promedio por tipo de industria *** 

Como puede observarse la industria mejor pagada es la de seguros con una media salarial mayor a los 95,000 USD anuales, le siquen el sector de tecnología, energia y salud con salarios superiores a los 85,000 USD y menores a los 88,000 USD aprox. (sectores relacionados con una alta demanda de perfiles técnicos y a una fuerte inversión en infraestructura digital, lo que contribuye a sus niveles salariales competitivos). Los dos sectores peor pagados son educación superior y desarrollo de software con salarios menores a los 67,500 USD, el resto de industrias se encuentra con salarios entre los 75,000 USD y los 82,500 USD aprox.

*** Anexar boxplot del salario por industria ****

A pesar de que la industria de seguros es la mejor pagada, su rango salarial no es tan amplio como en las industrias de tecnología y salud (lo que indica que las industrias pueden ofrecer oportunidades salariales más competitivas), sin embargo hay presencia de datos extremos en el sector de seguros que podrían indicar algunas oportunidades para ganar salarios más altos. Por otro lado, el sector energético, educación superior y transporte y cadenas de suministro tienen rangos salariales mas "cortos", aunque con mayor presencia de datos extremos, indicando posibles oportunidades con salarios mayores (aunque no forman parte de lo común en el sector).








* Codigo
* Visualizaciones 



