require "./server"

#Creacion de temas
Topic.create(nombre: "Suma" , descripcion: "La adición o suma es la operación matemática de composición que consiste en combinar o añadir dos números o más para obtener una cantidad final o total.")
Topic.create(nombre: "Resta" , descripcion: "La resta o sustracción es una operación matemática que consiste en sacar, quitar, reducir o separar algo de un todo.")
Topic.create(nombre: "Multiplicacion" , descripcion: "La multiplicación es la operación matemática que consiste en hallar el resultado de sumar un número tantas veces como indique otro.")
Topic.create(nombre: "Division" , descripcion: "Operación matemática que consiste en separar una cantidad en partes iguales, es decir, se trata de realizar una distribución equitativa del objeto o cosa que se quiere repartir")


# Creación de preguntas de suma
Question.create(value: 1, description: "¿Cuánto es 2 + 2?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "Cuanto es 2 + 8?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "¿Cuánto es 10 + 7?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "¿Cuánto es 15 + 9?", nivel_q: 1, topic_id: 1)
Question.create(value: 1, description: "¿Cuánto es 27 + 14?", nivel_q: 1, topic_id: 1)

#Respuestas
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



#Question.create(value: 5, description: "¿Cuánto es 648 + 527?", nivel_q: 2, topic_id: 1)
#Question.create(value: 5, description: "¿Cuánto es 3214 + 4987?", nivel_q: 2, topic_id: 1)
#Question.create(value: 5, description: "¿Cuánto es 15487 + 26934?", nivel_q: 2, topic_id: 1)
#Question.create(value: 5, description: "¿Cuánto es 123 + 89?", nivel_q: 2, topic_id: 1)
#Question.create(value: 5, description: "¿Cuánto es 532 + 187?", nivel_q: 2, topic_id: 1)

#Question.create(value: 10, description: "En una fiesta, se reparten 4 galletas a cada niño. Si hay 12 niños en total, ¿cuántas galletas se necesitan en total?", nivel_q: 3, topic_id: 1)
#Question.create(value: 10, description: "Un vendedor compró 10 cajas de lápices. Cada caja contiene 24 lápices. ¿Cuántos lápices compró en total?", nivel_q: 3, topic_id: 1)
#Question.create(value: 10, description: "Un agricultor tiene 3 campos de maíz. Cada campo tiene 27 hileras de maíz. Si cada hilera tiene 35 plantas de maíz, ¿cuántas plantas de maíz tiene en total?", nivel_q: 3, topic_id: 1)



#Creacion de Preguntas de Resta
Question.create(value: 1, description: "¿Cuánto es 10 - 5?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "¿Cuánto es 8 - 3?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "¿Cuánto es 15 - 7?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "Si tienes 10 manzanas y le das 3 a un amigo, ¿cuántas manzanas te quedan?", nivel_q: 1, topic_id: 2)
Question.create(value: 1, description: "Si tenías $100 en tu billetera y gastaste $35, ¿cuánto dinero te queda?", nivel_q: 1, topic_id: 2)

#Respuestas
Option.create(description: "5", isCorrect: true, question_id: 6)
Option.create(description: "3", isCorrect: false, question_id: 6)
Option.create(description: "2", isCorrect: false, question_id: 6)
Option.create(description: "7", isCorrect: false, question_id: 6)

Option.create(description: "4", isCorrect: false, question_id: 7)
Option.create(description: "3", isCorrect: false, question_id: 7)
Option.create(description: "5", isCorrect: true, question_id: 7)
Option.create(description: "6", isCorrect: false, question_id: 7)

Option.create(description: "6", isCorrect: false, question_id: 8)
Option.create(description: "7", isCorrect: false, question_id: 8)
Option.create(description: "9", isCorrect: false, question_id: 8)
Option.create(description: "8", isCorrect: true, question_id: 8)

Option.create(description: "7", isCorrect: true, question_id: 9)
Option.create(description: "6", isCorrect: false, question_id: 9)
Option.create(description: "5", isCorrect: false, question_id: 9)
Option.create(description: "4", isCorrect: false, question_id: 9)

Option.create(description: "$75", isCorrect: false, question_id: 10)
Option.create(description: "$70", isCorrect: false, question_id: 10)
Option.create(description: "$65", isCorrect: true, question_id: 10)
Option.create(description: "$60", isCorrect: false, question_id: 10)



#Creacion de Preguntas de Multiplicacion
Question.create(value: 1, description: "¿Cuánto es 9 * 5?", nivel_q: 1, topic: 3)
Question.create(value: 1, description: "Si tienes 8 amigos y cada uno de ellos tiene 3 caramelos, ¿cuántos caramelos hay en total? ", nivel_q: 1, topic_id: 3)
Question.create(value: 1, description: "Si tienes 10 billetes de $20 y 5 monedas de $1, ¿cuánto dinero tienes en total?", nivel_q: 1, topic_id: topic_id: 3)

#Respuestas
Option.create(description: "20", isCorrect: false, question_id: 11)
Option.create(description: "32", isCorrect: false, question_id: 11)
Option.create(description: "24", isCorrect: true, question_id: 11)
Option.create(description: "28", isCorrect: false, question_id: 11)

Option.create(description: "$205", isCorrect: true, question_id: 12)
Option.create(description: "$150", isCorrect: false, question_id: 12)
Option.create(description: "$250", isCorrect: false, question_id: 12)
Option.create(description: "$250", isCorrect: false, question_id: 12)
