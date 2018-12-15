defmodule Day3Part2 do
  def claim_id_with_no_overlap(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&file_row_to_claim/1)
    |> find_claim_with_no_overlap
  end

  defp file_row_to_claim(row) do
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

  def find_claim_with_no_overlap(stream) do
    claim_fields =
      stream
      |> Enum.map(&build_field_for_claim/1)

    {_, overlapping_points} =
      Enum.reduce(
        claim_fields,
        {MapSet.new(), MapSet.new()},
        fn {_claim_id, claim_field}, {all_claims, overlapping_points} ->
          {
            MapSet.union(all_claims, claim_field),
            MapSet.union(overlapping_points, MapSet.intersection(all_claims, claim_field))
          }
        end
      )

    {claim_id, _} =
      claim_fields
      |> Enum.find(fn {_claim_id, claim_field} ->
        0 == MapSet.size(MapSet.intersection(overlapping_points, claim_field))
      end)

    claim_id
  end

  def build_field_for_claim(claim) do
    Enum.reduce(Range.new(claim.x, claim.x + claim.width - 1), {claim.id, MapSet.new()}, fn x,
                                                                                            {_claim_id,
                                                                                             claim_field} ->
      claim_field_for_row =
        Enum.reduce(Range.new(claim.y, claim.y + claim.height - 1), MapSet.new(), fn y,
                                                                                     claim_field ->
          handle_point(claim_field, x, y)
        end)

      {claim.id, MapSet.union(claim_field, claim_field_for_row)}
    end)
  end

  def handle_point(claim_field, x, y) do
    MapSet.put(claim_field, {x, y})
  end
end
