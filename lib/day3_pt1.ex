defmodule Claim do
  defstruct id: "", x: 0, y: 0, width: 0, height: 0
end

defmodule Day3Part1 do
  def find_overlapping_squares(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&file_row_to_claim/1)
    |> find_overlapping_claims
  end

  def file_row_to_claim(row) do
    values =
      Regex.named_captures(
        ~r/#(?<id>[0-9]+) @ (?<x>[0-9]+),(?<y>[0-9]+): (?<width>[0-9]+)x(?<height>[0-9]+)/,
        row
      )

    %Claim{
      id: values["id"],
      x: String.to_integer(values["x"]),
      y: String.to_integer(values["y"]),
      width: String.to_integer(values["width"]),
      height: String.to_integer(values["height"])
    }
  end

  def find_overlapping_claims(stream) do
    {_, overlapping_points} =
      stream
      |> Enum.map(&build_field_for_claim/1)
      |> Enum.reduce({MapSet.new(), MapSet.new()}, fn claim_field,
                                                      {all_claims, overlapping_points} ->
        {
          MapSet.union(all_claims, claim_field),
          MapSet.union(overlapping_points, MapSet.intersection(all_claims, claim_field))
        }
      end)

    overlapping_points
  end

  def build_field_for_claim(claim) do
    Enum.reduce(Range.new(claim.x, claim.x + claim.width - 1), MapSet.new(), fn x, claim_field ->
      claim_field_for_row =
        Enum.reduce(Range.new(claim.y, claim.y + claim.height - 1), MapSet.new(), fn y,
                                                                                     claim_field ->
          handle_point(claim_field, x, y)
        end)

      MapSet.union(claim_field, claim_field_for_row)
    end)
  end

  def handle_point(claim_field, x, y) do
    MapSet.put(claim_field, {x, y})
  end
end
