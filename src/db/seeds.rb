require "./server"

guiaSum =
"
Definicion
--DIVISION-- La suma es la acción de añadir, juntar o agregar elementos, cuando realizamos esta acción estamos uniendo cantidades o conjuntos y para ello siempre debe haber un mínimo de dos elementos.
--PARTES-- Partes de la suma
--DIVISION-- A los números que intervienen en una suma se les denomina sumandos, al resultado de la operación lo llamamos suma o resultado. Por ejemplo, en el caso de la operación 2+8 = 10 , el 2 y el 8 son sumandos y el 10 es la suma o resultado.
"
guiaRes =
'Definicion
--DIVISION-- La resta o la sustracción es una operación aritmética que se representa con el signo "-" y representa la operación de eliminación de objetos de una colección.
--PARTES-- Partes de la resta
--DIVISION-- Los números que intervienen en la resta también reciben nombres para poderlos identificar. Al número que se le quita o se le sustrae es denominado minuendo, el número que resta o sustrae es llamado sustraendo y, finalmente, al resultado se le conoce como resta o diferencia de los números. En el caso de la resta:8-3 = 5 , el ocho es el minuendo, el tres es el sustraendo y la diferencia es cinco.
'

guiamult = "
Definicion:
--DIVISION-- La multiplicación es aquella operación mediante la cual se suma un número por sí mismo tantas veces como lo señala otro número.
--PARTES-- Partes:
--DIVISION-- Factores: Los factores son los números que se multiplican.
--DIVISION-- Producto: El producto es el resultado de la multiplicación.
--DIVISION-- Multiplicando: El multiplicando es el factor que se encuentra arriba en la multiplicación.
--DIVISION-- Multiplicador: El multiplicador es el factor que se encuentra debajo del multiplicando.
--PARTES-- Propiedades:
--DIVISION-- Propiedad conmutativa: Significa que el orden de los factores no altera el producto. Es decir, 11×3 es igual que 3×11, no importa cuál de los factores va primero, el resultado no se va a alterar.
--DIVISION-- Propiedad asociativa: Significa que si tenemos que hacer la siguiente operación 5×3 y el resultado lo multiplicamos ×4, el resultado final es el mismo que multiplicar 3×4 y el resultado multiplicarlo ×5. En ambos casos el resultado es 60.
--DIVISION-- Propiedad distributiva: La propiedad distributiva nos señala que, si multiplicamos el resultado de una suma (o resta) por un número x, obtenemos el mismo resultado que si multiplicamos cada uno de los términos que se están sumando (o restando) por x y luego los sumáramos (o restáramos).
--DIVISION-- Multiplicar por cero: Cualquier número multiplicado por cero es igual a cero.
--DIVISION-- Multiplicar por uno: Un número multiplicado por 1 es igual al mismo número.
--DIVISION-- Multiplicar por diez: El producto de cualquier número n multiplicado por diez, o una potencia de diez, es igual a n más el número de ceros que posee el multiplicador a la derecha. En este sentido, si multiplico 4×100, el resultado será 4, más dos ceros a la derecha. Es decir, 400. De igual modo, 7×1.000 será igual a 7 más tres ceros a la derecha. Por tanto, 7.000.
"

guiaDiv= "
Definicion
--DIVISION-- Definimos la división como aquella operación matemática que consiste en separar una cantidad en partes iguales, es decir, se trata de realizar una distribución equitativa del objeto o cosa que se quiere repartir.
--PARTES-- Partes de la división
--DIVISION-- Dividendo es el número que se va a dividir.
--DIVISION-- Divisor es el número que divide.
--DIVISION-- Cociente es el resultado de la división.
--DIVISION-- Resto es lo que ha quedado del dividendo, que no se ha podido dividir porque es más pequeño que el diviso
--DIVISION-- Sus términos cumplen esta relación: Dividendo = divisor * cociente + resto.
--PARTES-- Propiedades
--DIVISION-- Cero dividido entre cualquier número siempre da cero: 0 / n = 0
--DIVISION-- No se puede dividir entre cero: n / 0 = error
--DIVISION-- La división no es asociativa
--DIVISION-- La división no es conmutativa
"

