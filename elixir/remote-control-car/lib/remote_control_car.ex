defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none") do
    %RemoteControlCar{
      nickname: nickname
    }
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery}) do
    case battery do
      0 ->
        "Battery empty"

      _ ->
        "Battery at #{battery}%"
    end
  end

  def drive(
        %RemoteControlCar{
          nickname: nickname,
          distance_driven_in_meters: distance,
          battery_percentage: battery
        } = car
      ) do
    case battery do
      0 ->
        car

      _ ->
        %RemoteControlCar{
          nickname: nickname,
          distance_driven_in_meters: distance + 20,
          battery_percentage: battery - 1
        }
    end
  end
end
