class AviatrixData
  def self.fuel_prices
    {
      :st_louis => 1.79,
      :phoenix => 1.84,
      :denver => 1.65,
      :slc => 1.95
    }
  end

  def self.location_names
    {
      :st_louis => "St. Louis",
      :phoenix => "Phoenix",
      :denver => "Denver",
      :slc => "Salt Lake City",
      :sf => "San Francisco"
    }
  end

  def self.known_distances
    {
      :st_louis =>
        {
          :st_louis => 0,
          :phoenix  => 1260,
          :denver   => 768,
          :slc      => 1150,
          :sf       => 1730
        },
      :phoenix =>
        {
          :st_louis => 1260,
          :phoenix  => 0,
          :denver   => 601,
          :slc      => 508,
          :sf       => 650
        },
      :denver =>
        {
          :st_louis => 768,
          :phoenix  => 601,
          :denver   => 0,
          :slc      => 390,
          :sf       => 965
        },
      :slc =>
        {
          :st_louis => 1150,
          :phoenix  => 508,
          :denver   => 390,
          :slc      => 0,
          :sf       => 598
        },
        :sf =>
          {
            :st_louis => 1730,
            :phoenix  => 650,
            :denver   => 965,
            :slc      => 598,
            :sf       => 0
          }
    }
  end
end