#Creacion de temas
Topic.create(nombre: "Suma" , descripcion: "La adición o suma es la operación matemática de composición que consiste en combinar o añadir dos números o más para obtener una cantidad final o total.", img:'https://i.imgur.com/rMA2PnT.png', guia: guiaSum, video: 'https://www.youtube.com/embed/oF-rZLIShC8')
Topic.create(nombre: "Resta" , descripcion: "La resta o sustracción es una operación matemática que consiste en sacar, quitar, reducir o separar algo de un todo.", img:'https://i.imgur.com/vpFobkj.png', guia: guiaRes, video: 'https://www.youtube.com/embed/L6NOkLq6kHk')
Topic.create(nombre: "Multiplicacion" , descripcion: "La multiplicación es la operación matemática que consiste en hallar el resultado de sumar un número tantas veces como indique otro.", img:'https://i.imgur.com/9rrOc8V.png', guia: guiamult, video: "https://www.youtube.com/embed/AE4B0hgnz0E")
Topic.create(nombre: "Division" , descripcion: "Operación matemática que consiste en separar una cantidad en partes iguales, es decir, se trata de realizar una distribución equitativa del objeto o cosa que se quiere repartir", img:'https://i.imgur.com/Gq65i6z.png', guia: guiaDiv, video: "https://www.youtube.com/embed/0D1wxxlBN-0")




# Creación de preguntas de suma
Question.create(value: 1, description: "¿Si tengo 🍎🍎 y me regalan otras 🍎🍎, cuántas manzanas tengo ahora?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "Si en un juego hay 👾👾 y estos llaman a 👾👾 👾👾 👾👾 👾👾 más, ¿cuántos hay ahora?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "En un acuario viven 10 🐟, en otro 5 🐠 y otro 2 🐡, ¿cuántos peces hay si sumamos los 3 acuarios?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "En una granja hay 15 🐣 y despues de una semana el granjero trae otros 9 🐣 más, ¿cuántos pollitos viven ahora en la granja?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "En la escuela dos aulas que estan encargadas de un acto, unos alumnos acomodan 🪑 y los otros decoran 🎍🎊. Los que decoran son 27 y los que acomodan son 14, ¿cuántos alumnos 👨🏻‍🎓 estan a cargo del acto?", nivel_q: 1, topic_id: 1)


#Nivel 1
Option.create(description: "4", isCorrect: true, question_id: 1)
Option.create(description: "3", isCorrect: false, question_id: 1)
Option.create(description: "2", isCorrect: false, question_id: 1)
Option.create(description: "6", isCorrect: false, question_id: 1)

Option.create(description: "11", isCorrect: false, question_id: 2)
Option.create(description: "12", isCorrect: false, question_id: 2)
Option.create(description: "10", isCorrect: true, question_id: 2)
Option.create(description: "9", isCorrect: false, question_id: 2)

Option.create(description: "16", isCorrect: false, question_id: 3)
Option.create(description: "17", isCorrect: true, question_id: 3)
Option.create(description: "19", isCorrect: false, question_id: 3)
Option.create(description: "18", isCorrect: false, question_id: 3)

Option.create(description: "26", isCorrect: false, question_id: 4)
Option.create(description: "25", isCorrect: false, question_id: 4)
Option.create(description: "24", isCorrect: true, question_id: 4)
Option.create(description: "23", isCorrect: false, question_id: 4)

Option.create(description: "40", isCorrect: false, question_id: 5)
Option.create(description: "42", isCorrect: false, question_id: 5)
Option.create(description: "39", isCorrect: false, question_id: 5)
Option.create(description: "41", isCorrect: true, question_id: 5)


## nivel 2

Question.create(value: 3, description: "¿Cuánto es 648 + 527?", nivel_q: 2, topic_id: 1)
Question.create(value: 3, description: "¿Cuánto es 3214 + 4987?", nivel_q: 2, topic_id: 1)
Question.create(value: 3, description: "¿Cuánto es 15487 + 26934?", nivel_q: 2, topic_id: 1)
Question.create(value: 3, description: "¿Cuánto es 123 + 89?", nivel_q: 2, topic_id: 1)
Question.create(value: 3, description: "¿Cuánto es 532 + 187?", nivel_q: 2, topic_id: 1)


Option.create(description: "1175", isCorrect: true, question_id: 6)
Option.create(description: "1170", isCorrect: false, question_id: 6)
Option.create(description: '1100', isCorrect: false, question_id: 6)
Option.create(description: '1180', isCorrect: false, question_id: 6)


