defmodule LibraryFees do
  def datetime_from_string(string) do
    string
    |> NaiveDateTime.from_iso8601()
    |> elem(1)
  end

  def before_noon?(datetime) do
    noon = datetime |> NaiveDateTime.beginning_of_day() |> NaiveDateTime.add(12, :hour)

    datetime
    |> NaiveDateTime.before?(noon)
  end

  def return_date(checkout_datetime) do
    cond do
      before_noon?(checkout_datetime) ->
        checkout_datetime |> Date.add(28)

      true ->
        checkout_datetime |> Date.add(29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    dif =
      actual_return_datetime
      |> NaiveDateTime.to_date()
      |> Date.diff(planned_return_date)

    cond do
      dif <= 0 -> 0
      true -> dif
    end
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() ==
      1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    planned_return_datetime = return_date(checkout_datetime)
    actual_return_datetime = datetime_from_string(return)
    is_monday = monday?(actual_return_datetime)

    days = days_late(planned_return_datetime, actual_return_datetime)

    cond do
      is_monday -> floor(days * rate / 2)
      true -> days * rate
    end
  end
end
