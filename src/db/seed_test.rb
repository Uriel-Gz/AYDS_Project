require './server'

guiaSum =
  "
Definicion
--DIVISION-- La suma es la acción de añadir, juntar o agregar elementos, cuando realizamos esta acción estamos uniendo cantidades o conjuntos y para ello siempre debe haber un mínimo de dos elementos.
--PARTES-- Partes de la suma
--DIVISION-- A los números que intervienen en una suma se les denomina sumandos, al resultado de la operación lo llamamos suma o resultado. Por ejemplo, en el caso de la operación 2+8 = 10 , el 2 y el 8 son sumandos y el 10 es la suma o resultado.
"

# Creacion de tema para test
Topic.create(nombre: 'Suma',
             descripcion: 'La adición o suma es la operación matemática de composición que consiste en combinar o añadir dos números o más para obtener una cantidad final o total.', img: 'https://i.imgur.com/rMA2PnT.png', guia: guiaSum, video: 'https://www.youtube.com/embed/oF-rZLIShC8')


# Creación de pregunta para test
Question.create(value: 1, description: '¿2+2?', nivel_q: 1, topic_id: 1)

# Creacion de opciones para test
Option.create(description: '4', isCorrect: true, question_id: 1)
Option.create(description: '3', isCorrect: false, question_id: 1)
Option.create(description: '2', isCorrect: false, question_id: 1)
Option.create(description: '6', isCorrect: false, question_id: 1)

# Logro de test
Achievement.create(name: 'SUG-MATH', description: 'Creaste una cuenta en SUG-MATH', point: 0)