Option.create(description: '8201', isCorrect: true, question_id: 7)
Option.create(description: '8202', isCorrect: false, question_id: 7)
Option.create(description: '8203', isCorrect: false, question_id: 7)
Option.create(description: '8200', isCorrect: false, question_id: 7)


Option.create(description: '42421', isCorrect: true, question_id: 8)
Option.create(description: '42400', isCorrect: false, question_id: 8)
Option.create(description: '42550', isCorrect: false, question_id: 8)
Option.create(description: '41691', isCorrect: false, question_id: 8)

Option.create(description: '212', isCorrect: true, question_id: 9)
Option.create(description: '211', isCorrect: false, question_id: 9)
Option.create(description: '210', isCorrect: false, question_id: 9)
Option.create(description: '213', isCorrect: false, question_id: 9)

Option.create(description: '719', isCorrect: true, question_id: 10)
Option.create(description: '718', isCorrect: false, question_id: 10)
Option.create(description: '716', isCorrect: false, question_id: 10)
Option.create(description: '712', isCorrect: false, question_id: 10)

## nivel 3

Question.create(value: 5, description: "¿Cuánto es 892 + 457?", nivel_q: 3, topic_id: 1)
Question.create(value: 5, description: "¿Cuánto es 621 + 894?", nivel_q: 3, topic_id: 1)
Question.create(value: 5, description: "¿Cuánto es 489 + 726?", nivel_q: 3, topic_id: 1)
Question.create(value: 5, description: "¿Cuánto es 752 + 946?", nivel_q: 3, topic_id: 1)
Question.create(value: 5, description: "¿Cuánto es 613 + 869?", nivel_q: 3, topic_id: 1)
Question.create(value: 5, description: "¿Cuánto es 928 + 541?", nivel_q: 3, topic_id: 1)


Option.create(description: '1352', isCorrect: false, question_id: 11)
Option.create(description: '1349', isCorrect: true, question_id: 11)
Option.create(description: '1355', isCorrect: false, question_id: 11)
Option.create(description: '1358', isCorrect: false, question_id: 11)

Option.create(description: '1515', isCorrect: true, question_id: 12)
Option.create(description: '1517', isCorrect: false, question_id: 12)
Option.create(description: '1520', isCorrect: false, question_id: 12)
Option.create(description: '1522', isCorrect: false, question_id: 12)

Option.create(description: '1214', isCorrect: false, question_id: 13)
Option.create(description: '1216', isCorrect: false, question_id: 13)
Option.create(description: '1215', isCorrect: true, question_id: 13)
Option.create(description: '1217', isCorrect: false, question_id: 13)

Option.create(description: '1696', isCorrect: false, question_id: 14)
Option.create(description: '1697', isCorrect: false, question_id: 14)
Option.create(description: '1698', isCorrect: true, question_id: 14)
Option.create(description: '1699', isCorrect: false, question_id: 14)

Option.create(description: '1480', isCorrect: false, question_id: 15)
Option.create(description: '1484', isCorrect: false, question_id: 15)
Option.create(description: '1485', isCorrect: false, question_id: 15)
Option.create(description: '1482', isCorrect: true, question_id: 15)

Option.create(description: '1470', isCorrect: false, question_id: 16)
Option.create(description: '1468', isCorrect: false, question_id: 16)
Option.create(description: '1471', isCorrect: false, question_id: 16)
Option.create(description: '1469', isCorrect: true, question_id: 16)

#Creacion de Preguntas de Resta

## Nivel 1
Question.create(value: 1, description: "¿Cuánto es 10 - 5?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "¿Cuánto es 8 - 3?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "¿Cuánto es 15 - 7?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "Si tienes 10 manzanas y le das 3 a un amigo, ¿cuántas manzanas te quedan?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "En un partido de fútbol, un equipo anotó 3 goles y le anularon 2 ¿Cuántos goles anotó en total?", nivel_q: 3, topic_id: 2)

Option.create(description: "5", isCorrect: true, question_id: 17)
Option.create(description: "3", isCorrect: false, question_id: 17)
Option.create(description: "2", isCorrect: false, question_id: 17)
Option.create(description: "7", isCorrect: false, question_id: 17)

Option.create(description: "4", isCorrect: false, question_id: 18)
Option.create(description: "3", isCorrect: false, question_id: 18)
Option.create(description: "5", isCorrect: true, question_id: 18)
Option.create(description: "6", isCorrect: false, question_id: 18)

