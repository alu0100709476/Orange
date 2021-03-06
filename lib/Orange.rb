#Practica 12
#Realizada por Miguel Aurelio García González y Juan José Gregorio Díaz Marrero.
require "Orange/version"
require 'thread'

module Orange

INCALTURA = 1
EDADMAX = 10
NUMNAR = 2
EDADMINPROD = 2
class Naranjero

	attr_accessor :altura , :edad, :contador
	def initialize()

	@altura = 0
	@edad = 0
	@contador = 0
	end
	def unoMas()
	  if(@edad >= 0 and @edad < EDADMAX )
	     @edad += 1
	     @altura  += INCALTURA 
	     contarNaranjasEdad() 
	     puts "Edad del arbol incrementada"	  
          else
	    if (@edad == EDADMAX)
	     @altura = 0
	     @contador = 0
	    puts " Arbol Muerto"
	    end
	  end

	end
        def contarNaranjasEdad

	     @contador = 0
	     aux = @edad
		while (aux > EDADMINPROD)
		  	@contador += NUMNAR
			aux -=1
		end  
	end
	def recolectarNaranjas

		if @edad >= 0
			if (@contador > 0)
				@contador-= 1
				puts "Naranja Recolectada"
		        else
				puts "No quedan mas naranjas"
			end
		else
			puts "El Naranjero esta muerto"
		end

	end
end

end

	@mutex = Mutex.new
  @vc = ConditionVariable.new
  @naranjero = Orange::Naranjero.new

 	  Thread.new do
	    until (@naranjero.edad == Orange::EDADMAX)
	      @mutex.synchronize do
		tiempo_espera = 2
		puts "El recolectador de naranjas se duerme durante #{tiempo_espera} unidades de tiempo"
		sleep(tiempo_espera)
		puts "El recolectador de naranjas se despierta después de dormir durante #{tiempo_espera} unidades de tiempo"
		@naranjero.recolectarNaranjas
		puts "El recolectador esta esperando..."
		@vc.wait(@mutex)
		
	       end
	    end
 	 end
	  Thread.new do
    	     until (@naranjero.edad == Orange::EDADMAX)
      		 @mutex.synchronize do
        	    tiempo_espera = 1
        	    puts "Incrementador de edad se va a dormir por #{tiempo_espera} unidades de tiempo"
        	    sleep(tiempo_espera)
                    puts "Incrementador de edad despierta despues de dormir por #{tiempo_espera} unidades de tiempo"
                   @naranjero.unoMas
                   @vc.signal

      	  	end
   	     end
  	end

	until (@naranjero.edad == Orange::EDADMAX)
	end

