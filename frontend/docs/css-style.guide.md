CSS Style guide
===============

## Objetivo
El objetivo de este documento es listar las buenas prácticas y convenciones para usar CSS en Wolox S.A.. Será consultado en capacitaciones y usado como marco de referencia a la hora de hacer Code Review.
Este documento debe ser modificado y revisado regularmente


## Estilo
#### Naming:
Para nombrar clases, usar nombres lo más cortos posibles, pero lo suficientemente largos para que sean representativos:

**.navigation** es muy largo, cuando **.nav** es representativo

**.atr** es muy corto y no tan representativo para decir **.author**

El uso de ids en css (por ejemplo _#navigation_) no es recomendado.

Existen casos en donde es inevitable (por ejemplo, si se desea “overridear” o sobreescribir reglas de un componente).

Si una clase debería tener 2 palabras, separarla sólo por un guion medio.

**.demo-image** y no **.demo_image**, ni **.demoImage** o **.demoimage**

#### CSS y HTML tags:
Evitar usar HTML tags en css:
En vez de **p.error{ }** , usar **.error{ }**
En vez de usar **p {}**, escribir en el html **p.caption** y usar **.caption{}**

#### Shorthands:
Se fomenta el uso de shorthands

    margin: 0 10px 20px;

Los shorthands (que son usados para margin, padding, border, etc.) funcionan de acuerdo a la cantidad de valores.

Si tiene 4 valores

    margin: 25px 50px 75px 100px;

Equivale a

    margin-top: 25px;
    margin-right: 50px;
    margin-bottom: 75px;
    margin-left: 100px;

Si tiene 3 valores

    margin: 25px 50px 75px;

Equivale a

    margin-top: 25px;
    margin-right: 50px;
    margin-bottom: 75px;
    margin-left: 50px;

Si tiene 2 valores

    margin: 25px 50px;

Equivale a

    margin-top: 25px;
    margin-right: 50px;
    margin-bottom: 25px;
    margin-left: 50px;

Si tiene 1 valor

    margin: 25px;
Equivale a

    margin-top: 25px;
    margin-right: 25px;
    margin-bottom: 25px;
    margin-left: 25px;


#### Unidades:
Evitar agregar unidades en valores **“0”**.

    margin: 0;

en vez de

    margin: 0px;

#### Fuentes:
Se recomienda usar “Web safe fonts” (A.K.A. callback fonts)

    .caption {
        font-family: "Times New Roman", Times, serif;
    }

Si por alguna razón el browser no soporta la primera fuente, pasará a la siguiente y así sucesivamente.

#### Colores:
Se deben usar variables de color

    color: #4285F4;
    color: $cornflower-blue;

Luego en un archivo **\_colors.scss**

    $cornflower-blue: #4285F4;

El nombre del color debe describir el color en sí mismo y no donde es usado

Evitar:

    background-color: $table-header-color;
Evitar:

    color: $main-title;

Usar, en cambio:

    color: $cornflower-blue;

Para evitar repetición de colores (Ej: _$light-grey_, _$lighter-grey_) usamos [Name that color](http://chir.ag/projects/name-that-color/).

Usar colores abreviados de ser posible, cambiando

    $beauty-bush: #EEBBCC;

por

    $beauty-bush: #EBC;

Y no deben estar en minuscula, cambiando

    $beauty-bush: #ebc;

por

    $beauty-bush: #EBC;

#### Orden de propiedades:
Las propiedades deben ser ordenadas alfabéticamente

    background: fuchsia;
    border: 1px solid;
    border-radius: 4px;
    color: black;
    text-align: center;
    text-indent: 2em;

#### Indentación:
Las propiedades deben estar indentadas (con respecto al nombre del bloque) con 2 espacios

    .test {
      display: block;
      height: 100px;
    }


En caso de bloques anidados, estos bloques deben estar separados por una línea en blanco y anidados 2 espacios

    .test {

      .caption {
        color: $cornflower-blue;
      }
    }

#### Fin de declaración:
Todas deben terminar con “;”

    .test {
      display: block;
      height: 100px;
    }

Evitar líneas sin fin de declaración como:

    .test {
      display: block;
      height: 100px
    }

#### Nombre de propiedad:
Los nombres de propiedades deberán ser seguidos de un espacio

    display:block; //Incorrecto
    display: block; //Correcto

#### Nombre de bloque:
Los nombres de bloque deberán ser seguidos de un espacio

    .video{  //Incorrecto
      margin-top: 10px;
    }

    .video
    {  //Incorrecto
      margin-top: 10px;
    }

    .video {  //Correcto
      margin-top: 10px;
    }

#### Multiples selectores por bloque:
Cuando varios selectores tienen las mismas propiedades, se recomienda usar un solo bloque con múltples selectores

    .sale-option:focus,
    .sale-option:active {
      color: $green;
    }

Los múltiples selectores no deben separados por una línea y no deben ser escritos en la misma línea.

    .sale-option:focus, .sale-option:active {  //Incorrecto
      color: $green;
    }

#### Separación de reglas
Se separan con una línea en blanco

    .container {
      background: $white;
    }
    .tile { //Sin línea, incorrecto.
      margin: auto;
      width: 50%;
    }

    .container {
      background: $white;
    }

    .tile { // Con línea, correcto.
      margin: auto;
      width: 50%;
    }


#### Comillas
Usar comillas simples

    .caption {
      font-family: “open sans”, arial, sans-serif; // Incorrecto
    }

    .caption {
      font-family: 'open sans', arial, sans-serif; // Correcto
    }

##  Naming:

Existen distintos tipos de enfoque para nombrar las clases de CSS (expressive, atomic, object-oriented). Lo más importante (en caso de ser proyectos mantenidos con código existente) es generar clases que sean compatibles con el estilo y enfoque ya aplicado.

#### Expressive:
Para reutilizar clases con estilos cortos en otros lugares, sino queda vinculado al nombre

    .home-container { // No recomendado (Según expressive css)
      padding: 10px;
    }

    .padding-10 { // Recomendado (Según expressive css)
      padding: 10px;
    }
** Nota: ** Recordar que las recomendaciones de naming no son rígidas y dependen del enfoque utilizado.

#### Naming en Slim:
Siempre poner el id (si lo hay) antes que las clases

    // Incorrecto
    .class-name#container-home

    // Correcto
    #container-home.class-name

** No usar br tag:**
Si se quiere separar contenedores usar padding o margin.