Option.create(description: "6", isCorrect: false, question_id: 19)
Option.create(description: "7", isCorrect: false, question_id: 19)
Option.create(description: "9", isCorrect: false, question_id: 19)
Option.create(description: "8", isCorrect: true, question_id: 19)

Option.create(description: "7", isCorrect: true, question_id: 20)
Option.create(description: "6", isCorrect: false, question_id: 20)
Option.create(description: "5", isCorrect: false, question_id: 20)
Option.create(description: "4", isCorrect: false, question_id: 20)

Option.create(description: "1", isCorrect: true, question_id: 21)
Option.create(description: "5", isCorrect: false, question_id: 21)
Option.create(description: "0", isCorrect: false, question_id: 21)
Option.create(description: "2", isCorrect: false, question_id: 21)

## Nivel 2
Question.create(value: 3, description: "Si tenías $500 en tu cuenta bancaria y realizaste un retiro de $215, ¿cuánto dinero te queda?", nivel_q: 2, topic_id: 2)
Question.create(value: 3, description: "Si tenías 275 galletas en un frasco y comiste 128, ¿cuántas galletas te quedan?", nivel_q: 2, topic_id: 2)
Question.create(value: 3, description: "Si tenías 890 páginas para leer en un libro y ya has leído 437, ¿cuántas páginas te quedan por leer?", nivel_q: 2, topic_id: 2)
Question.create(value: 3, description: "Si tenías 780 fichas en un juego y perdiste 256, ¿cuántas fichas te quedan?", nivel_q: 2, topic_id: 2)
Question.create(value: 3, description: "Si tenías 320 canciones en tu lista de reproducción y eliminaste 125, ¿cuántas canciones te quedan?", nivel_q: 2, topic_id: 2)
Question.create(value: 3, description: "Si tenías 150 lápices en un estuche y perdiste 57, ¿cuántos lápices te quedan?", nivel_q: 2, topic_id: 2)


Option.create(description: "285", isCorrect: true, question_id: 22)
Option.create(description: "245", isCorrect: false, question_id: 22)
Option.create(description: "325", isCorrect: false, question_id: 22)
Option.create(description: "365", isCorrect: false, question_id: 22)

Option.create(description: "147", isCorrect: true, question_id: 23)
Option.create(description: "138", isCorrect: false, question_id: 23)
Option.create(description: "162", isCorrect: false, question_id: 23)
Option.create(description: "189", isCorrect: false, question_id: 23)

Option.create(description: "453", isCorrect: true, question_id: 24)
Option.create(description: "512", isCorrect: false, question_id: 24)
Option.create(description: "645", isCorrect: false, question_id: 24)
Option.create(description: "753", isCorrect: false, question_id: 24)

Option.create(description: "524", isCorrect: true, question_id: 25)
Option.create(description: "612", isCorrect: false, question_id: 25)
Option.create(description: "695", isCorrect: false, question_id: 25)
Option.create(description: "738", isCorrect: false, question_id: 25)

Option.create(description: "195", isCorrect: true, question_id: 26)
Option.create(description: "243", isCorrect: false, question_id: 26)
Option.create(description: "278", isCorrect: false, question_id: 26)
Option.create(description: "311", isCorrect: false, question_id: 26)

Option.create(description: "93", isCorrect: true, question_id: 27)
Option.create(description: "105", isCorrect: false, question_id: 27)
Option.create(description: "128", isCorrect: false, question_id: 27)
Option.create(description: "142", isCorrect: false, question_id: 27)

## nivel 3
Question.create(value: 5, description: "Si tienes 15 manzanas y le das 6 a tu amigo, ¿cuántas manzanas te quedan?", nivel_q: 3, topic_id: 2)
Question.create(value: 5, description: "Si tienes $50 y compras un libro que cuesta $12, ¿cuánto dinero te queda?", nivel_q: 3, topic_id: 2)
Question.create(value: 5, description: "Si tenías 250 lápices y pierdes 11, ¿cuántos lápices te quedan?", nivel_q: 3, topic_id: 2)
Question.create(value: 5, description: "Si tenías $100 en tu billetera y gastaste $35, ¿cuánto dinero te queda?", nivel_q: 1, topic_id: 2)
Question.create(value: 5, description: "Si tienes un $1000 pesos en tu billetera y compras un jugete con valor de $500 pesos, ¿cuántas dinero te queda?", nivel_q: 3, topic_id: 2)
Question.create(value: 5, description: "Si tienes 30 juguetes y regalas 5 juguetes a cada uno de tus 4 amigos, ¿cuántos juguetes te quedan?", nivel_q: 3, topic_id: 2)

