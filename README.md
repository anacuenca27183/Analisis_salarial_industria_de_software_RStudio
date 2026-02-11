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


Tras el tratamiento, la nueva media se reduce a 71,929 USD y la mediana aumenta ligeramente a 79,574 USD, generando así una distribución más homogénea. No obstante, el salario conserva un sesgo positivo, típico de este tipo de variables: la mayoría de personas gana salarios bajos o medianos y pocos individuos reportan salarios altos (obvservese el histograma y el diagrama de caja).

# 1.2 Analisis por factores 

**(País, Tipo de puesto, Nivel educativo, Años de experiencia, Modalidad e Industria)**

## 1.2.1 Analisis por país

Primero se depuraron los valores faltantes de las variables (lo que reduce la base de datos). Posteriormente, se calcularon medias y medianas salariales por país, eligiendo la mediana como métrica principal por su robustez frente a valores extremos. Es importante mencionar, que el tamaño muestral varía considerablemente entre países (desde n = 1 hasta n = 4,487), lo que introduce limitaciones interpretativas.

<img width="940" height="497" alt="6 top 15 paises con la mediana salarial mas alta sin outliers" src="https://github.com/user-attachments/assets/e6a3c3cb-f3d1-491b-8a57-a579ebfc821c" />

Cómo puede observarse los países con mayores medianas salariales son:
* **Suiza:** 136,392 USD
* **EE.UU.AA.:** 136,000 USD
* **Israel:** 132,470 USD

En general, los salarios más altas se encuentran en países europeos y norteamericanos, con medianas salariales entre los 88,900 y los 136,00 USD apróximadamente. 

<img width="940" height="497" alt="7 los 15 paises con mediana salarial mas baja sin outliers" src="https://github.com/user-attachments/assets/2b124850-495e-42fa-8ed6-fcaf9021872b" />

Los países peor pagados son:
* La República Democrática de la Gente de Laos
* Micronesia
* Antigüa y Barbuda
  
Todos ellos con medias salariales de 1 USD (datos que podrían deberse a errores de captura). Es notorio que los países con menores salarios suelen ubicarse en África, con medianas salariales entre 1 USD y 2,822 USD anuales.  

## 1.2.2 Analisis por tipo de puesto

<img width="940" height="497" alt="8 mediana salarial por tipo de puesto sin outliers" src="https://github.com/user-attachments/assets/0fa83433-7788-458a-b6a3-abcf7e8f0e3d" />

Las tres medianas salariales más altas son: 
* **Gerente de ingeniería:** 116,015 USD
* **Ejecutivo sénior:** 112,997 USD
* **Arquitecto de software o soluciones:** 96,000 USD

Las más bajas son:
* **Estudiante:** 7,948 USD
* **Retirado:** 40,063.5 USD
* **Investigador académico:** 51,447.14 USD

Esto sugiere que el nivel de responsabilidad, experiencia y especialización influyen de manera importante en el salario. Aún así, la media salarial de entrada al mercado laboral de la industria de desarrolladores se sitúa por encima de los 7,000 USD anuales. 


<img width="1202" height="593" alt="9 diagrama de cajas del salario por tipo de puesto sin outliers" src="https://github.com/user-attachments/assets/bfdceab4-9a27-4dbe-9484-296421650a02" />

Por otro lado, el diagrama de cajas permite analizar la **dispersión salarial** de cada puesto. En este sentido, aquellos puestos con cajas más alargadas muestran una mayor variabilidad salarial dentro del 50% central de la distribución (IQR), por ejemplo casos como: Analista financiero, Gerente de ingeniería, ejecutivo senior, gerente de producción, arquitecto de software o soluciones, científico aplicado, ingeniero de infraestructura de nube, profesionales de ciberseguridad, etc. 

