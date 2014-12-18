require 'spec_helper'
require 'Orange.rb'

describe Orange do
	before :all do
		@mutex = Mutex.new
		@cv = ConditionVariable.new
		@naranjero = Orange::Naranjero.new
		Orange::Trabajo.new(@mutex, @cv, @naranjero).hacerTrabajos
		until (@naranjero.edad == Orange::EDADMAX)
  			# Esperando por todos los hilos
		end
	end
   
	it "Debe tener un método 'unoMas' para aumentar la edad y la altura del naranjero" do
		(@naranjero.respond_to? :unoMas).should == true
 	end

	it "Debe tener un método 'contarNaranjasEdad' para aumentar la edad" do
		(@naranjero.respond_to? :contarNaranjasEdad).should == true
 	end

	it "Debe tener un método 'recolectarNaranjas' para conocer la cantidad de naranjas recolectadas" do
		(@naranjero.respond_to? :recolectarNaranjas).should == true
 	end

	it "Debe tener una clase 'Naranjero'" do
		(@naranjero.is_a? Orange::Naranjero).should == true
 	end

	it "Debe tener una clase 'Trabajo'" do
		((Orange::Trabajo.new(@mutex, @cv, @naranjero)).is_a? Orange::Trabajo).should == true
 	end

	it "La clase 'Naranjero' debe tener un objeto instanciado" do
		(@naranjero.instance_of? Orange::Naranjero).should == true
	end
end
