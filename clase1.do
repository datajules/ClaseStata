
******************************** -0. Deflactor- ********************************
{
/* 


Las variables monetarias están expuestas a las fluctuaciones generales de 
precios. Estas fluctuaciones, muchas veces son ajenas al desempeño general de
la variable de análisis. EN este caso decimos que la variable está mostrando 
precios constantes.


El problema de los precios constantes, es que pueden probocarnos ilusión 
monetaria. Esta ilución consiste en que podemos creer que estamos ganando dinero
cuando en realidad, medido en poder adquisitivo, lo estamos perdiendo en el peor
de los casos, o no ganamos nada o muy poco en el mejor de los casos.

Para evitar esta situación, es necesario considerar las fluctuaciones generales 
de precios. El Índice Nacional de Precios al Consumidor (INPC) es un indicador
económico global que muestra la variación de los precios de una canasta de bienes
y servicios representativa para las familias del país.

*/


* 1. Descargamos el archivo del INPC, se encuentra disponible en:
* https://www.inegi.org.mx/temas/inpc/

* Abrimo sel archivo
cd "/Users/juliovicenteguadarrama/Documents/dataScience/ClaseStata"
import excel "Indicadores20210929175152.xls", sheet("Página 1") cellrange(A5:B625) firstrow clear

* 2. Fijamos el 1 de enero de 2019 como año base
list PorcentajeMensual if Periodos == "2019/01"
summarize PorcentajeMensual if Periodos == "2019/01"

scalar prueba = r(mean)

di prueba

* 3. Para conseguir el deflactor con precios de 2019/01 dividimos el resto de 
* los índices con ese valor.

generate deflactor = PorcentajeMensual / prueba

display $valBase

browse

* El deflactor representa el nivel de precios con relación al año base, y 
* como estos van cambiando periodo a periodo. Ahora vamos a usarlo para pasar 
* una cuenta de precios corrientes a precios constantes.
}

 
*************** -1. Familiarización con los principales botones- ***************

**************************** -2. Tipos de archivos- ****************************
{
* .do
* .log
* .dta
}
*************************** -3. Comentarios en STATA- **************************
{
 /* 
 
 Los comentarios son líneas que el intérprete de STATA ignora durante una 
 ejecución. Su función es comentar los diversos pasos que se van ejecutando en
 el do, para facilitar su posterior interpretación. Otro posible uso es 
 cancelar momentaneamente algunas de las funciones del do cuando no queremos 
 que se ejecuten.
 
 Existen 3 formas de crear comentarios en STATA
 
a. * -> Comentarios de una sola línea.
b. /* */ Comentarios de múltiples líneas 
c. // Comentarios al final de una línea de funciones
 */

display 2 * 5 // Esta es una multiplicación
 
} 
********************************* -4. delimit- ********************************* 
{
 /*
Se emplea delimit para poder agregar golpes de carro (es decir enter) entre
cada instrucción, incluyendo los comentarios
 */
 
 #delimit;
 
 * 
 Cuando empleemos funciones e instrucciones es necesario rematarlas con punto y 
 coma  para que se interprete como función. Esto también aplica para los 
 comentarios, se pueden iniciar con asterisco y terminar con punto y coma;
 display 5 + 5;
 
 *
 Para regresar a la operación anterior de stata se hace de la siguiente forma;
 
 #delimit cr;
 
 display 10 + 2
 
 * Si se desea agregar un enter en el modo normal es posible hacerlo empleando
 * tres diagonales
 display 2 + ///
 3
}
 
