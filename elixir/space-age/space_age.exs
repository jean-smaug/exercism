defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  def age_on_earth(seconds) do
    seconds / 31_557_600
  end

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    case planet do
      :earth ->
        SpaceAge.age_on_earth(seconds)

      :mercury ->
        SpaceAge.age_on_earth(seconds) / 0.2408467

      :venus ->
        SpaceAge.age_on_earth(seconds) / 0.61519726

      :mars ->
        SpaceAge.age_on_earth(seconds) / 1.8808158

      :jupiter ->
        SpaceAge.age_on_earth(seconds) / 11.862615

      :saturn ->
        SpaceAge.age_on_earth(seconds) / 29.447498

      :uranus ->
        SpaceAge.age_on_earth(seconds) / 84.016846

      :neptune ->
        SpaceAge.age_on_earth(seconds) / 164.7913

      true ->
        0
    end
  end
end
