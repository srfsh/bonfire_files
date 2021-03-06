# SPDX-License-Identifier: AGPL-3.0-only
defmodule Bonfire.Files.IconUploader do
  @doc """
  Uploader for smaller image icons, usually used as avatars.

  TODO: Support resizing.
  """

  use Bonfire.Files.Definition

  @versions [:default]

  # def transform(:original, _), do: :noaction

  def transform(:default, _) do
    max_size = 142 # TODO: configurable
    if System.find_executable("convert"), do: {:convert, "-strip -thumbnail #{max_size}x#{max_size}^ -gravity center -crop #{max_size}x#{max_size}+0+0 -limit area 50MB -limit disk 1MB"},
    else: :noaction
  end

  # def transform(:small, _) do
  #   max_size = 48 # TODO: configurable
  #   {:convert, "-strip -thumbnail #{max_size}x#{max_size} -gravity center -crop #{max_size}x#{max_size}+0+0 -limit area 50MB -limit disk 2MB"}
  # end

  def storage_dir(_, {_file, user_id}) when is_binary(user_id) do
    "data/uploads/#{user_id}/icons"
  end

  def allowed_media_types do
    Bonfire.Common.Config.get([__MODULE__, :allowed_media_types], ["image/png", "image/jpeg", "image/gif"])
  end

end