Option.create(description: "9", isCorrect: true, question_id: 28)
Option.create(description: "8", isCorrect: false, question_id: 28)
Option.create(description: "10", isCorrect: false, question_id: 28)
Option.create(description: "7", isCorrect: false, question_id: 28)

Option.create(description: "$38", isCorrect: true, question_id: 29)
Option.create(description: "$40", isCorrect: false, question_id: 29)
Option.create(description: "$42", isCorrect: false, question_id: 29)
Option.create(description: "$35", isCorrect: false, question_id: 29)

Option.create(description: "239", isCorrect: true, question_id: 30)
Option.create(description: "249", isCorrect: false, question_id: 30)
Option.create(description: "240", isCorrect: false, question_id: 30)
Option.create(description: "236", isCorrect: false, question_id: 30)

Option.create(description: "65", isCorrect: true, question_id: 31)
Option.create(description: "60", isCorrect: false, question_id: 31)
Option.create(description: "90", isCorrect: false, question_id: 31)
Option.create(description: "30", isCorrect: false, question_id: 31)

Option.create(description: "500", isCorrect: true, question_id: 32)
Option.create(description: "400", isCorrect: false, question_id: 32)
Option.create(description: "600", isCorrect: false, question_id: 32)
Option.create(description: "550", isCorrect: false, question_id: 32)

Option.create(description: "10", isCorrect: true, question_id: 33)
Option.create(description: "5", isCorrect: false, question_id: 33)
Option.create(description: "15", isCorrect: false, question_id: 33)
Option.create(description: "20", isCorrect: false, question_id: 33)

#Creacion de Preguntas de Multiplicacion
Question.create(value: 1, description: "¿Cuánto es 9 * 5?", nivel_q: 1, topic_id: 3)
Question.create(value: 1, description: "Si tienes 8 amigos y cada uno de ellos tiene 3 caramelos, ¿cuántos caramelos hay en total? ", nivel_q: 1, topic_id: 3)
Question.create(value: 1, description: "Si tienes 10 billetes de $20 y 5 monedas de $1, ¿cuánto dinero tienes en total?", nivel_q: 1, topic_id: 3)
Question.create(value: 1, description: "¿Cuánto es 6 * 2?", nivel_q: 1, topic_id: 3)
Question.create(value: 1, description: "¿Cuánto es 8 multiplicado por 7?", nivel_q: 1, topic_id: 3)
Question.create(value: 1, description: "¿Cuánto es 9 multiplicado por 8?", nivel_q: 1, topic_id: 3)

## Nievel 1
Option.create(description: "50", isCorrect: false, question_id: 34)
Option.create(description: "40", isCorrect: false, question_id: 34)
Option.create(description: "45", isCorrect: true, question_id: 34)
Option.create(description: "35", isCorrect: false, question_id: 34)

Option.create(description: "21", isCorrect: false, question_id: 35)
Option.create(description: "24", isCorrect: true, question_id: 35)
Option.create(description: "28", isCorrect: false, question_id: 35)
Option.create(description: "29", isCorrect: false, question_id: 35)

Option.create(description: "$205", isCorrect: true, question_id: 36)
Option.create(description: "$150", isCorrect: false, question_id: 36)
Option.create(description: "$250", isCorrect: false, question_id: 36)
Option.create(description: "$250", isCorrect: false, question_id: 36)

Option.create(description: "9", isCorrect: false, question_id: 37)
Option.create(description: "3", isCorrect: false, question_id: 37)
Option.create(description: "16", isCorrect: false, question_id: 37)
Option.create(description: "12", isCorrect: true, question_id: 37)

Option.create(description: "56", isCorrect: true, question_id: 38)
Option.create(description: "48", isCorrect: false, question_id: 38)
Option.create(description: "64", isCorrect: false, question_id: 38)
Option.create(description: "42", isCorrect: false, question_id: 38)

Option.create(description: "64", isCorrect: false, question_id: 39)
Option.create(description: "72", isCorrect: true, question_id: 39)
Option.create(description: "81", isCorrect: false, question_id: 39)
Option.create(description: "88", isCorrect: false, question_id: 39)



## Nivel 2

