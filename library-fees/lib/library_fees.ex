defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00.000])
    |> then(fn d -> d === :lt end)
  end

  def return_date(checkout_datetime) do
    return_dates = if before_noon?(checkout_datetime), do: 28, else: 29

    NaiveDateTime.add(checkout_datetime, 24 * 60 * 60 * return_dates, :second) |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    return_date = datetime_from_string(return)

    planned_return_date = return_date(checkout_date)
    charge = days_late(planned_return_date, return_date) * rate

    if monday?(return_date) do
      floor(charge * 0.5)
    else
      charge
    end
  end
end
