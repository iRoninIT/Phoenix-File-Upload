defmodule FileUploader.Storage.Picture do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  alias FileUploader.Storage.Picture

  schema "pictures" do
    field :image, FileUploader.Image.Type
    field :title, :string

    timestamps()
  end

  def changeset(%Picture{} = picture, attrs) do
    attrs = add_timestamp(attrs)
    picture
    |> cast(attrs, [:title])
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image, :title])
  end

  defp add_timestamp(%{"image" => %Plug.Upload{filename: name} = image} = attrs) do
    image = %Plug.Upload{image | filename: prepend_timestamp(name)}
    %{attrs | "image" => image}
  end

  defp add_timestamp(params), do: params

  defp prepend_timestamp(name) do
    "#{:os.system_time()}" <> name
  end
end