Question.create(value: 3, description: "¿Cuánto es 27 multiplicado por 14?", nivel_q: 2, topic_id: 3)
Question.create(value: 3, description: "¿Cuánto es 53 multiplicado por 27?", nivel_q: 2, topic_id: 3)
Question.create(value: 3, description: "¿Cuánto es 68 multiplicado por 42?", nivel_q: 2, topic_id: 3)
Question.create(value: 3, description: "¿Cuánto es 91 multiplicado por 56?", nivel_q: 2, topic_id: 3)
Question.create(value: 3, description: "¿Cuánto es 74 multiplicado por 63?", nivel_q: 2, topic_id: 3)
Question.create(value: 3, description: "¿Cuánto es 82 multiplicado por 57?", nivel_q: 2, topic_id: 3)

Option.create(description: "372", isCorrect: false, question_id: 40)
Option.create(description: "378", isCorrect: true, question_id: 40)
Option.create(description: "384", isCorrect: false, question_id: 40)
Option.create(description: "390", isCorrect: false, question_id: 40)

Option.create(description: "1431", isCorrect: true, question_id: 41)
Option.create(description: "1437", isCorrect: false, question_id: 41)
Option.create(description: "1443", isCorrect: false, question_id: 41)
Option.create(description: "1449", isCorrect: false, question_id: 41)

Option.create(description: "2856", isCorrect: true, question_id: 42)
Option.create(description: "2862", isCorrect: false, question_id: 42)
Option.create(description: "2868", isCorrect: false, question_id: 42)
Option.create(description: "2874", isCorrect: false, question_id: 42)

Option.create(description: "5097", isCorrect: false, question_id: 43)
Option.create(description: "5096", isCorrect: true, question_id: 43)
Option.create(description: "5102", isCorrect: false, question_id: 43)
Option.create(description: "5108", isCorrect: false, question_id: 43)

Option.create(description: "4662", isCorrect: true, question_id: 44)
Option.create(description: "4668", isCorrect: false, question_id: 44)
Option.create(description: "4674", isCorrect: false, question_id: 44)
Option.create(description: "4680", isCorrect: false, question_id: 44)

Option.create(description: "4675", isCorrect: false, question_id: 45)
Option.create(description: "4674", isCorrect: true, question_id: 45)
Option.create(description: "4677", isCorrect: false, question_id: 45)
Option.create(description: "4673", isCorrect: false, question_id: 45)
## nivel 3

Question.create(value: 5, description: "¿Cuánto es 754 multiplicado por 86?", nivel_q: 3, topic_id: 3)
Question.create(value: 5, description: "¿Cuánto es 529 multiplicado por 237?", nivel_q: 3, topic_id: 3)
Question.create(value: 5, description: "¿Cuánto es 921 multiplicado por 638?", nivel_q: 3, topic_id: 3)
Question.create(value: 5, description: "¿Cuánto es 456 multiplicado por 823?", nivel_q: 3, topic_id: 3)
Question.create(value: 5, description: "¿Cuánto es 673 multiplicado por 954?", nivel_q: 3, topic_id: 3)
Question.create(value: 5, description: "¿Cuánto es 837 multiplicado por 527?", nivel_q: 3, topic_id: 3)


Option.create(description: "64864", isCorrect: false, question_id: 46)
Option.create(description: "64934", isCorrect: false, question_id: 46)
Option.create(description: "64888", isCorrect: false, question_id: 46)
Option.create(description: "64844", isCorrect: true, question_id: 46)

Option.create(description: "125373", isCorrect: true, question_id: 47)
Option.create(description: "125193", isCorrect: false, question_id: 47)
Option.create(description: "125273", isCorrect: false, question_id: 47)
Option.create(description: "125396", isCorrect: false, question_id: 47)

Option.create(description: "588798", isCorrect: false, question_id: 48)
Option.create(description: "588918", isCorrect: false, question_id: 48)
Option.create(description: "587598", isCorrect: true, question_id: 48)
Option.create(description: "587718", isCorrect: false, question_id: 48)

Option.create(description: "375088", isCorrect: false, question_id: 49)
Option.create(description: "375288", isCorrect: true, question_id: 49)
Option.create(description: "375888", isCorrect: false, question_id: 49)
Option.create(description: "375608", isCorrect: false, question_id: 49)

Option.create(description: "642042", isCorrect: true, question_id: 50)
Option.create(description: "641562", isCorrect: false, question_id: 50)
Option.create(description: "641642", isCorrect: false, question_id: 50)
Option.create(description: "641762", isCorrect: false, question_id: 50)

