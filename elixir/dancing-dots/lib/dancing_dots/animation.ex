defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}

  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_opts) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts) do
        {:ok, opts}
      end

      defoverridable(init: 1)
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation

  def handle_frame(dot, frame_number, _opts) do
    case rem(frame_number, 4) do
      0 -> Map.update!(dot, :opacity, fn prev -> prev / 2 end)
      _ -> dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = opts[:velocity]

    cond do
      is_number(velocity) ->
        {:ok, opts}

      true ->
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    %{
      dot
      | radius: dot.radius + (frame_number - 1) * opts[:velocity]
    }
  end
end
