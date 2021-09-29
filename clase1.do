 
*************** -1. Familiarización con los principales botones- ***************

**************************** -2. Tipos de archivos- ****************************

* .do
* .log
* .dta

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
 
 * 2. Generar variables
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
* crear nuevas variables a partir de datos preexistentes.
* https://www.stata.com/manuals13/degen.pdf#degen
egen
 * 3. Generar macros
 * 4. Generar cuadros
	* 4.1 Subtotales
 * 5. Generar gráficas

 * Funciones de texto
 * https://www.stata.com/manuals13/m-4string.pdf#m-4string