Option.create(description: "441399", isCorrect: false, question_id: 51)
Option.create(description: "441519", isCorrect: false, question_id: 51)
Option.create(description: "441099", isCorrect: true, question_id: 51)
Option.create(description: "441759", isCorrect: false, question_id: 51)

#Creacion de Preguntas de division

## Nivel 1

Question.create(value: 1, description: "¿Cuánto es 45 dividido por 9?", nivel_q: 1, topic_id: 4)
Question.create(value: 1, description: "¿Cuánto es 27 dividido por 3?", nivel_q: 1, topic_id: 4)
Question.create(value: 1, description: "¿Cuánto es 84 dividido por 7?", nivel_q: 1, topic_id: 4)
Question.create(value: 1, description: "¿Cuánto es 48 dividido por 6?", nivel_q: 1, topic_id: 4)
Question.create(value: 1, description: "¿Cuánto es 60 dividido por 5?", nivel_q: 1, topic_id: 4)
Question.create(value: 1, description: "¿Cuánto es 72 dividido por 9?", nivel_q: 1, topic_id: 4)

Option.create(description: "5", isCorrect: true, question_id: 52)
Option.create(description: "4", isCorrect: false, question_id: 52)
Option.create(description: "6", isCorrect: false, question_id: 52)
Option.create(description: "7", isCorrect: false, question_id: 52)

Option.create(description: "12", isCorrect: false, question_id: 53)
Option.create(description: "9", isCorrect: true, question_id: 53)
Option.create(description: "14", isCorrect: false, question_id: 53)
Option.create(description: "8", isCorrect: false, question_id: 53)

Option.create(description: "12", isCorrect: true, question_id: 54)
Option.create(description: "13", isCorrect: false, question_id: 54)
Option.create(description: "11", isCorrect: false, question_id: 54)
Option.create(description: "10", isCorrect: false, question_id: 54)

Option.create(description: "8", isCorrect: true, question_id: 55)
Option.create(description: "11", isCorrect: false, question_id: 55)
Option.create(description: "9", isCorrect: false, question_id: 55)
Option.create(description: "10", isCorrect: false, question_id: 55)

Option.create(description: "12", isCorrect: true, question_id: 56)
Option.create(description: "9", isCorrect: false, question_id: 56)
Option.create(description: "10", isCorrect: false, question_id: 56)
Option.create(description: "8", isCorrect: false, question_id: 56)

Option.create(description: "8", isCorrect: true, question_id: 57)
Option.create(description: "6", isCorrect: false, question_id: 57)
Option.create(description: "7", isCorrect: false, question_id: 57)
Option.create(description: "10", isCorrect: false, question_id: 57)


## Nivel 2

Question.create(value: 3, description: "¿Cuánto es 156 dividido por 12?", nivel_q: 2, topic_id: 4)
Question.create(value: 3, description: "¿Cuánto es 315 dividido por 21?", nivel_q: 2, topic_id: 4)
Question.create(value: 3, description: "¿Cuánto es 480 dividido por 32?", nivel_q: 2, topic_id: 4)
Question.create(value: 3, description: "¿Cuánto es 742 dividido por 17?", nivel_q: 2, topic_id: 4)
Question.create(value: 3, description: "¿Cuánto es 623 dividido por 29?", nivel_q: 2, topic_id: 4)
Question.create(value: 3, description: "¿Cuánto es 849 dividido por 37?", nivel_q: 2, topic_id: 4)

Option.create(description: "13", isCorrect: true, question_id: 58)
Option.create(description: "10", isCorrect: false, question_id: 58)
Option.create(description: "15", isCorrect: false, question_id: 58)
Option.create(description: "11", isCorrect: false, question_id: 58)

Option.create(description: "15", isCorrect: true, question_id: 59)
Option.create(description: "13", isCorrect: false, question_id: 59)
Option.create(description: "18", isCorrect: false, question_id: 59)
Option.create(description: "17", isCorrect: false, question_id: 59)

Option.create(description: "15", isCorrect: true, question_id: 60)
Option.create(description: "12", isCorrect: false, question_id: 60)
Option.create(description: "14", isCorrect: false, question_id: 60)
Option.create(description: "16", isCorrect: false, question_id: 60)

Option.create(description: "43,9", isCorrect: false, question_id: 61)
Option.create(description: "48,1", isCorrect: false, question_id: 61)
Option.create(description: "43,6", isCorrect: true, question_id: 61)
Option.create(description: "44", isCorrect: false, question_id: 61)

