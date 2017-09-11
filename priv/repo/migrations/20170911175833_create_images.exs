defmodule ImageVac.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :vac_id, :integer
      add :url, :string
      timestamps()
    end
  end
end
