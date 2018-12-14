def notas
  file = File.open('alumnos.csv', 'r')
  contenido = file.readlines
  return contenido
end


#Función que saca el promedio de un arreglo
def promedio_un_arreglo(arreglo)
  suma_acum=0
  promedio = 0
  for i in 0 .. arreglo.length
    if arreglo[i].to_s.include? "A"
      suma_acum += 1
    else
      suma_acum += arreglo[i].to_i
    end
  end
  promedio = suma_acum.to_f / (arreglo.length).to_f
  promedio
end

#Recibe una cola de elementos y lo transforma a arreglo, sin considerar la cabezera
def transformar_a_arreglo(arreglo)
  arreglo_de_notas = []
  arreglo_de_notas = arreglo.pop(((arreglo.length)-1))
  arreglo_de_notas
end

def inasistencias(arreglo)
  count_no_atten = 0
  for i in 0 .. arreglo.length
    if arreglo[i].to_s.include? "A"
      count_no_atten += 1
    end
  end
   count_no_atten
end

def opcion_1()
  arreglo = []
  arreglo_2 = []
  hash_alumnos = {}
  notas.each do |elemento|
    arreglo = elemento.split(', ')
    arreglo_2 = arreglo_2 + [[arreglo[0],transformar_a_arreglo(arreglo)]]
  end
  hash_alumnos = arreglo_2.to_h
#Imprime resultado. No eliminar
  prom1 = hash_alumnos.map {|key, value|  "#{key}  #{promedio_un_arreglo(value)}"}
  print ""
  prom2 = File.open('promedios.csv', 'w')
  prom1.each {|n| prom2.puts n}
  prom2.close
end
#Fin Opcion 1.

def opcion_2()
  arreglo = []
  total_inasis = 0
  arreglo_2 = []
  hash_alumnos={}
  notas.each do |elemento|
    arreglo = elemento.split(', ')
    arreglo_2 = arreglo_2 + [[arreglo[0],transformar_a_arreglo(arreglo)]]
  end
  hash_alumnos = arreglo_2.to_h
  hash_alumnos.each { |key, value|
    total_inasis += inasistencias(value)}
    puts "Las inasistencias en total son: #{total_inasis}"
end

def opcion_3()
  nota_min = 0
  #value_1 = 0
  arreglo = []
  arreglo_2 = []
  hash_alumnos={}
  notas.each do |elemento|
    arreglo = elemento.split(', ')
    arreglo_2 = arreglo_2 + [[arreglo[0],transformar_a_arreglo(arreglo)]]
  end
  hash_alumnos = arreglo_2.to_h
  puts 'Favor ingrese promedio entre 1 y 10 (por defecto el promedio será 5.0)'
  puts ''
  nota_min = gets.chomp.to_f
    if nota_min <= 0 || nota_min >= 11
       nota_min = 5
    end
  #Imprime resultado. No eliminar
    hash_alumnos.each {|key, value|
    puts "#{key}  #{promedio_un_arreglo(value)}" if (promedio_un_arreglo(value)) >= nota_min}
end



def menu()
  puts ''
  puts 'Bienvenido al programa de consulta de notas.
Por favor escoja una opcion:'
  puts ''
  puts '1.- Ver promedio de un alumno.'
  puts '2.- Ver inasistencias.'
  puts '3.- Ver alumnos aprobados.'
  puts '4.- Salir.'
  puts ''

  opc = gets.chomp.to_i
  opc
end


#Empieza el main
opc = 0

while opc !=4
  opc = menu()
  case opc
      when 1
        opcion_1()
        puts 'Se ha creado el archivo "promedios.csv" con el promedio de cada alumno.'
      when 2
        opcion_2()
      when 3
        opcion_3()
      when 4
        puts 'Muchas gracias, adios!!!'
      else
        puts 'Opción inválida, vuelva a intentarlo.'
  end
end