Por otro lado, a partir del puesto "científico de datos" y hasta los puestos con salarios más bajos, hay cajas más "cortas", esto refleja una menor variabilidad salarial dentro del 50% central de la distribución (IQR) de cada puesto (salvo profesionales de diseño UX y desarrolladores de aplicaciones de IA o físicos de IA). Sin embargo, en estos puestos, también hay presencia de outliers en estos puestos, mostrándo que hay algunas oportunidades salariales más altas (aunque no son la tendencia general).  

Vale la pena agregar que, el Q3 del diagrama de caja (linea final de la caja) indican los salarios por debajo de los cuales el 75% de los trabajadores de cada puesto tiene. Los valores aproximados de Q3 para los puestos mejor remunerados son:

* **Gerente de ingeniería:** ~ 150,000 USD
* **Ejecutivo Senior:** ~ 170,000 USD
* **Gerente de producción:** ~ 150,000 USD
* **Arquitecto de software o soluciones:** ~140,000 USD
* **Científico aplicado:** 140,000 USD

Por otro lado, para los puestos con menores valores de Q3 y por tando con salarios más bajos en el percentil 75, son:

* **Analista de datos o negocios:** ~ 100,000 USD
* **Administrador de sistema:** ~ 85,000 USD
* **Investigador académico:** ~70,000 USD
* **Estudiantes:** ~25,000 USD

Nota: Las observaciones con valores faltantes ("NA") en la variable Puesto fueron descartadas automáticamente por ggplot2 durante la generación del boxplot. Aunque los rangos intercuartílicos (IQR) permiten comparar la dispersión salarial entre puestos, es importante considerar que el tamaño de muestra (n) varía entre categorías. En puestos con menor n, los rangos y la presencia de valores extremos pueden ser menos representativos que en aquellos con muestras más amplias. 

## 1.2.3 Análisis por nivel educativo

<img width="993" height="551" alt="10 mediana salarial por nivel educativo" src="https://github.com/user-attachments/assets/bf718b7c-ccde-4d1d-9350-b27c49d0a66b" />

La gráfica de medianas salariales por nivel educativo muestra una relación positiva y consistente entre el grado académico alcanzado y el nivel de ingresos. En partícular las personas con Doctorado, Maestría o Título universitario presentan las medianas salariales más altas, las cuales se ubican aproximadamente entre 75,000 USD y 90,000 USD. 

Lo anterior podría relacionarse con los salarios por tipo de puesto en dónde puestos con mayores requerimientos de especialización y habilidades específicas tienen sueldos mayores. 

Por otro lado, aquellos que cuentan con nivel secundaria, otros y primaria tienen sueldos menores a los 50,000 USD. 

Por lo que se sugeriría a los interesados en trabajar en la industria tecnológica continuar con su formación y especialización, especialmente en aquellas áreas con mayores salarios (Nube, Ciberseguridad, Machine Learning e IA). 

Nota: Las observaciones con valores faltantes ("NA") fueron filtradas de la gráfica.

## 1.2.4 Análisis por años de experiencia 

Durante la inspección de la variable *años de experiencia*, se identificaron observaciones con valores extremos cercanos a los **100 años**, los cuales son irrealistas desde una perspectiva laboral y, por tanto se consideraron como errores de captura. Dado que la media de experiencia es de 13.45 años y la mediana de 11 años, además el 75% de los encuestados reportaron tener 20 años o menos de experiencia. 

Por lo anterior, se definió un umbral razonable de **50 años de experiencia.** Este valor representa un límite conservador, pues una persona que haya iniciado su vida laboral alrededor de los 15 años podría, en casos excepcionales, acumular 50 años de trayectoria y continuar trabajando. La corrección tuvo un impacto mínimo en las medidas de tendencia central, pero permitió depurar la distribución y ofrecer una visión realista del panorama laboral. 

<img width="967" height="551" alt="11 relacion entre años de experiencia y mediana salarial sin outliers" src="https://github.com/user-attachments/assets/9916504b-5835-4d18-88ef-a29e256c3739" />

El gráfico muestra una relación positiva entre la experiencia laboral y la medicana salarial al menos en los primeros años. Destaco cuatro puntos importantes:


**1. Crecimiento acelerado durante los primeros 10 años**

Entre los 0 y los 10 años de experiencia, la mediana salarial aumenta de manera pronunciada, pasando de valores cercanos a los 20,000 USD a aproximadamente 80,000 USD. Este intervalo muestra el aumento más rápido, asociado a la adquisicón de habilidades fundamentales. 
**2. Crecimiento moderado despues de los 10 a 15 años**

El crecimiento salarial continúa pero a un ritmo más moderado y con fluctuaciones, teniendo medianas salariales de 80,000 USD y hasta proximos a los 90,000. Lo cual conicidiría con el paso a roles senior o especializados. 

**3. Estabilización y desaceleración a partir de los 20 años**

A partir de los 20 años de experiencia el salario comienza a estabilizarse e incluso puede mostrar desaceleración, manteniendo medianas salariales entre los 90,000 y los 120,000 USD. Esto sugiere que, en la industria tecnológica, el mayor impacto salarial se obtiene durante los primeros años de carrera, mientras que después de cierto punto el incremento se suaviza y se mantiene. 


**4. Variabilidad elevada en los rangos altos de experiencia**

Entre los 45 y los 50 años de experiencia se presentan variaciones interesantes, hay medianas salariales de 75,000 USD aprox. pero también medianas salariales cercanas a los 140,000 USD. Lo anterior, podría deberse a situaciones en las que las personas eligen retirarse "formalmente" del trabajo y realizan labores eventuales (salarios bajos) o a puestos Senior o Expert (salarios altos).  

Nota: Las observaciones con valores faltantes ("NA") fueron filtradas de la gráfica.

## 1.2.5 Análisis por modalidad laboral

<img width="967" height="551" alt="11 mediana salarial por modalidad laboral son outliers" src="https://github.com/user-attachments/assets/b36c1998-1017-40d5-a304-edb054e48f36" />


Los trabajos reomotos tienen la mediana salarial más alta con valores superiores a los 80,000 USD anuales. Le siguen los esquemas híbridos con tendencia a flexible cuyos salarios se apróximan a los 80,000 USD.

La modalidad de libre elección muestra una media cercana a los 75,000 USD, mientras que los esquemas híbridos con tendencia a presencial se ubican alrededor de los 70,000 USD.

Finalmente, la modalidad presencial presenta los salarios más bajos, con medias por debajo de los 45,000 USD, marcando una diferencia notable respecto al resto de las modalidades. 

<img width="967" height="551" alt="13 diagrama de cajas del salario segun modalidad laboral sin outliers" src="https://github.com/user-attachments/assets/fe2fc593-d765-45a4-bf4c-d5ebe776f511" />

Lo anterior se comprueba al visualizar el diagrama de cajas de los salario por modalidad laboral. La mediana salarial de el modo presencial es la más baja de ls cinco categorrías, el 75% de los empleados en modalidad presencial ganan menos de ~ 85,000 USD. Por otro lado, los valores aproximados de Q3 para las otras modalidades laborales son:

**1. Híbrido con tendencia a presencial:** ~ 105,000 USD
**2. Libre elección:** ~ 110,000 USD
**3. Híbrido con tendencia a flexible:** ~ 115,000 USD
**4. Remoto:** ~ 135,000 USD

Anque se eliminaron los outliers de la variable salario (se realizó al inicio del analsis), las categorias hibridas, libre elección y presencial cuentan con personas con salarios significativamente más altos respecto al resto del grupo, es decir, existe mayor variabilidad salarial interna (que podría deberse a puestios senior), por otro lado, los puestos remotos no presentan valores extremos, pero sí una caja más alargada, lo que sugiere que aunque tienen un rango salarial más amplio para los trabajadores que se encuentran dentro del IQR, presentan una distribución salarial más uniforme y consistente entre quienes trabajan completamente a distancia. 

Nota: Las observaciones con valores faltantes ("NA") fueron filtradas para el análisis.