Option.create(description: "21,1", isCorrect: false, question_id: 62)
Option.create(description: "20,8", isCorrect: false, question_id: 62)
Option.create(description: "22,5", isCorrect: false, question_id: 62)
Option.create(description: "21,5", isCorrect: true, question_id: 62)

Option.create(description: "23,5", isCorrect: false, question_id: 63)
Option.create(description: "21", isCorrect: false, question_id: 63)
Option.create(description: "22,9", isCorrect: true, question_id: 63)
Option.create(description: "22", isCorrect: false, question_id: 63)
## Nivel 3
Question.create(value: 5, description: "¿Cuánto es 7854 dividido por 93?", nivel_q: 3, topic_id: 4)
Question.create(value: 5, description: "¿Cuánto es 6489 dividido por 187?", nivel_q: 3, topic_id: 4)
Question.create(value: 5, description: "¿Cuánto es 9283 dividido por 237?", nivel_q: 3, topic_id: 4)
Question.create(value: 5, description: "¿Cuánto es 7365 dividido por 155?", nivel_q: 3, topic_id: 4)
Question.create(value: 5, description: "¿Cuánto es 5397 dividido por 134?", nivel_q: 3, topic_id: 4)
Question.create(value: 5, description: "¿Cuánto es 8942 dividido por 193?", nivel_q: 3, topic_id: 4)

Option.create(description: "84", isCorrect: false, question_id: 64)
Option.create(description: "86,3", isCorrect: false, question_id: 64)
Option.create(description: "84,4", isCorrect: true, question_id: 64)
Option.create(description: "85", isCorrect: false, question_id: 64)

Option.create(description: "34,7", isCorrect: true, question_id: 65)
Option.create(description: "34", isCorrect: false, question_id: 65)
Option.create(description: "35", isCorrect: false, question_id: 65)
Option.create(description: "36,7", isCorrect: false, question_id: 65)

Option.create(description: "38", isCorrect: false, question_id: 66)
Option.create(description: "39.8", isCorrect: false, question_id: 66)
Option.create(description: "39.2", isCorrect: true, question_id: 66)
Option.create(description: "39.5", isCorrect: false, question_id: 66)

Option.create(description: "46,5", isCorrect: false, question_id: 67)
Option.create(description: "47", isCorrect: false, question_id: 67)
Option.create(description: "47,5", isCorrect: true, question_id: 67)
Option.create(description: "48", isCorrect: false, question_id: 67)

Option.create(description: "40", isCorrect: false, question_id: 68)
Option.create(description: "41,1", isCorrect: false, question_id: 68)
Option.create(description: "40,3", isCorrect: true, question_id: 68)
Option.create(description: "40,7", isCorrect: false, question_id: 68)

Option.create(description: "45,5", isCorrect: false, question_id: 69)
Option.create(description: "46", isCorrect: false, question_id: 69)
Option.create(description: "46,3", isCorrect: true, question_id: 69)
Option.create(description: "46,9", isCorrect: false, question_id: 69)







#Logros
Achievement.create(name: "SUG-MATH",description: "Creaste una cuenta en SUG-MATH", point: 0)
Achievement.create(name: "Primera Correcta",description: "Respondiste tu primer pregunta bien", point: 1)
Achievement.create(name: "Bien jugado",description: " Respondiste 5 respuestas correctas", point: 5)
Achievement.create(name: "Sobre Marcha",description: "Respondiste 25 respuestas correctas", point: 25)
Achievement.create(name: "3̵̠̟͇͑̿͘3̸̻̺̦͒͛̀3̴̺͑͊͜͜͝3̴̡̢̦̓͌͘3̴̡̠͚͋̐̕3̵̘͎̪̿̈́͋3̴͔͉͔͑̈́3̵̼̠̙́̈́̚3̵͔̦̒͒̕",description: "333", point: 33)
Achievement.create(name: "Dominio de matematicas",description: "Respondiste 50 respuestas correctas", point: 50)
Achievement.create(name: "Mid Matematico",description: "Respondiste 50 respuestas correctas", point: 100)
Achievement.create(name: "Capo Matematico",description: "Respondiste 50 respuestas correctas", point: 200)
Achievement.create(name: "Ya podes dar clases",description: "Respondiste 100 respuestas correctas", point: 5000)

