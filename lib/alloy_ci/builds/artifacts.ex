defmodule AlloyCi.Artifacts do
  @moduledoc """
  Intermediate module for Arc and the Build Artifacts.
  Takes care of actually storing the generated artifact.
  """
  use Arc.Definition
  use Arc.Ecto.Definition

  alias AlloyCi.{Artifact, Repo}
  import Ecto.Query, warn: false

  def storage_dir(_, {_file, artifact}) do
    "uploads/artifacts/#{artifact.id}"
  end

  @spec delete_expired() :: :ok
  def delete_expired do
    Artifact
    |> where([a], a.expires_at < ^Timex.now())
    |> Repo.all()
    |> Enum.each(&delete({&1.file, &1}))
  end
end
