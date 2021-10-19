



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
display string(1,"%03.0f")
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
 
 
******************************** -10. for loop- ********************************
{

foreach municipio in 1 2 3 {
	display `municipio' + 5
}

local algunosNums 1 2 3 4 5

foreach i of local algunosNums {
display `i'
}

global algunasLetras "A" "B" "C" "D"

foreach i of global algunasLetras {
display "`i'"
}



sum price

sum price, by(foreign) // ALgunos comandos no admiten la opción by()

* En estos casos es util emplear el foreach:
levelsof foreign
local tipo = r(levels)

foreach i of local tipo {
local caso : label origin `i'
display "Para `caso':"
summarize  price if foreign == `i'
}


local prueba : label origin 1
display "`prueba'"

* Ahora probemos con el censo de población y vivienda

 use "/Users/juliovicenteguadarrama/Documents/bases/iter_09_cpv2020_csv/conjunto_de_datos/conjunto_de_datos_iter_09CSV20.dta"



* Edad por género por municipio

* Primero creamos una variable con la clave de municipio a 5 dígitos

gen cve_mun =  ENTIDAD + MUN

* Primero abres base1
use "archivobase1.dta"  ,	 clear
sort clave
save "archivobase1_or.dta", replace

* ABres base 2
use "archivobase2.dta"  ,	 clear
sort clave
save "archivobase2_or.dta", replace
* Abres base 3
use "archivobase3.dta"  ,	 clear
sort clave

* Pegamos las bases
merge clave using "archivobase1_or.dta"

tab _merge

drop _merge

sort clave

merge clave using "archivobase2.dta"


destring P_3YMAS, replace force
destring P12A14NOAF , replace force

global salida " -  - "
global salida $salida "Municipio - VIVTOT - P_3YMAS"
levelsof NOM_MUN, local(municipios)
foreach i in `municipios' {
	* Viviendas totales
	display "Para el municipio `i'"
	total VIVTOT if NOM_MUN == "`i'"
	matrix b = e(b)
    local total1 = b[1,1]
	* Poblacion 3 años y mas
	total P_3YMAS if NOM_MUN == "`i'"
		matrix b = e(b)
    local total2 = b[1,1]
	global salida $salida "`i' - `total1' - `total2'"
}

foreach i of global salida {
 display "`i'"
}





levelsof NOM_MUN, local(municipios)
foreach i in `municipios' {
	* Viviendas totales
	display "Para el municipio `i'"
	total VIVTOT if NOM_MUN == "`i'"
	matrix b = e(b)
    local total1 = b[1,1]
	* Poblacion 3 años y mas
	total P_3YMAS if NOM_MUN == "`i'"
		matrix b = e(b)
    local total2 = b[1,1]
	* Población femenina de 12 a 14 años que no asiste a la escuela
	total P12A14NOAF  if NOM_MUN == "`i'"
			matrix b = e(b)
    local total3 = b[1,1]
	global salida $salida "`i'" "Numero de viviendad" "`total1'" "Población de 3 o más" "`total2'"  "Población femenina de 12 a 14 años que no asiste a la escuela" "`total3'"  "--------------------------"
}

foreach i of global salida {
 display "`i'"
}





* El merge 3 son los estaban en ambas bases

} 


 
 
 