## 1.2.6 Analisis por tipo de industria 


<img width="967" height="551" alt="14 mediana salarial por tipo de industria son outliers" src="https://github.com/user-attachments/assets/479d2f28-6a3b-4965-ac8b-141fffa347ee" />

Como puede observarse, la industria mejor pagada es la de seguros, con una mediana salarial superior a los 95,000 USD anuales. Le siguen los sectores de tecnología, energía y salud, con medianas que oscilan entre 85,000 USD y 88,000 USD aproximadamente. Estos sectores suelen asociarse con una alta demanda de perfiles técnicos y una fuerte inversión en infraestructura digital, factores que contribuyen a la competitividad salarial.

La mayoría de las industrias se situan entre los ~ 75,000 USD y los ~ 82,000 USD. Por otro lado, las industrias con menores salarios medianos son educación superior y desarrollo de software, ambas con valores inferiores a los ~ 67,500 USD. 

<img width="967" height="551" alt="15 diagrama de cajas del salario por sector industrial sin outliers" src="https://github.com/user-attachments/assets/744960cf-e5fc-4a0e-af20-ff92ca025655" />

A pesar de que la industria de seguros es la mejor pagada, el 75% de sus trabajadores tienen un salario por debajo de los ~ 130,000 USD, en cambio las industrias de la salud y tecnológica tiene al 75% de sus trabajadores por debajo de los ~ 135,000 USD (y sin presencia de valores extremos). Por otro lado, los sectores con menores medianas salariales se encuentran manufactura, desarrollo de software y educación superior con salarios menores para el 75% de sus empleados de ~ 119,000 USD, ~ 119,500 USD y ~ 95,000 USD. Estos sectores aunque tienen las medianas salariales más bajas, también presentan valores extremos considerables, indicando posibles oportunidades laborales con salario mayores, asociados a cargos especializados. 

# Conclusiones generales 

El análisis del panorama salarial en la industria tecnológica revela patrones consistentes que confirman la influencia de factores tradicionales en el nivel de ingreso. En primer lugar, el tipo de puesto del desarrollador influye en el salario percibido, aquellos puestos relacionados con mayores exigencias de expecialización o responsabilidad tienen los salarios más competitivos. Asimismo, el nivel educativo se posiciona como un determinante clave del salario: profesionistas con estudios universitarios, maestrías o doctorado presentan medianas salariales más altas, lo que señala la relevancia de la formación académica en este sector que está en constante evolución y es de alta especialización. 

En cuanto a los años de experiencia, hay una relación positiva entre el salario y el tiempo laborado, especialmente en los primeros diez años, periodo en el que el crecimiento salarial es más acelerado. Aunque, posteriormente el salario se estabiliza en rangos entre los 90,000 USD y los 120,000 USD. 

Respecto a la modalidad laboral, el trabajo remoto destaca de manera importante como la opción mejor remunerada, seguido de las modalidades híbridas o de libre elección. En contraste el trabajo presencial tiene un salario menor. 

Finalmente, el tipo de industria introduce diferencias importantes: secotres como seguros, tecnología, energía y salud muestran salarios más competitivos, mientras que sectores como educación superior o desarrollo de software presentan los sueldos más bajos. Aún así, varios sectores presentan nichos con salarios superiores al promedio. 

En este sentido, el salario no depende de un único factor, sino de la interacción de educación, experiencia, modalidad y tipo de industria. 

# Recomendaciones generales

1. Para los interesados en laborar en la industria tecnológica:
  * Invertir en educación y especialización
  * Dirigirse a áreas de especialización como Nube, IA y Machine Learning, Financiera, Ciberseguridad
  * Acumular experiencia estratégica en los primeros 10 años
  * Optar por modalidad flexibles o remotas
    
2. Para las empresas:
  * Revisar las brechas salariales para retener al personal
  * Ofrecer esquemas flexibles o hibridos
  * Fomentar el desarrollo profesional interno






