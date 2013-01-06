class VesselGenerator

  def self.generate
  	Vessel.first || Vessel.create!(code: "V001", name: "Vessel one")
  end

end