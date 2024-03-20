defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    ceil(:math.log2(color_count))
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    s = palette_bit_size(color_count)
    <<pixel_color_index::size(s), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _) do
    nil
  end

  def get_first_pixel(picture, color_count) do
    s = palette_bit_size(color_count)
    <<head::size(s), _::bitstring>> = picture
    head
  end

  def drop_first_pixel(<<>>, _) do
    <<>>
  end

  def drop_first_pixel(picture, color_count) do
    s = palette_bit_size(color_count)

    <<_::size(s), tail::bitstring>> = picture
    tail
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
