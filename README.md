# Compilado de habilidades 

Este repositorio presenta un recorrido por **tres niveles de habilidades** (Analytics, SQL y APIs para consultas), aplicadas a distintos contextos de análisis y desarrollo de soluciones basadas en datos.

---

## 📊 1. Análisis de datos macroeconómicos [Analytics]

Se construye un tablero interactivo en Power BI utilizando datos del **Banco Mundial**, extraídos del informe sobre Tecnologías de la Información y la Comunicación (TIC). 

**Objetivo:** Analizar la evolución y explicar el uso de internet en Argentina y compararlo con Brasil, México y otros países de América Latina.

### 📌 Conclusiones

A partir del análisis realizado, se observa que **Argentina presenta una alta adopción de internet**. En 2023, el **89% de la población utilizó internet al menos una vez en los últimos tres meses**.

Este fenómeno puede explicarse, en parte, por una mayor **conectividad general**, tanto en hogares con acceso a internet fijo como por el crecimiento de la **cobertura de datos móviles** y el aumento en las **suscripciones a servicios móviles**.

En comparación con países como **Brasil** y **México**, Argentina se posiciona como el país con **mayor nivel de uso de internet** en la región. Además, muestra ventajas en los siguientes indicadores:

- 🛰️ **Competencia en el mercado de servicios de internet**  
- 🏠 **Porcentaje de hogares con acceso a internet y computadoras**  
- 💵 **Costo de los datos móviles**  
- 📱 **Cantidad de suscripciones móviles**

Estos factores combinados contribuyen significativamente a la elevada penetración y uso de internet en la población argentina.

---

## 🛒 2. Modelado de Negocio para Ecommerce [SQL]

Se simula un modelo de datos para un ecommerce.  
Mediante **consultas SQL** y **stored procedures**, se resuelven distintos requerimientos del negocio, con foco en la extracción y análisis de información clave.


---

## 🌐 3. Integración con APIs Externas [API]

Se realiza una consulta a una **API externa** para obtener la cotización del real brasileño frente a:
- 💰 Bitcoin (BTC)
- 💵 Dólar estadounidense (USD)
- 💶 Euro (EUR)

Esta sección aplica conceptos de integración, consumo de servicios externos y normalización de datos. 
Se utiliza el lenguaje de programación Python, junto con las librerías requests y pandas, para consultar y normalizar los datos, respectivamente.
El archivo JSON obtenido se transforma para generar una salida estructurada que detalla: la moneda de origen, la moneda de destino, el valor de venta, el valor de compra y la hora de la cotización.

---