*********************** -5. Operaciones (suma, resta...)- **********************
{
* https://www.stata.com/manuals/u13.pdf
 
* La función display: Despliega contenido en la pantalla. Cuando se trata de 
* texto es necesario entrecomillarlo.

* Operaciones aritméticas
	* Operaciones aditivas
	display 5 + 5
	display 2 + 2
	* Operaciones multiplicativas
	display 3 * 4
	display 50 / 5
	display 3 ^ 2

* Operaciones con texto
	* Operaciones aditivas
	display ("hola " + "mundo")
	* Operaciones multiplicativas
	display ("hola " * 3)
	
* Operaciones relacionales
	* mayor que / mayor o igual que
	display 3 > 2 // 1 -> TRUE
	display 3 > 5 // 0 -> FALSE
	display ("planta" > "arbol") // En caso de texto considera el orden alfabético.
	display 3 > 3 
	display 3 >= 3
	* menor que / menor o igual que
	display 3 > 2 
	display 3 > 5 
	* igual a
	display 5 == 4
	display 5 == 5
	display ("arbol" == "animal")
	* diferente a
	display 5 != 4
	display 5 != 5
* Operaciones lógicas
	* AND
	display 1 & 0
	display 1 & 1
	display 1 & 1 & 1 & 1
	display 1 & 1 & 1 & 1 & 0 & 1 & 1
	display 3 > 2 & 5 > 4
	* OR
	display 1 | 0
	display 1 | 1
	display 0 | 0
	display 0 | 0 | 0 | 0 | 0 | 0 | 0
	display 0 | 0 | 0 | 0 | 0 | 0 | 1
	* NOT
	display !1
	display !0
} 

 
 

******************************** -6. Funciones- ********************************
{
* Las funciones consisten en operaciones predefinidas que toman argumentos por
* entrada y devuelven un resultado (output) de salida.

* Funciones matemáticas
* https://www.stata.com/manuals/fnmathematicalfunctions.pdf
display sqrt(4)
display min(1, 2, 3, 4, 5)
display sum(1, 2, 3, 4, 5)

* Funciones de texto
* https://www.stata.com/manuals/fnstringfunctions.pdf
display strlen("Hola")
display substr("hola", 1, 2)
display strupper("hola")
}

********************************* -7. Comandos- ********************************
{
* https://www.stata.com/manuals13/u27.pdf
/* 
Además de las funciones, los comandos ejecutan operaciones más complejas,
muchas de ellas relacionadas con la manipulación de bases de datos. Los 
programas emplean argumentos de entrada, y devuelven resultados en la consola, 
pero también almacenan parámetros de salida en forma de macros, escalares, 
vectores y matrices.
*/
* 
clear
sysuse auto

* browse -> Despliega el visor de la base.
browse

* summarize -> Resumen estadístico
help summarize
summarize
summarize mpg weight
summarize mpg
display r(N)
display r(mean)

* table -> Tabulados
table mpg
table mpg foreign
table mpg, by(foreign)


list mpg foreign in 1/5
}
 
**************************** -8. Generar variables- ****************************
{
* Generate crea una variable nueva. Es posible asignarle cualquier valos, o bien 
* transformar alguna variable prexistente.
generate ejemplo = .
generate ejemplo2 = 5
generate precio_rend = mpg / price
* Cuando una variable ya existe no puede ser generada nuevamente, por los que
* nos arrojará un error. replace nos permitirá sustituir alguna variable 
* existente por una nueva asignación.
replace 
* egen es una extención de gen. Nos permite emplear funciones adicionales para
* crear nuevas variables a partir de datos preexistentes. Estas funciones sun
* muy útiles sobre todo para lidiar con valores perdidos
* https://www.stata.com/manuals13/degen.pdf#degen
egen modelo = concat(make, price)

gen prueba1 = .
gen prueba2 = 100

gen prueba_tot = prueba1 + prueba2

egen prueba_tot2 = rowtotal(prueba1 prueba2)

}

****************************** -9. Generar macros- ******************************
{ 
 * Las macros nos permiten almacenar valores temporalmente. Ya sean puntuales 
 * o bien colecciones de valores.
 
 * A. locals -> Las locals almacenan datos de forma temporal, solo podemos 
 * recurrir a ellas mientras el programa se ejecuta. Permiten ahorrar memoria.
 
 local numero 9
 display `numero'
 
 
 * B. globals -> Almacenan los datos hasta que se cierre el Stata
 global letra "A"
 di "$letra"
 }
 

